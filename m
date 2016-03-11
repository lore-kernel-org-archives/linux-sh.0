From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Mar 2016 01:54:15 +0000
Subject: Re: [PATCH] drivers: sh: Use ARCH_RENESAS
Message-Id: <20160311015414.GB26819@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1456882987-4502-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1456882987-4502-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 07, 2016 at 01:47:36PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Mar 3, 2016 at 1:56 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Mar 03, 2016 at 09:07:13AM +0900, Simon Horman wrote:
> >> On Wed, Mar 02, 2016 at 09:25:54AM +0100, Geert Uytterhoeven wrote:
> >> > On Wed, Mar 2, 2016 at 2:43 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> >> > > Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
> >> > >
> >> > > This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> >> > > ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> >> > > appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
> >> > >
> >> > > ARCH_RENESAS should cover all cases where both CONFIG_OF and
> >> > > ARCH_SHMOBILE are enabled.
> >> > >
> >> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >> >
> >> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> >
> >> > If you intend to drop ARCH_SHMOBILE from arch/arm/mach-shmobile/Kconfig before
> >> > dropping the whole "if (...) { ... }" block below" (cfr. "drivers: sh: Stop
> >> > using the legacy clock domain on ARM",
> >> > http://www.spinics.net/lists/linux-renesas-soc/msg00869.html).
> >>
> >> At this point that is my intention.
> >
> > I have queued this patch up for v4.6.
> 
> BTW, you also have to update drivers/Makefile.

Ok, that is a bit of a tricky one as we would need (ARCH_SHMOBILE ||
ARCH_RENESAS) and I'm not sure how to express that other than by
introducing a cover-all Kconfig symbol, which is more or less the opposite
direction to where I was hoping to go with the transition to ARCH_RENESAS.

In the mean time Renesas ARM-based SoCs need to keep selecting
ARCH_SHMOBILE, which is something I was hoping to change sooner than later.

I think your patches at the link above neatly resolve this. At least for
sh-drives. Perhaps I need to convince myself there is no fallout from
patches 1 and 2 of that series and go ahead and queue up patches 3 and 4.
