From: Simon Horman <horms@verge.net.au>
Date: Tue, 05 Mar 2013 06:56:52 +0000
Subject: Re: SDHI and MMCIF with kzm9g-reference
Message-Id: <20130305065649.GD9711@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130301110802.GB24364@verge.net.au>
In-Reply-To: <20130301110802.GB24364@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[ CC Paul ]

On Mon, Mar 04, 2013 at 10:00:39PM +0900, Simon Horman wrote:
> On Mon, Mar 04, 2013 at 09:55:56PM +0900, Magnus Damm wrote:
> > Hi Simon,
> > 
> > On Fri, Mar 1, 2013 at 9:28 PM, Simon Horman <horms@verge.net.au> wrote:
> > > [ Cc Magnus ]
> > >
> > > Hi Guennadi,
> > >
> > > On Fri, Mar 01, 2013 at 12:34:53PM +0100, Guennadi Liakhovetski wrote:
> > >> Hi Simon
> > >>
> > >> On Fri, 1 Mar 2013, Simon Horman wrote:
> > >>
> > >> > Hi Guennadi,
> > >> >
> > >> > this is a heads-up about the state of SDHI and MMCIF with kzm9g-reference
> > >> > in the current next and topic/all+next branches.
> > >> >
> > >> > Currently the boot will not complete. It stalls in SDHI or MMCIF
> > >> > initialisation (whichever comes first), though it doesn't say so.
> > >> >
> > >> > The reason is msleep() calls. In the case of SDHI in the driver itself.
> > >> > In the case of MMCIF in the MMC core code.
> > >> >
> > >> > I had the following patch in next for a while but removed it a few days
> > >> > ago because for some reason I thought my tests showed it was no longer needed.
> > >> > I now believe it is needed and I will put it back into next and
> > >> > topic/all+next ASAP. I do not plan to make any other changes to my branches
> > >> > in what is left of today for me.
> > >>
> > >> Hmm, interesting. You've got mmcif and sdhi drivers compiled in, looks
> > >> like, not as modules.
> > >
> > > Yes, compiled-in. No modules. As per the defconfig.
> > >
> > >> You know, core driver people (gkh et al.) are pretty
> > >> sensitive to the top-level Makefile changes like this. They affect
> > >> everyone and violate the general principle - we shouldn't depend on the
> > >> link order...
> > >
> > > I'm not very keen on the change. And if not depending on linking
> > > order is a rule, then we have a problem. I'll leave the patch out
> > > of my tree for now.
> > >
> > >> My question to this though - you say kzm9g-reference is
> > >> affected. Does it mean kzm9g with devices initialised from C code is ok?
> > >> Maybe we could try to find what the difference is?
> > >
> > > The difference is the way that clock sources and timers are initialised,
> > > though I've never quite understood if its only one of them that
> > > leads to the problem or not.
> > >
> > > In the current scheme there are no early devices for kzm9g and no early
> > > timers. If, for example using the following small patch, I switch things
> > > around to use early device initialisation for the CMT clock source and
> > > early timers, then probing MMCIF and SDHI works. If not then there is the
> > > problem I describe above.
> > >
> > > The reason that the code is like it is and not the way it would be
> > > with the patch below (errors aside), is because Magnus specifically
> > > asked for no early devices or early timers.
> > 
> > Thanks for making sure that we're not enabling early timers when it is
> > unclear if we really need to.
> 
> Thanks for reviewing the situation.
> 
> > Would it be possible for you to check if the timer drivers (CMT, TMU)
> > get probe():d before the MMC drivers?
> 
> My analysis is that the clock sources are probed after MMCIF and SDHI.
> 
> > If not then perhaps it is
> > possible to adjust the order they are being added as platform devices
> > or the initcall level for the actual drivers. Using early devices may
> > be just a too big hammer from my POV.
> 
> Sorry for not posting an update with regards to this earlier.
> 
> I had some discussions with Paul about this earlier today and he
> made the same suggestion. I plan to test this idea tomorrow and at
> this stage I expect that test to be successful.

The following seems to work:

From: Simon Horman <horms+renesas@verge.net.au>

clocksource: sh_cmt: Set initcall level to subsys

The reason for this is to ensure that CMT is probed earlier
than with its previous initcall level, module init.

This came up as a problem with using kzm9g-reference which does
not make use of early timers or devices. In that scenario initialisation
of SDHI and MMCIF both stall on msleep() calls due to the absence
of a initialised clock source.

Boot tested on: armadillo800eva, mackerel and kzm9g

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index b72b724..08d0c41 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -838,7 +838,7 @@ static void __exit sh_cmt_exit(void)
 }
 
 early_platform_init("earlytimer", &sh_cmt_device_driver);
-module_init(sh_cmt_init);
+subsys_initcall(sh_cmt_init);
 module_exit(sh_cmt_exit);
 
 MODULE_AUTHOR("Magnus Damm");
