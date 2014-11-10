From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2014 11:15:30 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: r8a73a4: add MSTP clock assignments to DT
Message-Id: <CAMuHMdWnYoSrUCPxC5fqsCNb=icR3mfwMCRkWXFqzGm=Ckg+iQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415375524-15468-7-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415375524-15468-7-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, Nov 7, 2014 at 4:52 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -72,6 +72,7 @@
>                                         0 217 IRQ_TYPE_LEVEL_HIGH
>                                         0 218 IRQ_TYPE_LEVEL_HIGH
>                                         0 219 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&mstp2_clks R8A73A4_CLK_DMAC>;

Please add the clocks property below the interrupt-names property.

>                         interrupt-names = "error",
>                                         "ch0", "ch1", "ch2", "ch3",
>                                         "ch4", "ch5", "ch6", "ch7",

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
