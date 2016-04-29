From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Apr 2016 06:58:44 +0000
Subject: Re: [PATCH 7/7] sh: add device tree source for J2 FPGA on Mimas v2 board
Message-Id: <CAMuHMdX03FNUZ1JU73EQpt0qHPrErFLiYaP9YihRC=5cp_Js+g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
In-Reply-To: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rich,

On Thu, Apr 7, 2016 at 5:01 PM, Rich Felker <dalias@libc.org> wrote:
> --- /dev/null
> +++ b/arch/sh/boot/dts/j2_mimas_v2.dts
> @@ -0,0 +1,98 @@
> +/dts-v1/;
> +
> +/ {
> +       compatible = "jcore,j2-soc";
> +       model = "J2 FPGA SoC on Mimas v2 board";
> +
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       interrupt-parent = <&aic>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "jcore,j2";

This brings an interesting question: how do you plan to do IP core versioning?
I.e. which version of the HDL code does "jcore,j2" correspond to?


> +                       reg = < 0 >;
> +                       clock-frequency = < 50000000 >;
> +               };
> +       };

> +       chosen {
> +               stdout-path = "/soc@abcd0000/serial@100";

Adding a label to the serial node below would be useful, and allows
to simplify this to:

        stdout-path = &serial0;

> +       };

> +               serial@100 {

serial0: serial@100

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
