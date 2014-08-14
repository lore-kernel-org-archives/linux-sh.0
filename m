From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Aug 2014 23:05:22 +0000
Subject: Re: [PATCH 0/7] ARM: shmobile: defconfigs: Enable missing hardware support
Message-Id: <20140814230519.GH2029@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1408035448-8811-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1408035448-8811-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 15, 2014 at 06:27:32AM +0900, Simon Horman wrote:
> On Thu, Aug 14, 2014 at 06:57:21PM +0200, Geert Uytterhoeven wrote:
> > This patch series enables missing hardware support in the various shmobile
> > defconfigs, based on the DTSes.
> > 
> > This was done with the help of an experimental script to derive
> > CONFIG-options from a DTS or DTB, with some manual work to handle the
> > script's deficiencies.
> > 
> > Shmobile_defconfig and koelsch_defconfig have been booted successfully
> > on r8a7791/koelsch.
> 
> Nice.
> 
> Unfortunately I'm not in a position to test larger but I will test the rest.

I tested all but the lager and they all looked good.
I have queued-up all of the changes.

> > Geert Uytterhoeven (7):
> >   ARM: shmobile: shmobile_defconfig: Enable missing hardware support
> >   ARM: shmobile: ape6evm_defconfig: Enable missing hardware support
> >   ARM: shmobile: bockw_defconfig: Enable missing hardware support
> >   ARM: shmobile: koelsch_defconfig: Enable missing hardware support
> >   ARM: shmobile: kzm9g_defconfig: Enable missing hardware support
> >   ARM: shmobile: lager_defconfig: Enable missing hardware support
> >   ARM: shmobile: marzen_defconfig: Enable missing hardware support
> > 
> >  arch/arm/configs/ape6evm_defconfig  |  9 ++++++++-
> >  arch/arm/configs/bockw_defconfig    |  2 ++
> >  arch/arm/configs/koelsch_defconfig  | 17 +++++++++++++++++
> >  arch/arm/configs/kzm9g_defconfig    |  1 +
> >  arch/arm/configs/lager_defconfig    |  8 +++++++-
> >  arch/arm/configs/marzen_defconfig   |  1 +
> >  arch/arm/configs/shmobile_defconfig |  2 ++
> >  7 files changed, 38 insertions(+), 2 deletions(-)
> > 
> > Gr{oetje,eeting}s,
> > 
> > 						Geert
> > 
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> > 							    -- Linus Torvalds
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
