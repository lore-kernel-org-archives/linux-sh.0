From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 26 Mar 2008 19:56:37 +0000
Subject: Re: [PATCH] i2c: SuperH Mobile I2C Bus Controller V3
Message-Id: <20080326125637.56ab7c85.akpm@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080325105559.GA30232@linux-sh.org>
In-Reply-To: <20080325105559.GA30232@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: i2c@lm-sensors.org, khali@linux-fr.org, magnus.damm@gmail.com, linux-sh@vger.kernel.org

On Tue, 25 Mar 2008 19:55:59 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> This is V3 of the SuperH Mobile I2C Controller Driver. A simple Master
> only driver for the I2C block included in processors such as sh7343,
> sh7722 and sh7723. Tested on a sh7722 MigoR using a rs5c372b rtc.
> 
> +#include <asm/io.h>

please use checkpatch.

> +static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
> +			    int op, unsigned char data)
> +{
> +	unsigned char ret = 0;
> +
> +	dev_dbg(pd->dev, "op %d, data in 0x%02x\n", op, data);
> +
> +	spin_lock_irq(&pd->lock);
> +
> +	switch (op) {
> +	case OP_START:
> +		iowrite8(0x94, ICCR(pd));
> +		break;
> +	case OP_TX_ONLY:
> +		iowrite8(data, ICDR(pd));
> +		break;
> +	case OP_TX_STOP:
> +		iowrite8(data, ICDR(pd));
> +		iowrite8(0x90, ICCR(pd));
> +		iowrite8(ICIC_ALE | ICIC_TACKE, ICIC(pd));
> +		break;
> +	case OP_TX_TO_RX:
> +		iowrite8(data, ICDR(pd));
> +		iowrite8(0x81, ICCR(pd));
> +		break;
> +	case OP_RX_ONLY:
> +		ret = ioread8(ICDR(pd));
> +		break;
> +	case OP_RX_STOP:
> +		ret = ioread8(ICDR(pd));
> +		iowrite8(0xc0, ICCR(pd));
> +		break;
> +	}
> +
> +	spin_unlock_irq(&pd->lock);
> +
> +	dev_dbg(pd->dev, "op %d, data out 0x%02x\n", op, ret);
> +	return ret;
> +}

I'd be a bit concerned about reenabling interrupts...

> +static irqreturn_t sh_mobile_i2c_isr(int irq, void *dev_id)
> +{
> +	struct platform_device *dev = dev_id;
> +	struct sh_mobile_i2c_data *pd = platform_get_drvdata(dev);
> +	struct i2c_msg *msg = pd->msg;
> +	unsigned char data, sr;
> +	int wakeup = 0;
> +
> +	sr = ioread8(ICSR(pd));
> +	pd->sr |= sr;
> +
> +	dev_dbg(pd->dev, "i2c_isr 0x%02x 0x%02x %s %d %d!\n", sr, pd->sr,
> +	       (msg->flags & I2C_M_RD) ? "read" : "write",
> +	       pd->pos, msg->len);
> +
> +	if (sr & (ICSR_AL | ICSR_TACK)) {
> +		iowrite8(0, ICIC(pd)); /* disable interrupts */
> +		wakeup = 1;
> +		goto do_wakeup;
> +	}
> +
> +	if (pd->pos = msg->len) {
> +		i2c_op(pd, OP_RX_ONLY, 0);

from the interrupt handler...

> +static int sh_mobile_i2c_hook_irqs(struct platform_device *dev, int hook)
> +{
> +	struct resource *res;
> +	int ret = -ENXIO;
> +	int q, m;
> +	int k = 0;
> +	int n = 0;
> +
> +	while ((res = platform_get_resource(dev, IORESOURCE_IRQ, k))) {
> +		for (n = res->start; hook && n <= res->end; n++) {
> +			if (request_irq(n, sh_mobile_i2c_isr, 0,
> +					dev->dev.bus_id, dev))

even though it isn't using IRQF_DISABLED here,


: int request_irq(unsigned int irq, irq_handler_t handler,
: 		unsigned long irqflags, const char *devname, void *dev_id)
: {
: 	struct irqaction *action;
: 	int retval;
: 
: #ifdef CONFIG_LOCKDEP
: 	/*
: 	 * Lockdep wants atomic interrupt handlers:
: 	 */
: 	irqflags |= IRQF_DISABLED;
: #endif

it will do so if lockdep is supported.
