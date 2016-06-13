From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jun 2016 08:15:26 +0000
Subject: Re: [PATCH v2 11/17] sh: SH7750/51 clock driver
Message-Id: <CAMuHMdXDZyKkd3STNPNL8jmpJvW8gigWrRfZnwjoWkuYa8rMAg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp> <1465714475-24111-12-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-12-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>

Hi Sato-san,

On Sun, Jun 12, 2016 at 8:54 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../bindings/clock/renesas,sh7750-div-clock.txt    |  27 +++
>  .../bindings/clock/renesas,sh7750-pll-clock.txt    |  26 +++
>  drivers/clk/sh/clk-sh7750.c                        | 240 +++++++++++++++++++++
>  3 files changed, 293 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt
>  create mode 100644 drivers/clk/sh/clk-sh7750.c
>
> diff --git a/Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt b/Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt
> new file mode 100644
> index 0000000..8c57ab5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-div-clock.txt
> @@ -0,0 +1,27 @@
> +* Renesas SH7750/51 divider clock
> +
> +Required Properties:
> +
> +  - compatible: Must be "renesas,sh7750-div-clock"
> +
> +  - clocks: Reference to the parent clocks (mostly PLL)
> +
> +  - #clock-cells: Must be 0
> +
> +  - reg: Base address and length of the divide rate selector
> +
> +  - renesas,offset: bit offset of selector
> +
> +  - clock-output-names: The names of the clocks.
> +
> +Example
> +-------
> +
> +        iclk: iclk {
> +                compatible = "renesas,sh7750-div-clock";
> +                clocks = <&pllclk>;
> +                #clock-cells = <0>;
> +                reg = <0xffc00000 2>;
> +               renesas,offset = <6>;
> +               clock-output-names = "ick";
> +        };
> diff --git a/Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt b/Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt
> new file mode 100644
> index 0000000..06a3d31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-pll-clock.txt

> +CLK_OF_DECLARE(sh7750_div_clk, "renesas,sh7750-div-clock",
> +              sh7750_div_clk_setup);
> +CLK_OF_DECLARE(sh7750_pll_clk, "renesas,sh7750-pll-clock",
> +              sh7750_pll_clk_setup);
> +

Cfr. my comment on the .dtsi, which didn't have linux-clk in CC:

I think it will be much easier for maintenance and code reuse to just have a
single "cpg" node that's compatible with "renesas,sh7750-cpg", covering all
CPG registers. Especially since the various clocks use the same registers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
