From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 05 Jan 2015 13:53:23 +0000
Subject: Re: [RFC 3/4] ARM: shmobile: r8a7790: lager: add i2c-demuxer to dts
Message-Id: <CAMuHMdWf+TqOuMjsKh58yfM8_+6Q5y=2ud-gx393Rhq9E+=L0Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 15, 2014 at 9:20 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -144,6 +144,34 @@
>                 states = <3300000 1
>                           1800000 0>;
>         };
> +
> +       i2c-demux {
> +
> +               compatible = "i2c-demux-pinctrl";
> +               i2c-parent = <&iic2>, <&i2c2>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               i2c@2 {

i2c@0

(we really need a dtc that checks for this)

> +                       reg = <0>;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
