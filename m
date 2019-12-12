From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 12 Dec 2019 23:57:03 +0000
Subject: Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
Message-Id: <87pngt5c8g.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
        <CAMuHMdWb_ipn7FVHbz8=PTdGod=MW+2xHY7yuq3yJcWwNnDvcg@mail.gmail.com>
In-Reply-To: <CAMuHMdWb_ipn7FVHbz8=PTdGod=MW+2xHY7yuq3yJcWwNnDvcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Hi Geert

Thank you for your feedback

> > --- a/arch/sh/lib/delay.c
> > +++ b/arch/sh/lib/delay.c
> > @@ -29,6 +29,7 @@ void __delay(unsigned long loops)
> >                 : "0" (loops)
> >                 : "t");
> >  }
> > +EXPORT_SYMBOL(__delay);
> >
> >  inline void __const_udelay(unsigned long xloops)
> >  {
> 
> I believe the correct fix is make drivers/net/phy/mdio-cavium.c use one
> of [nmu]delay() instead.
> 
> Cfr.
> https://lore.kernel.org/lkml/CAMuHMdUERaoHLNKi03zCuYi7NevgBFjXrV=pt0Yy=HOeRiL25Q@mail.gmail.com/

OK, make sense.
I did it because some architecture is using EXPORT_SYMBOL() to __delay.

Thank you for your help !!
Best regards
---
Kuninori Morimoto
