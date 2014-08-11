From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Aug 2014 02:56:28 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: Add clocks to DTS
Message-Id: <20140811025624.GB9181@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1407399130-14020-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1407399130-14020-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 11, 2014 at 10:27:21AM +0900, Simon Horman wrote:
> On Fri, Aug 08, 2014 at 08:15:35PM +0900, Magnus Damm wrote:
> > On Thu, Aug 7, 2014 at 5:12 PM, Ulrich Hecht
> > <ulrich.hecht+renesas@gmail.com> wrote:
> > > Declares the r8a7740 clocks supported by the legacy clock framework,
> > > excluding those requiring extensions to the DIV6 driver, as well as
> > > the Armadillo800-specific overrides.
> > >
> > > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > > ---
> > >
> > > Hi!
> > >
> > > This one omits the funky DIV6 clocks because the corresponding changes to
> > > the clock driver have not been accepted yet.  It should not have any
> > > negative impact on legacy support.
> > 
> > Hi Ulrich and Simon,
> > 
> > Thanks for your patch and review help. I've now spent some time giving
> > a try on top of:
> > 
> > renesas-devel-v3.16-20140808
> > [PATCH] ARM: shmobile: Partial build of pm-rmobile.c for multiplatform
> > [PATCH] ARM: shmobile: r8a7740: Multiplatform support
> > 
> > It seems that a couple of more changes are needed for the DTS and C to
> > boot the system, please see the mangled patch below for prototype
> > level example code.
> > 
> > Basically, to be able to boot the SCIF console needs to get clocks
> > assigned to it and the CMT needs to go from platform device to DT.
> > Actually, most leaf node MSTP clock assignment seems to be missing. I
> > maybe wrong, but I suspect some MSTP clock assignment can happen
> > before the DIV6 change gets in.
> > 
> > Ulrich, please work together with Simon to finalize the code! It is of
> > course up to you guys to decide how to split it, but perhaps Ulrich
> > can handle the clock assignment for the SCIF and other devices while
> > Simon gets to covert the CMT and TMU over. I've attached the
> > configuration I used to test your patch on top of the two above and
> > the local change below, hope it helps!
> > 
> > After this we need to merge the DTS for legacy and reference board
> > support. And build the DTB in case of Multiplatform. Then we should be
> > ready to kill of the DT reference C code. Not so far away!
> 
> Strange. Some how I missed r8a7740 when I did a sweep to enable timers
> via DT. Sorry about that. I'll clean up the below a bit and submit it
> as a patchset.

After a false start I have sent this as:
[PATCH repost 0/5] ARM: shmobile: armadillo800eva-reference: Enable CMT1 in device tree

