From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 May 2016 08:17:34 +0000
Subject: Re: [PATCH v2 12/12] sh: add device tree source for J2 FPGA on Mimas v2 board
Message-Id: <CAMuHMdVr-gZbfo9hG=w5bB3_x6v67sFd2yAPLLbPyWyg-jUmug@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
	<9960d6526523727d1bee3d11c6704e09e600c6fe.1463708766.git.dalias@libc.org>
In-Reply-To: <9960d6526523727d1bee3d11c6704e09e600c6fe.1463708766.git.dalias-8zAoT0mYgF4@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>

On Fri, May 20, 2016 at 4:53 AM, Rich Felker <dalias@libc.org> wrote:
> --- /dev/null
> +++ b/arch/sh/boot/dts/j2_mimas_v2.dts
> @@ -0,0 +1,87 @@
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
> +                       reg = < 0 >;
> +                       clock-frequency = < 50000000 >;
> +               };
> +       };
> +
> +       memory@10000000 {
> +               device_type = "memory";
> +               reg = < 0x10000000 0x4000000 >;
> +       };
> +
> +       chosen {
> +               stdout-path = "/soc@abcd0000/serial@100";
> +       };
> +
> +       soc@abcd0000 {
> +               compatible = "simple-bus";
> +               ranges = <0 0xabcd0000 0x100000>;
> +
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               aic: interrupt-controller {

aic: interrupt-controller@200 {

> +                       compatible = "jcore,aic1";
> +                       reg = < 0x200 0x10 >;
> +                       interrupt-controller;
> +                       #interrupt-cells = <1>;
> +               };
> +
> +               cache-controller {

@c0

> +                       compatible = "jcore,cache";
> +                       reg = < 0xc0 4 >;
> +               };
> +
> +               timer {

@200

> +                       compatible = "jcore,pit";
> +                       reg = < 0x200 0x30 >;
> +                       interrupts = < 0x48 >;
> +               };
> +
> +               spi {

@40

> +                       compatible = "jcore,spi2";
> +
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       spi-max-frequency = <12500000>;
> +
> +                       reg = < 0x40 0x8 >;
> +
> +                       sdcard@1 {

@0, to match reg below?

> +                               compatible = "mmc-spi-slot";
> +                               reg = <0>;
> +                               spi-max-frequency = <12500000>;
> +                               voltage-ranges = <3200 3400>;
> +                               mode = <0>;
> +                       };
> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
