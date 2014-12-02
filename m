From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 02 Dec 2014 21:23:48 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: ape6evm-reference: Add LEDs to the device tree
Message-Id: <CAMuHMdW-81-NXspS3s0r1y-=eXK7zywJHZgcAODype6BfSWQPg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417509427-31690-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1417509427-31690-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Tue, Dec 2, 2014 at 9:37 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> +++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> @@ -82,6 +82,34 @@
>                         vdd33a-supply = <&ape6evm_fixed_3v3>;
>                 };
>         };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               led1 {
> +                       gpios = <&pfc 28 GPIO_ACTIVE_LOW>;
> +                       label = "gnss-en";
> +               };
> +               led2 {
> +                       gpios = <&pfc 126 GPIO_ACTIVE_LOW>;
> +                       label = "nfc-nrst";
> +               };
> +               led3 {
> +                       gpios = <&pfc 132 GPIO_ACTIVE_LOW>;
> +                       label = "gnss-nrst";
> +               };
> +               led4 {
> +                       gpios = <&pfc 232 GPIO_ACTIVE_LOW>;
> +                       label = "bt-wakeup";
> +               };
> +               led5 {
> +                       gpios = <&pfc 250 GPIO_ACTIVE_LOW>;
> +                       label = "strobe";
> +               };
> +               led6 {
> +                       gpios = <&pfc 288 GPIO_ACTIVE_LOW>;
> +                       label = "bbresetout";

Are the labels in lower or upper case?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
