From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jun 2020 14:45:28 +0000
Subject: Re: [PATCH v3 2/5] ARM: shmobile: r8a7778: enable IRLM setup via DT
Message-Id: <CAMuHMdW7euPe0ngsftfYdJGi7xCOtmD9_Ysj72_NGxmPJKFKNQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 8, 2015 at 5:42 PM Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Make use of the IRLM setup feature in the renesas-intc-irqpin driver.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Simon Horman <horms+renesas@verge.net.au>

Looks like this is still value?
Hence I plan to queue it in renesas-devel for v5.9....

> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -78,7 +78,8 @@
>                         <0xfe780010 4>,
>                         <0xfe780024 4>,
>                         <0xfe780044 4>,
> -                       <0xfe780064 4>;
> +                       <0xfe780064 4>,
> +                       <0xfe780000 4>;
>                 interrupts =   <0 27 IRQ_TYPE_LEVEL_HIGH
>                                 0 28 IRQ_TYPE_LEVEL_HIGH
>                                 0 29 IRQ_TYPE_LEVEL_HIGH

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
