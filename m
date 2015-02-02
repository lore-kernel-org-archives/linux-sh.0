From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 Feb 2015 09:05:37 +0000
Subject: Re: [RFC 2/5] ARM: shmobile: r8a7790: add node for rwdt
Message-Id: <CAMuHMdVQTh52+QJHxjSfjsR-htvey8+SOzA6i7bguOLmwY-V5g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Feb 1, 2015 at 3:47 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -123,6 +123,13 @@
>                 interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>         };
>
> +       wdt0: wdt@e6020000 {
> +               compatible = "renesas,rwdt-r8a7790", "renesas,rwdt-rcar";
> +               reg = <0 0xe6020000 0 0x0c>;

The RWDT hardware block also has an interrupt:

        interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;

> +               clocks = <&mstp4_clks R8A7790_CLK_RWDT>;
> +               status = "disabled";
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
