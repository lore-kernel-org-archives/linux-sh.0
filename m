From: Simon Horman <horms@verge.net.au>
Date: Thu, 01 May 2014 04:58:06 +0000
Subject: Re: [PATCH] drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI
Message-Id: <20140501045806.GC31620@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1398906582-29888-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1398906582-29888-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 01, 2014 at 06:42:18AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, May 1, 2014 at 6:27 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, May 01, 2014 at 03:09:42AM +0200, Geert Uytterhoeven wrote:
> >> If the kernel is built to support multi-ARM configuration with shmobile
> >> support built in, then drivers/sh is not built. This contains the PM
> >> runtime code in drivers/sh/pm_runtime.c, which implicitly enables the
> >> module clocks for all devices, and thus is quite essential.
> >> Without this, the state of clocks depends on implicit reset state, or on
> >> the bootloader.
> >>
> >> If ARCH_SHMOBILE_MULTI then build the drivers/sh directory, but ensure that
> >> bits that may conflict (drivers/sh/clk if the common clock framework is
> >> enabled) or are not used (drivers/sh/intc), are not built.
> >> Also, only enable the PM runtime code when actually running on a shmobile
> >> SoCs that needs it.
> >>
> >> ARCH_SHMOBILE_MULTI was added a while ago by commit
> >> efacfce5f8a523457e9419a25d52fe39db00b26a ("ARM: shmobile: Introduce
> >> ARCH_SHMOBILE_MULTI"), but drivers/sh was compiled for both
> >> ARCH_SHMOBILE_LEGACY and ARCH_SHMOBILE_MULTI until commit
> >> bf98c1eac1d4a6bcf00532e4fa41d8126cd6c187 ("ARM: Rename ARCH_SHMOBILE to
> >> ARCH_SHMOBILE_LEGACY").
> >>
> >> Inspired by a patch from Ben Dooks <ben.dooks@codethink.co.uk>.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >> This is a minimal solution to fix the issue for multi-platform shmobile
> >> kernels in a multi-platform-friendly way.
> >> As it touches drivers/sh-specific code only, Simom should still be able to
> >> get it in v3.15, and backported to v3.14-stable.
> >>
> >> This is an RFC for several reasons:
> >>   1. I'm at ELC, and away from my hardware to test it properly (also on
> >>      non-shmobile).
> >>   2. Can we already reduce the list of SoCs to check for?
> >>      E.g. is this needed for emev2, which doesn't have MSTP clocks?
> 
> According to Magnus, emev2 doesn't rely on Runtime PM, so it can be
> removed from the list.
> 
> > I will answer a related question: "Simon, can you test this?".
> 
> ;-)
> 
> > If its just a matter of testing that the board still boots to user-space
> 
> Preferably after removing the clk_enables[] workarounds, and with MSTP
> disable patches ;-)

Ok, assuming such patches exist :)

> > I can do so without too much effort for most shmobile boards including
> > the emev2 based kzm9g. The exceptions are:
> >
> > * The r7s72100 based genmai
> >   - I think you have access to that
> > * The r8a7791 based henniger board.
> >   - I do have access to a koelsh board which is bsed on the same SoC
> 
> Well, we shouldn't rush to get it in. 3.15 is still a few weeks away...

Agreed.

> I can test it on Koelsch, Genmai, BeagleBone Black, and Armadillo after
> ELC.
> 
> > If the testing is a bit more involved then I don't have an automation
> > set up for it at this stage. That makes testing a bit more difficult
> > for me. Especially as I am going on holidays tomorrow.
> 
> Sure, I understand. Enjoy your holidays! After which rc will you return?

I expect to be back around rc5.
Or in more concrete terms, on the 13th.

> > Of course there is the caveat that a number of SoCs and their boards do
> > not support multiplatform yet.
> 
> Yep. But as long as there are no typos in the compatible checks, testing
> well on one shmobile board and one non-shmobile board should suffice,
> right?

Most likely.
