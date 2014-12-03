From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 03 Dec 2014 12:25:21 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779 CCF DTS update
Message-Id: <CAMuHMdW36MmtK0PmmizP5FvKe6YVMFQEoOb34_BeVQRsVGhAkw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141203115145.5889.72521.sendpatchset@w520>
In-Reply-To: <20141203115145.5889.72521.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wed, Dec 3, 2014 at 12:51 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Update the r8a7779 CCF DTS with the following fixes:
>  - Use MSTP0 for SCIF clock control
>  - Use R8A7779_CLK_P as parent clock for SCIF (same as legacy code)
>  - Use "clock-indicies" instead of "renesas,clock-indices"

We already have
"[PATCH v2 3/6] ARM: shmobile: r8a7779 dtsi: Change to using clock-indices"
(http://www.spinics.net/lists/linux-sh/msg37285.html) for the latter.

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  Written on top of renesas-devel-20141202-v3.18-rc7
>
>  arch/arm/boot/dts/r8a7779.dtsi |   30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> --- 0001/arch/arm/boot/dts/r8a7779.dtsi
> +++ work/arch/arm/boot/dts/r8a7779.dtsi 2014-12-03 20:22:26.000000000 +0900
> @@ -200,7 +200,7 @@
>                 compatible = "renesas,scif-r8a7779", "renesas,scif";
>                 reg = <0xffe40000 0x100>;
>                 interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
> -               clocks = <&cpg_clocks R8A7779_CLK_P>;
> +               clocks = <&mstp0_clks R8A7779_CLK_SCIF0>;
>                 clock-names = "sci_ick";
>                 status = "disabled";
>         };

According to the datasheet, the SCIF can use both S1 and "SCIF_CLK" (I assume
that's the MSTP clock output for SCIF?) as clock input, selectable using the
XIN bit of the Clock Select Register (CKS).
Do you have more information?

> @@ -464,18 +464,18 @@
>                                  <&cpg_clocks R8A7779_CLK_P>,
>                                  <&cpg_clocks R8A7779_CLK_S>,
>                                  <&cpg_clocks R8A7779_CLK_S>,
> -                                <&cpg_clocks R8A7779_CLK_S1>,
> -                                <&cpg_clocks R8A7779_CLK_S1>,
> -                                <&cpg_clocks R8A7779_CLK_S1>,
> -                                <&cpg_clocks R8A7779_CLK_S1>,
> -                                <&cpg_clocks R8A7779_CLK_S1>,
> -                                <&cpg_clocks R8A7779_CLK_S1>,
> +                                <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>,
> +                                <&cpg_clocks R8A7779_CLK_P>,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
