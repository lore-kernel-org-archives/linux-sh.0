From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jun 2016 08:13:37 +0000
Subject: Re: [PATCH v2 16/17] sh: I/O DATA HDL-U (a.k.a. landisk) Device Tree
Message-Id: <CAMuHMdXGnQu899UY-bySVnG0bzY1UtzJp2akg8mEgy_AZ99Ufw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp> <1465714475-24111-17-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-17-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Sato-san,

On Sun, Jun 12, 2016 at 8:54 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> --- /dev/null
> +++ b/arch/sh/boot/dts/landisk.dts
> @@ -0,0 +1,150 @@

> +        pllclk: pllclk {
> +                compatible = "renesas,sh7750-pll-clock";
> +                clocks = <&oclk>;
> +                #clock-cells = <0>;
> +               renesas,mult = <12>;
> +                reg = <0xffc00000 2>, <0xffc00008 4>;
> +        };
> +        iclk: iclk {
> +                compatible = "renesas,sh7750-div-clock";
> +                clocks = <&pllclk>;
> +                #clock-cells = <0>;
> +                reg = <0xffc00000 2>;
> +               renesas,offset = <6>;
> +               clock-output-names = "ick";

clock-output-names is deprecated for clocks providing a single output.

> +        };
> +        bclk: bclk {
> +                compatible = "renesas,sh7750-div-clock";
> +                clocks = <&pllclk>;
> +                #clock-cells = <0>;
> +                reg = <0xffc00000 2>;
> +               renesas,offset = <3>;
> +               clock-output-names = "bck";
> +        };
> +        fclk: fclk {
> +                compatible = "renesas,sh7750-div-clock";
> +                clocks = <&pllclk>;
> +                #clock-cells = <0>;
> +                reg = <0xffc00000 2>;
> +               renesas,offset = <0>;
> +               clock-output-names = "fck";
> +        };

I think it will be much easier for maintenance and code reuse to just have a
single "cpg" node that's compatible with "renesas,sh7750-cpg", covering all
CPG registers. Especially since the various clocks use the same registers.

Cfr. drivers/clk/renesas/cpg-mssr.c.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
