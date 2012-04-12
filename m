From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 12 Apr 2012 10:13:29 +0000
Subject: Re: [PATCH 0/7 v2] ARM: mach-shmobile: add Armadillo800eva board support
Message-Id: <87bomx2r7f.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Thank you for testing patches.

> > Kuninori Morimoto (7):
> >       ARM: mach-shmobile: pfc-r8a7740: add gpio_irq support
> >       ARM: mach-shmobile: add armadillo800eva board support.
> >       ARM: mach-shmobile: armadillo800eva: add defconfig
> >       ARM: mach-shmobile: armadillo800eva: add support LCDC0
> >       ARM: mach-shmobile: armadillo800eva: add support ST1232
> >       ARM: mach-shmobile: armadillo800eva: add support gpio_key
> >       ARM: mach-shmobile: armadillo800eva: add support sh_eth
> 
> I have tested all of the patches above, except
> "ARM: mach-shmobile: armadillo800eva: add support ST1232",
> against 3.4-rc2. For those six patches:
> 
> 	Tested-by: Simon Horman <horms@verge.net.au>
> 
> I have also booted a kernel with "ARM: mach-shmobile: armadillo800eva: add
> support ST1232", however I am unable to exercise this code as I am having
> trouble bringing up an Android user-space. Tips on how the code might
> be exercised would be greatly. appreciated.

I'm not sure about Android user-space, but I tested ST1232 by
below tmenu on normal Linux user-space.

https://github.com/morimoto/smenu

# tmenu /dev/input/eventX

Best regards
---
Kuninori Morimoto
