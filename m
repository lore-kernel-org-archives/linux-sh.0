From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 10 Dec 2013 01:39:49 +0000
Subject: Re: [PATCH V2] gpio: rcar: Fix level interrupt handling
Message-Id: <2145029.4685npYTTl@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1385748249-27170-1-git-send-email-valentine.barshak@cogentembedded.com> <52A6190C.200@cogentembedded.com>
In-Reply-To: <52A6190C.200@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valentine <valentine.barshak@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Valentine,

On Monday 09 December 2013 23:25:00 Valentine wrote:
> On 11/29/2013 10:04 PM, Valentine Barshak wrote:
> > According to the manual, if a port is set for level detection using
> > the corresponding bit in the edge/level select register and an external
> > level interrupt signal is asserted, the corresponding bit in INTDT
> > does not use the FF to hold the input.
> > Thus, writing 1 to the corresponding bits in INTCLR cannot clear the
> > corresponding bits in the INTDT register. Instead, when an external
> > input signal is stopped, the corresponding bit in INTDT is cleared
> > automatically.
> > 
> > Since the INTDT bit cannot be cleared for the level interrupts until
> > the interrupt signal is stopped, we end up with the infinite loop
> > when using deferred (threaded) IRQ handling.
> > 
> > Since a deferred interrupt is disabled by the low-level handler and
> > re-enabled only when the deferred handler is completed, Fix the issue
> > by dropping disabled interrupts from the pending mask as suggested by
> > Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Changes in V2:
> > * Drop disabled interrupts from pending mask altogether instead of
> > 
> >    dropping level interrupts one by one once they get handled.
> > 
> > Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> > ---
> > 
> >   drivers/gpio/gpio-rcar.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> > index d3f15ae..fd2d827 100644
> > --- a/drivers/gpio/gpio-rcar.c
> > +++ b/drivers/gpio/gpio-rcar.c
> > @@ -169,7 +169,8 @@ static irqreturn_t gpio_rcar_irq_handler(int irq, void
> > *dev_id)
> >   	u32 pending;
> >   	unsigned int offset, irqs_handled = 0;
> > 
> > -	while ((pending = gpio_rcar_read(p, INTDT))) {
> > +	while ((pending = gpio_rcar_read(p, INTDT) &
> > +			  gpio_rcar_read(p, INTMSK))) {
> >   		offset = __ffs(pending);
> >   		gpio_rcar_write(p, INTCLR, BIT(offset));
> >   		generic_handle_irq(irq_find_mapping(p->irq_domain, offset));
> 
> Laurent, Magnus,
> do you have any concerns about fixing the level IRQ's as proposed here?
> 
> I'm more inclined to re-read the registers instead of caching the pending
> value pending = gpio_rcar_read(p, INTDT) & gpio_rcar_read(p, INTMSK)); and
> dropping bits inside the while loop
>   pending &= ~BIT(offset);
> 
> I think this could help to catch new interrupts while processing previous
> ones. It also makes minimum change to the original logic.
> 
> Please let me know if you think it's not good enough and the cached
> "pending" value (or any other approach) should be used instead.

I would have used the caching approach myself as it makes the loop simpler and 
any external interrupt occuring after the registers are read would be 
processed by a new interrupt handler call, but your approach should work fine 
as well, so I have no reason to complain.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

