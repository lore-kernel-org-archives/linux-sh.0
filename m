From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Feb 2013 00:14:31 +0000
Subject: Re: [RFC][PATCH v2] ARM: shmobile: R-Car: add gic_iid macro for ICCIAR / interrupt ID
Message-Id: <87sj4r96zh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wqu4el91.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wqu4el91.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for your reply

> > diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> > index cdcb799..2338d4b 100644
> > --- a/arch/arm/mach-shmobile/board-marzen.c
> > +++ b/arch/arm/mach-shmobile/board-marzen.c
> > @@ -66,7 +66,7 @@ static struct resource smsc911x_resources[] = {
> >                 .flags          = IORESOURCE_MEM,
> >         },
> >         [1] = {
> > -               .start          = gic_spi(28), /* IRQ 1 */
> > +               .start          = gic_iid(0x3c), /* IRQ 1 */
> >                 .flags          = IORESOURCE_IRQ,
> >         },
> >  };
> 
> In general we're moving over to DT so for this case I can't say that I
> care very much. However, if you want to change things around why don't
> you just do the following?
> 
> > +               .start          = 0x3c, /* IRQ 1 */

Actually, I considered this "direct value" style,
but I thought that it seems  un-understandable.
This gic_iid(xxx) shows some kind of "GIC" value.

Best regards
---
Kuninori Morimoto
