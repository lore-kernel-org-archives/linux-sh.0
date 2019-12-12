From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Dec 2019 07:43:04 +0000
Subject: Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
Message-Id: <CAMuHMdWb_ipn7FVHbz8=PTdGod=MW+2xHY7yuq3yJcWwNnDvcg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Morimoto-san,

On Thu, Dec 12, 2019 at 3:38 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> __delay() is used from kernel module.
> We need EXPORT_SYMBOL(), otherwise we will get compile error.
>
> ERROR: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks for your patch!

> --- a/arch/sh/lib/delay.c
> +++ b/arch/sh/lib/delay.c
> @@ -29,6 +29,7 @@ void __delay(unsigned long loops)
>                 : "0" (loops)
>                 : "t");
>  }
> +EXPORT_SYMBOL(__delay);
>
>  inline void __const_udelay(unsigned long xloops)
>  {

I believe the correct fix is make drivers/net/phy/mdio-cavium.c use one
of [nmu]delay() instead.

Cfr.
https://lore.kernel.org/lkml/CAMuHMdUERaoHLNKi03zCuYi7NevgBFjXrV=pt0Yy=HOeRiL25Q@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
