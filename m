From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 03 Apr 2014 09:42:46 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo-reference dts: enable RTC
Message-Id: <CAMuHMdXci6w1eXcs0sDKQqPDSYq531UJLqGmk_+CUM0nNRfX0A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396280300-7016-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1396280300-7016-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht@gmail.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

(cc devicetree)

On Mon, Mar 31, 2014 at 5:38 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> This enables the Seiko real-time clock that is attached to a couple of
> GPIO pins.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> ---
>  .../arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> index b79ea51..ac352ef 100644
> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> @@ -118,6 +118,16 @@
>                 };
>         };
>
> +       i2c2: i2c@2 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               compatible = "i2c-gpio";
> +               gpios = <&pfc 208 GPIO_ACTIVE_HIGH /* sda */
> +                        &pfc 91 GPIO_ACTIVE_HIGH /* scl */
> +                       >;
> +               i2c-gpio,delay-us = <5>;
> +       };
> +
>         backlight {
>                 compatible = "pwm-backlight";
>                 pwms = <&tpu 2 33333 PWM_POLARITY_INVERTED>;
> @@ -178,6 +188,14 @@
>         };
>  };
>
> +&i2c2 {
> +       status = "okay";
> +       rtc@30 {
> +               compatible = "seiko,s35390a";

I think this should be "sii,s35390a", for Seiko Instruments Inc.

> +               reg = <0x30>;
> +       };
> +};
> +
>  &pfc {
>         pinctrl-0 = <&scifa1_pins>;
>         pinctrl-names = "default";
> --
> 1.8.4.5

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
