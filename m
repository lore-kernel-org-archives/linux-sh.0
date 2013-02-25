From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Feb 2013 00:05:43 +0000
Subject: Re: [RFC][PATCH v2] ARM: shmobile: R-Car: add gic_iid macro for ICCIAR / interrupt ID
Message-Id: <87liadfeaz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wqu4el91.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wqu4el91.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> On Wed, Feb 20, 2013 at 08:41:47PM +0900, Paul Mundt wrote:
> > On Tue, Feb 19, 2013 at 04:14:31PM -0800, Kuninori Morimoto wrote:
> > > 
> > > Hi Magnus
> > > 
> > > Thank you for your reply
> > > 
> > > > > diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> > > > > index cdcb799..2338d4b 100644
> > > > > --- a/arch/arm/mach-shmobile/board-marzen.c
> > > > > +++ b/arch/arm/mach-shmobile/board-marzen.c
> > > > > @@ -66,7 +66,7 @@ static struct resource smsc911x_resources[] = {
> > > > >                 .flags          = IORESOURCE_MEM,
> > > > >         },
> > > > >         [1] = {
> > > > > -               .start          = gic_spi(28), /* IRQ 1 */
> > > > > +               .start          = gic_iid(0x3c), /* IRQ 1 */
> > > > >                 .flags          = IORESOURCE_IRQ,
> > > > >         },
> > > > >  };
> > > > 
> > > > In general we're moving over to DT so for this case I can't say that I
> > > > care very much. However, if you want to change things around why don't
> > > > you just do the following?
> > > > 
> > > > > +               .start          = 0x3c, /* IRQ 1 */
> > > 
> > > Actually, I considered this "direct value" style,
> > > but I thought that it seems  un-understandable.
> > > This gic_iid(xxx) shows some kind of "GIC" value.
> > > 
> > Agreed. The direct mapping works fine if its understood that the value
> > being assigned is a direct IRQ number. In the case that it's some other
> > value that's being adapted, it should go through a canonicalization
> > wrapper to make the use obvious. Whether there is a 1:1 correlation or
> > not doesn't particularly matter, as it's still adopting a non-IRQ
> > resource as an IRQ value.
> 
> Thanks Paul.
> 
> Does anyone have any outstanding objections to v2 of this patch?
> 
> Morimoto-san, is this just an RFC or would you like it applied?

Thank you.

I noticed one thing.
Do you think is it better if gic_iid() macro has explain comment ?
I can send v3 patch

#define gic_iid(nr)		(nr) /* ICCIAR / interrupt ID */


Best regards
---
Kuninori Morimoto
