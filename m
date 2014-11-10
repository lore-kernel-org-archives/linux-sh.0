From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2014 12:47:04 +0000
Subject: Re: [PATCH 4/6] ARM: shmobile: r8a73a4: Common clock framework DT description
Message-Id: <CAMuHMdWn3zXVYC0m9m8AA3zYy8SsQfoEoTRJ3PCbgjeSDHtMQQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415375524-15468-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415375524-15468-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, Nov 7, 2014 at 4:52 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi

> +       clocks {

> +               /* Fixed factor clocks */

> +               extal2_div2_clk: extal2_div2_clk {
> +                       compatible = "fixed-factor-clock";
> +                       clocks = <&extal2_clk>;
> +                       #clock-cells = <0>;
> +                       clock-div = <2>;
> +                       clock-mult = <1>;
> +                       clock-output-names = "extal2_div2";
> +               };
> +               extal2_div4_clk: extal1_div4_clk {
> +                       compatible = "fixed-factor-clock";
> +                       clocks = <&extal2_clk>;
> +                       #clock-cells = <0>;
> +                       clock-div = <4>;
> +                       clock-mult = <1>;
> +                       clock-output-names = "extal2_div4";
> +               };

These two are handled internally, like on sh73a0, right?
So I think they can be removed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
