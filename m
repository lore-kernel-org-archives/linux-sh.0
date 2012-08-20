From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 Aug 2012 06:13:06 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <87k3wurt01.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Kobayashi-san

> > -------------------------------------------
> > diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-
> > index ee44740..a6eae4f 100644
> > --- a/arch/arm/mach-shmobile/intc-sh73a0.c
> > +++ b/arch/arm/mach-shmobile/intc-sh73a0.c
> > @@ -259,7 +259,7 @@ static int sh73a0_set_wake(struct irq_data *data, unsigned i
> >          return 0; /* always allow wakeup */
> >   }
> >   
> > -#define RELOC_BASE 0x1000
> > +#define RELOC_BASE 0x1200
> >   
> >   /* INTCA IRQ pins at INTCS + 0x1000 to make space for GIC+INTC handling */
> >   #define INTCS_VECT_RELOC(n, vect) INTCS_VECT((n), (vect) + RELOC_BASE)
> > 
> > 
> 
> FYI, 
> I tried this patch, too. I got the following log. It seems no conflicts.

Thank you for your checking/testing

Best regards
---
Kuninori Morimoto
