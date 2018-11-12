From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Nov 2018 15:30:29 +0000
Subject: Re: [PATCH/RFC] dmaengine: sh: Remove R-Mobile APE6 support
Message-Id: <CAMuHMdVV+NnwX+4o19wyF6GVF7Xk52nDyruJLfAfzvAMPhrcKQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Vinod <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, dmaengine@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Richard Weinberger <richard@nod.at>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>

CC SuperH

On Mon, Nov 12, 2018 at 4:22 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Renesas R-Mobile APE6 support is currently unused:
>   - DMA slaves were never enabled in r8a73a4.dtsi,
>   - The driver relies on legacy filter matching and describing all
>     slaves and MID/RIDs in a table, unlike modern DMA engine drivers for
>     similar hardware like rcar-dmac,
>   - The driver doesn't seem to work well.
>
> Remove the driver, it can be resurrected from git history when needed.
>
> As this was the last user of SH_DMAE_BASE on Renesas ARM SoCs, the
> sh-dma-engine driver core is now used on SuperH only.
>
> Note that the DT bindings are still present, as r8a73a4.dtsi uses them.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Notes:
>   1. As Renesas ARM SoCs no longer use drivers/dma/sh/shdma-base.c, the
>      task to remove use of the deprecated dma_slave_config.direction
>      field gets thrown into the SuperH maintainers' basket ;-)
>   2. This affects shmobile_defconfig and renesas_defconfig
>      (CONFIG_SH_DMAE_BASE and CONFIG_SH_DMAE are no longer enabled by
>      default).
>   3. I tried to get SCIFA DMA to work by:
>        - Applying the DT and driver patches below,
>        - Reverting 219fb0c1436e4893 ("serial: sh-sci: Remove the
>          platform data dma slave rx/tx channel IDs").
>      After that, serial console output using DMA seems to work, but the
>      system locks up when receiving any serial console input.
>      Probably it is easier to add r8a73a4 support to rcar-dmac.
>
> ignore  --- a/arch/arm/boot/dts/r8a73a4.dtsi
> ignore  +++ b/arch/arm/boot/dts/r8a73a4.dtsi
>         @@ -453,6 +453,8 @@
>                         interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&mstp2_clks R8A73A4_CLK_SCIFA0>;
>                         clock-names = "fck";
>         +               dmas = <&dmac 0x21>, <&dmac 0x22>;
>         +               dma-names = "tx", "rx";
>                         power-domains = <&pd_a3sp>;
>                         status = "disabled";
>                 };
> ignore  --- a/drivers/dma/sh/shdma-r8a73a4.c
> ignore  +++ b/drivers/dma/sh/shdma-r8a73a4.c
>         @@ -12,6 +12,12 @@ static const unsigned int dma_ts_shift[] = SH_DMAE_TS_SHIFT;
>
>          static const struct sh_dmae_slave_config dma_slaves[] = {
>                 {
>         +               .chcr           = CHCR_TX(XMIT_SZ_8BIT),
>         +               .mid_rid        = 0x21,         /* SCIFA0 Tx */
>         +       }, {
>         +               .chcr           = CHCR_RX(XMIT_SZ_8BIT),
>         +               .mid_rid        = 0x22,         /* SCIFA0 Rx */
>         +       }, {
>                         .chcr           = CHCR_TX(XMIT_SZ_32BIT),
>                         .mid_rid        = 0xd1,         /* MMC0 Tx */
>                 }, {
> ---
>  drivers/dma/sh/Kconfig         | 11 +----
>  drivers/dma/sh/Makefile        |  1 -
>  drivers/dma/sh/shdma-r8a73a4.c | 74 ----------------------------------
>  drivers/dma/sh/shdma.h         |  7 ----
>  drivers/dma/sh/shdmac.c        |  7 ----
>  5 files changed, 1 insertion(+), 99 deletions(-)
>  delete mode 100644 drivers/dma/sh/shdma-r8a73a4.c
>
> diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
> index 6e0685f1a83814f4..b728cfaf4d700f96 100644
> --- a/drivers/dma/sh/Kconfig
> +++ b/drivers/dma/sh/Kconfig
> @@ -12,7 +12,7 @@ config RENESAS_DMA
>
>  config SH_DMAE_BASE
>         bool "Renesas SuperH DMA Engine support"
> -       depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> +       depends on SUPERH || COMPILE_TEST
>         depends on !SUPERH || SH_DMA
>         depends on !SH_DMA_API
>         default y
> @@ -30,15 +30,6 @@ config SH_DMAE
>         help
>           Enable support for the Renesas SuperH DMA controllers.
>
> -if SH_DMAE
> -
> -config SH_DMAE_R8A73A4
> -       def_bool y
> -       depends on ARCH_R8A73A4
> -       depends on OF
> -
> -endif
> -
>  config RCAR_DMAC
>         tristate "Renesas R-Car Gen2 DMA Controller"
>         depends on ARCH_RENESAS || COMPILE_TEST
> diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
> index 7d7c9491ade1216d..42110dd57a56fda8 100644
> --- a/drivers/dma/sh/Makefile
> +++ b/drivers/dma/sh/Makefile
> @@ -10,7 +10,6 @@ obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o shdma-of.o
>  #
>
>  shdma-y := shdmac.o
> -shdma-$(CONFIG_SH_DMAE_R8A73A4) += shdma-r8a73a4.o
>  shdma-objs := $(shdma-y)
>  obj-$(CONFIG_SH_DMAE) += shdma.o
>
> diff --git a/drivers/dma/sh/shdma-r8a73a4.c b/drivers/dma/sh/shdma-r8a73a4.c
> deleted file mode 100644
> index ddc9a35783534bdd..0000000000000000
> --- a/drivers/dma/sh/shdma-r8a73a4.c
> +++ /dev/null
> @@ -1,74 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Renesas SuperH DMA Engine support for r8a73a4 (APE6) SoCs
> - *
> - * Copyright (C) 2013 Renesas Electronics, Inc.
> - */
> -#include <linux/sh_dma.h>
> -
> -#include "shdma-arm.h"
> -
> -static const unsigned int dma_ts_shift[] = SH_DMAE_TS_SHIFT;
> -
> -static const struct sh_dmae_slave_config dma_slaves[] = {
> -       {
> -               .chcr           = CHCR_TX(XMIT_SZ_32BIT),
> -               .mid_rid        = 0xd1,         /* MMC0 Tx */
> -       }, {
> -               .chcr           = CHCR_RX(XMIT_SZ_32BIT),
> -               .mid_rid        = 0xd2,         /* MMC0 Rx */
> -       }, {
> -               .chcr           = CHCR_TX(XMIT_SZ_32BIT),
> -               .mid_rid        = 0xe1,         /* MMC1 Tx */
> -       }, {
> -               .chcr           = CHCR_RX(XMIT_SZ_32BIT),
> -               .mid_rid        = 0xe2,         /* MMC1 Rx */
> -       },
> -};
> -
> -#define DMAE_CHANNEL(a, b)                             \
> -       {                                               \
> -               .offset         = (a) - 0x20,           \
> -               .dmars          = (a) - 0x20 + 0x40,    \
> -               .chclr_bit      = (b),                  \
> -               .chclr_offset   = 0x80 - 0x20,          \
> -       }
> -
> -static const struct sh_dmae_channel dma_channels[] = {
> -       DMAE_CHANNEL(0x8000, 0),
> -       DMAE_CHANNEL(0x8080, 1),
> -       DMAE_CHANNEL(0x8100, 2),
> -       DMAE_CHANNEL(0x8180, 3),
> -       DMAE_CHANNEL(0x8200, 4),
> -       DMAE_CHANNEL(0x8280, 5),
> -       DMAE_CHANNEL(0x8300, 6),
> -       DMAE_CHANNEL(0x8380, 7),
> -       DMAE_CHANNEL(0x8400, 8),
> -       DMAE_CHANNEL(0x8480, 9),
> -       DMAE_CHANNEL(0x8500, 10),
> -       DMAE_CHANNEL(0x8580, 11),
> -       DMAE_CHANNEL(0x8600, 12),
> -       DMAE_CHANNEL(0x8680, 13),
> -       DMAE_CHANNEL(0x8700, 14),
> -       DMAE_CHANNEL(0x8780, 15),
> -       DMAE_CHANNEL(0x8800, 16),
> -       DMAE_CHANNEL(0x8880, 17),
> -       DMAE_CHANNEL(0x8900, 18),
> -       DMAE_CHANNEL(0x8980, 19),
> -};
> -
> -const struct sh_dmae_pdata r8a73a4_dma_pdata = {
> -       .slave          = dma_slaves,
> -       .slave_num      = ARRAY_SIZE(dma_slaves),
> -       .channel        = dma_channels,
> -       .channel_num    = ARRAY_SIZE(dma_channels),
> -       .ts_low_shift   = TS_LOW_SHIFT,
> -       .ts_low_mask    = TS_LOW_BIT << TS_LOW_SHIFT,
> -       .ts_high_shift  = TS_HI_SHIFT,
> -       .ts_high_mask   = TS_HI_BIT << TS_HI_SHIFT,
> -       .ts_shift       = dma_ts_shift,
> -       .ts_shift_num   = ARRAY_SIZE(dma_ts_shift),
> -       .dmaor_init     = DMAOR_DME,
> -       .chclr_present  = 1,
> -       .chclr_bitwise  = 1,
> -};
> diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
> index bfb69909bd192759..9c121a4b33ad829c 100644
> --- a/drivers/dma/sh/shdma.h
> +++ b/drivers/dma/sh/shdma.h
> @@ -58,11 +58,4 @@ struct sh_dmae_desc {
>  #define to_sh_dev(chan) container_of(chan->shdma_chan.dma_chan.device,\
>                                      struct sh_dmae_device, shdma_dev.dma_dev)
>
> -#ifdef CONFIG_SH_DMAE_R8A73A4
> -extern const struct sh_dmae_pdata r8a73a4_dma_pdata;
> -#define r8a73a4_shdma_devid (&r8a73a4_dma_pdata)
> -#else
> -#define r8a73a4_shdma_devid NULL
> -#endif
> -
>  #endif /* __DMA_SHDMA_H */
> diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
> index 7971ea2753877486..5aafe548ca5f3082 100644
> --- a/drivers/dma/sh/shdmac.c
> +++ b/drivers/dma/sh/shdmac.c
> @@ -665,12 +665,6 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
>         .get_partial = sh_dmae_get_partial,
>  };
>
> -static const struct of_device_id sh_dmae_of_match[] = {
> -       {.compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid,},
> -       {}
> -};
> -MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
> -
>  static int sh_dmae_probe(struct platform_device *pdev)
>  {
>         const enum dma_slave_buswidth widths > @@ -915,7 +909,6 @@ static struct platform_driver sh_dmae_driver = {
>         .driver         = {
>                 .pm     = &sh_dmae_pm,
>                 .name   = SH_DMAE_DRV_NAME,
> -               .of_match_table = sh_dmae_of_match,
>         },
>         .remove         = sh_dmae_remove,
>  };
> --
> 2.17.1
