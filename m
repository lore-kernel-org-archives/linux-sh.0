From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 14 Mar 2014 14:26:45 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: koelsch-reference: Work around core clock issues
Message-Id: <1855028.8qY8ijbbfB@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Friday 14 March 2014 14:13:59 Ben Dooks wrote:
> On 14/03/14 12:43, Laurent Pinchart wrote:
> > On Friday 14 March 2014 13:39:43 Geert Uytterhoeven wrote:
> >> On Fri, Mar 14, 2014 at 12:10 PM, Ben Dooks wrote:
> >>> On 14/03/14 11:02, Laurent Pinchart wrote:
> >>>> On Thursday 13 March 2014 15:29:30 Geert Uytterhoeven wrote:
> >>>>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> >>>>> 
> >>>>> Due to issues with runtime PM clock management, clocks not explicitly
> >>>>> managed by their drivers may not be enabled at all, or be
> >>>>> inadvertently disabled by the clk_disable_unused() late initcall.
> >>>>> 
> >>>>> Until this is fixed, add a temporary workaround, calling
> >>>>> shmobile_clk_workaround() with enable = true.
> >>>>> 
> >>>>> For now this enables the clocks for: ether, i2c2, msiof0, qspi_mod,
> >>>>> and thermal. More clocks can be added if needed.
> >>>> 
> >>>> This should do the job, but as you mentioned, it's a crude hack. As
> >>>> we're targeting v3.16, is there a chance we could fix the problem
> >>>> properly instead ?
> >> 
> >> Of course the goal is to fix it for real, so the crude hack will no
> >> longer be needed. But for now, it looks like a good short-term
> >> workaround.
> >> 
> >>> The best fix would be to re-enable the PM and find out what is
> >> 
> >> Sure, but in a multiplatform-aware way.
> > 
> > Of course. Are you working on that, or should I give it a try ? Would you
> > like to discuss this ?
> 
> I did send a patch to try and re-enable the drivers/sh build for
> the shmobile pm_runtime code. I will try and re-look at this over
> the weekend once I have sorted out the other work I have been trying
> to get done.

I remember that. If I'm not mistaken the issue was that we code would register 
the Renesas pm clock notifier on non-Renesas platforms when running a multi-
platform kernel.

I'm wondering whether the approach proposed by Felipe Balbi in 
https://lkml.org/lkml/2014/1/31/290 wouldn't be a better solution than custom 
code. I have a few concerns with the proposed patch but nothing that can't be 
solved.

Could you please coordinate with Geert (as I believe he's working on this) and 
Felipe ? Feel free to CC me. I can also be available for a chat on IRC if 
needed.

> >>> actually causing the external abort. However currently there is
> >>> no information in the manuals about anything we could find out from
> >>> the AXI busses as to what the source actually is.
> >> 
> >> I re-applied your patch "ARM: shmobile: compile drivers/sh for
> >> CONFIG_ARCH_SHMOBILE_MULTI", and surprisingly, I no longer get the
> >> external abort.
> >> 
> >> Some experimenting revealed it's due to the "ether" clock in the
> >> clk_enables[] array. As long as that's enabled early, the system seems to
> >> boot fine with your patch.
> > 
> > At what point do you get the external abort without the ether clock
> > workaround ?
> 
> I thought it was early in the sequence but it seems to be coming sometime
> after init is started.

-- 
Regards,

Laurent Pinchart

