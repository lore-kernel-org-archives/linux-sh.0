From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 06 Aug 2014 08:46:39 +0000
Subject: Re: [PATCH 5/6] dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver
Message-Id: <CAMuHMdW8Vhn1R6tmP20m2HzE=0X2uO0DqGV-F3pjRF1GRHY49g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <7ae1dbb4f4a79a529250600cc2eeb7c31a644938.1406766014.git.horms+renesas@verge.net.au>
In-Reply-To: <7ae1dbb4f4a79a529250600cc2eeb7c31a644938.1406766014.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 31, 2014 at 2:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- a/drivers/dma/sh/Kconfig
> +++ b/drivers/dma/sh/Kconfig
> @@ -52,3 +52,11 @@ config RCAR_AUDMAC_PP
>         depends on SH_DMAE_BASE
>         help
>           Enable support for the Renesas R-Car Audio DMAC Peripheral Peripheral controllers.
> +
> +config RCAR_DMAC
> +       tristate "Renesas R-Car Gen2 DMA Controller"
> +       depends on ARCH_SHMOBILE || COMPILE_TEST
> +       select DMA_ENGINE
> +       help
> +         This driver supports the general purpose DMA controller found in the
> +         Renesas R-Car second generator SoCs.

generation

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
