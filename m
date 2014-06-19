From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Jun 2014 10:15:03 +0000
Subject: Re: [PATCH 7/8] ARM: shmobile: r8a7790: add dmac0 dmac1 nodes
Message-Id: <CAMuHMdX4hZZqAjxmDjfcCTuBTjFG=-zivbB5X8BTzSOsJD0rDQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401898455-31064-8-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1401898455-31064-8-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Wed, Jun 4, 2014 at 6:14 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Add nodes for the SYS-DMA controllers, SYS-DMAC0 and SYS-DMAC1. These
> both share the same device sources, so are wrapped in the shdma-mux
> node to allow both to be used.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index e8ca55d..c63d915 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -87,6 +87,78 @@
>                 };
>         };
>
> +       dma0: dma-mux@0 {
> +               compatible = "renesas,shdma-mux";
> +               #dma-cells = <1>;

Shouldn't this be "#dma-cells = <2>"? The second value holds the mid/rid value,
cfr. "[PATCH 8/8] ARM: shmobile: r8a7790: Add DMA for MMCIF1":

+ dmas = <&dma0 0xe2>, <&dma0 0xe1>;
+ dma-names = "rx", "tx";

However, the actual code in shdma_of_xlate() doesn't handle the 2nd value:

        if (dma_spec->args_count != 1)
                return NULL;

BTW, I'm also looking at
http://git.codethink.co.uk/linux.git#bjdooks/shdma-dev4.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
