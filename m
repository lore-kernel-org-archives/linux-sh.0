From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 12 Nov 2013 13:24:34 +0000
Subject: Re: [PATCH] irqchip: renesas-intc-irqpin: Fix register bitfield shift calculation
Message-Id: <2886260.Aksu7qXPiW@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1383999481-2742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383999481-2742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Tuesday 12 November 2013 14:08:40 Simon Horman wrote:
> On Sat, Nov 09, 2013 at 01:18:01PM +0100, Laurent Pinchart wrote:
> > The SENSE register bitfield position is incorrectly computed for SoCs
> > that use 2-bit IRQ sense fields. Fix it.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Hi Laurent,
> 
> your change seems correct to me but I am wondering if it should
> be considered as a bug-fix?

It's a bug fix, but given that the bug hasn't had any consequence so far, I'm 
not sure whether we really need to backport it to -stable.

> > ---
> > 
> >  drivers/irqchip/irq-renesas-intc-irqpin.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c
> > b/drivers/irqchip/irq-renesas-intc-irqpin.c index 82cec63..3ee78f0 100644
> > --- a/drivers/irqchip/irq-renesas-intc-irqpin.c
> > +++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
> > @@ -149,8 +149,9 @@ static void intc_irqpin_read_modify_write(struct
> > intc_irqpin_priv *p,> 
> >  static void intc_irqpin_mask_unmask_prio(struct intc_irqpin_priv *p,
> >  					 int irq, int do_mask)
> >  {
> > -	int bitfield_width = 4; /* PRIO assumed to have fixed bitfield width 
*/
> > -	int shift = (7 - irq) * bitfield_width; /* PRIO assumed to be 32-bit 
*/
> > +	/* The PRIO register is assumed to be 32-bit with fixed 4-bit fields. 
*/
> > +	int bitfield_width = 4;
> > +	int shift = 32 - (irq + 1) * bitfield_width;
> >  	intc_irqpin_read_modify_write(p, INTC_IRQPIN_REG_PRIO,
> >  				      shift, bitfield_width,
> > @@ -159,8 +160,9 @@ static void intc_irqpin_mask_unmask_prio(struct
> > intc_irqpin_priv *p,> 
> >  static int intc_irqpin_set_sense(struct intc_irqpin_priv *p, int irq, int
> >  value) {
> > 
> > +	/* The SENSE register is assumed to be 32-bit. */
> >  	int bitfield_width = p->config.sense_bitfield_width;
> > -	int shift = (7 - irq) * bitfield_width; /* SENSE assumed to be 32-bit 
*/
> > +	int shift = 32 - (irq + 1) * bitfield_width;
> > 
> >  	dev_dbg(&p->pdev->dev, "sense irq = %d, mode = %d\n", irq, value);
-- 
Regards,

Laurent Pinchart

