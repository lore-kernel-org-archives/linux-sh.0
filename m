From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Nov 2013 00:43:46 +0000
Subject: Re: [PATCH 0/16] SDHI support for r8a7790
Message-Id: <87ob5faon5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org


Hi Simon, Chris, Laurent

I will send v2 patch series for these patches.
At that time, these are separated into small patch-set,
not full-patch-set.

> These are SDHI support for r8a7790.
> But, these are
> 
> 1. bug fix patchset for mmc/sdhi
> 2. bug fix for SH-ARM
> 3. new feature for mmc
> 4. new feature for SH-ARM
> 
> all these patches are needed, but, to different maintainer.
> I send these with separate set
> 
> Kuninori Morimoto (14):
>       gpio: rcar: use postcore_init()
>       mmc: tmio: don't overwrite caps2
>       ARM: shmobile: marzen: remove SDHI0 WP pin setting from DTS
>       ARM: shmobile: marzen: remove SDHI0 WP pin setting
>       ARM: shmobile: sh73a0: fixup sdhi compatible name
>       mmc: tmio: bus_shift become tmio_mmc_data member
>       mmc: tmio: add new TMIO_MMC_HAVE_HIGH_REG flags
>       mmc: SDHI: add SoC specific workaround via HW version
>       mmc: SDHI: tidyup sh_mobile_sdhi_of_match position
>       mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7778
>       mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7779
>       mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7790
>       ARM: shmobile: lager: add SDHI0/2 support
>       ARM: shmobile: lager: use gpio/fixed regulator for SDHI
> 
> Shinobu Uehara (2):
>       mmc: tmio: Fix odd size access
>       mmc: tmio: Add error IRQ status clear
> 
>  arch/arm/boot/dts/r8a7778-bockw-reference.dts  |    4 +-
>  arch/arm/boot/dts/r8a7778.dtsi                 |    6 -
>  arch/arm/boot/dts/r8a7779-marzen-reference.dts |    3 +-
>  arch/arm/boot/dts/r8a7779.dtsi                 |    8 --
>  arch/arm/boot/dts/sh73a0.dtsi                  |    6 +-
>  arch/arm/mach-shmobile/board-lager.c           |  144 +++++++++++++++++++++++-
>  arch/arm/mach-shmobile/board-marzen.c          |    2 -
>  arch/sh/boards/board-sh7757lcr.c               |    2 +-
>  drivers/gpio/gpio-rcar.c                       |   12 +-
>  drivers/mmc/host/sh_mobile_sdhi.c              |   60 +++++++---
>  drivers/mmc/host/tmio_mmc.c                    |    9 ++
>  drivers/mmc/host/tmio_mmc.h                    |   17 ++-
>  drivers/mmc/host/tmio_mmc_dma.c                |    2 +-
>  drivers/mmc/host/tmio_mmc_pio.c                |   28 ++---
>  include/linux/mfd/tmio.h                       |    8 ++
>  include/linux/mmc/tmio.h                       |    1 +
>  16 files changed, 247 insertions(+), 65 deletions(-)


Best regards
---
Kuninori Morimoto
