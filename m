From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 29 Nov 2013 15:39:50 +0000
Subject: Re: [PATCH] gpio: rcar: Fix level interrupt handling
Message-Id: <1719568.8ouSvhq4g8@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1385731940-25359-1-git-send-email-valentine.barshak@cogentembedded.com> <2847875.sxPRWEJTjc@avalon> <5298AFAE.2050802@cogentembedded.com>
In-Reply-To: <5298AFAE.2050802@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valentine <valentine.barshak@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Valentine,

On Friday 29 November 2013 19:15:58 Valentine wrote:
> On 11/29/2013 07:00 PM, Laurent Pinchart wrote:
> > On Friday 29 November 2013 17:32:20 Valentine Barshak wrote:
> >> According to the manual, if a port is set for level detection using
> >> the corresponding bit in the edge/level select register and an external
> >> level interrupt signal is asserted, the corresponding bit in INTDT
> >> does not use the FF to hold the input.
> >> Thus, writing 1 to the corresponding bits in INTCLR cannot clear the
> >> corresponding bits in the INTDT register. Instead, when an external
> >> input signal is stopped, the corresponding bit in INTDT is cleared
> >> automatically.
> >> 
> >> Since the INTDT bit cannot be cleared for the level interrupts until
> >> the interrupt signal is stopped, we end up with the infinite loop
> >> when using deferred (threaded) IRQ handling.
> >> 
> >> Workaround the issue by dropping level interrupts from the pending
> >> mask once the interrupt is handled. If the IRQ is not cleared by the
> >> handler, it will be invoked again when the interrupt is re-enabled.
> > 
> > Isn't it an issue common to all IRQ chip drivers that should be handled by
> > the IRQ core ?
> 
> No, it isn't.
> 
> > When using level-triggered interrupts with threaded IRQ handlers,
> > the core should disable the interrupt and re-enable it after executing the
> > threaded handler.
> 
> The problem is not in disabling/re-enabling interrupts.
> Even when the interrupt is disabled, the corresponding INTDT bit is not
> cleared. Thus, the "while" loop never ends if a level interrupt happens
> since its bit is always set in the "pending" mask.
> In this case we never start deferred interrupt service routine, and never
> de-assert it.
> 
> The patch fixes this issue by dropping the IRQ bit from the "pending" mask
> once the IRQ is handled at low-level.

Right, I had misunderstood the purpose of your patch. I would rephrase the 
commit message to replace "Workaround the issue" by "Fix the issue", as this 
is a proper fix, not a workaround.

There's also another issue that, if I'm not mistaken, isn't fixed by this 
patch. Let's assume that a low-level level-triggered IRQ is enabled on GPIO 0 
with a threaded IRQ handler and an edge-triggered IRQ is enabled on GPIO 1.

When GPIO 0 becomes low the gpio_rcar_irq_handler() is called and loops over 
the INTDT register. Only bit 0 is set, the mask is updated to mask the GPIO 0 
IRQ and the corresponding IRQ handler is executed. As the IRQ is threaded the 
IRQ source won't be acknowledged right away, bit 0 in the INTDT register is 
thus not cleared. With this patch applied the loop finishes and the 
gpio_rcar_irq_handler() function returns.

If GPIO 1 is then toggled before the thread IRQ handler for GPIO 0 is 
executed, the gpio_rcar_irq_handler() will be called again, and the loop will 
handle the GPIO 0 IRQ again as bit 0 in INTDT is still set.

I'm not familiar enough with the IRQ core to know whether this problem is 
already handled in the core, that should be at least checked.

> >> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >> ---
> >> 
> >>   drivers/gpio/gpio-rcar.c | 10 ++++++++--
> >>   1 file changed, 8 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> >> index d3f15ae..918a1de 100644
> >> --- a/drivers/gpio/gpio-rcar.c
> >> +++ b/drivers/gpio/gpio-rcar.c
> >> @@ -166,12 +166,18 @@ static int gpio_rcar_irq_set_type(struct irq_data
> >> *d, unsigned int type)
> >>  static irqreturn_t gpio_rcar_irq_handler(int irq, void *dev_id)
> >>  {
> >>   	struct gpio_rcar_priv *p = dev_id;
> >> -	u32 pending;
> >> +	u32 pending, mask = 0;
> >>   	unsigned int offset, irqs_handled = 0;
> >> 
> >> -	while ((pending = gpio_rcar_read(p, INTDT))) {
> >> +	/*
> >> +	 * Level interrupts cannot be cleared in the INTDT,
> >> +	 * so we just drop them from the pending mask when
> >> +	 * the interrupt is handled.
> >> +	 */
> >> +	while ((pending = gpio_rcar_read(p, INTDT) & ~mask)) {
> >>   		offset = __ffs(pending);
> >>   		gpio_rcar_write(p, INTCLR, BIT(offset));
> >> +		mask |= BIT(offset) & ~gpio_rcar_read(p, EDGLEVEL);
> >>   		generic_handle_irq(irq_find_mapping(p->irq_domain, offset));
> >>   		irqs_handled++;
> >>   	}

What about something like this

	pending = gpio_rcar_read(p, INTDT)
		& gpio_rcar_read(p, INTMSK);

	while (pending) {
		offset = __ffs(pending);
		gpio_rcar_write(p, INTCLR, BIT(offset));
		pending &= ~BIT(offset);
		generic_handle_irq(irq_find_mapping(p->irq_domain, offset));
		irqs_handled++;
	}

-- 
Regards,

Laurent Pinchart

