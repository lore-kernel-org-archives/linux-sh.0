From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Feb 2015 11:04:07 +0000
Subject: Re: [PATCH v2 10/15] ARM: shmobile: r8a7778: add sound to DT
Message-Id: <CAMuHMdWZPuQ4sNdUrkC6wu47TMu4W9OhBkNXUxuV620dCTtnjw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423497763-3450-11-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1423497763-3450-11-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 9, 2015 at 5:02 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -220,6 +220,61 @@
>                 status = "disabled";
>         };
>
> +       rcar_sound: rcar_sound@ffd90000 {
> +               #sound-dai-cells = <1>;
> +               compatible = "renesas,rcar_sound-r8a7778", "renesas,rcar_sound-gen1", "renesas,rcar_sound";
> +               reg =   <0xffd90000 0x1000>,    /* SRU */
> +                       <0xffd91000 0x1240>,    /* SSI */
> +                       <0xfffe0000 0x24>;      /* ADG */
> +               clocks = <&mstp3_clks R8A7778_CLK_SSI8>,
> +                       <&mstp3_clks R8A7778_CLK_SSI7>,
> +                       <&mstp3_clks R8A7778_CLK_SSI6>,
> +                       <&mstp3_clks R8A7778_CLK_SSI5>,
> +                       <&mstp3_clks R8A7778_CLK_SSI4>,
> +                       <&mstp0_clks R8A7778_CLK_SSI3>,
> +                       <&mstp0_clks R8A7778_CLK_SSI2>,
> +                       <&mstp0_clks R8A7778_CLK_SSI1>,
> +                       <&mstp0_clks R8A7778_CLK_SSI0>,
> +                       <&mstp5_clks R8A7778_CLK_SCU_SRC8>,
> +                       <&mstp5_clks R8A7778_CLK_SCU_SRC7>,
> +                       <&mstp5_clks R8A7778_CLK_SCU_SRC6>,
> +                       <&mstp5_clks R8A7778_CLK_SCU_SRC5>,
> +                       <&mstp5_clks R8A7778_CLK_SCU_SRC4>,
> +                       <&mstp5_clks R8A7778_CLK_SCU_SRC3>,
> +                       <&mstp5_clks R8A7778_CLK_SCU_SRC2>,
> +                       <&mstp5_clks R8A7778_CLK_SCU_SRC1>,
> +                       <&mstp5_clks R8A7778_CLK_SCU_SRC0>,

R8A7778_CLK_SRU_SRC%u

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
