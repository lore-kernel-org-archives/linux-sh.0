From: Ben Dooks <ben-linux@fluff.org>
Date: Sat, 29 Mar 2008 17:57:32 +0000
Subject: Re: [i2c] [PATCH] i2c: SuperH Mobile I2C Bus Controller V4
Message-Id: <20080329175732.GA9638@fluff.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20080328093530.32474.78684.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080328093530.32474.78684.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: i2c@lm-sensors.org, akpm@linux-foundation.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Fri, Mar 28, 2008 at 06:35:30PM +0900, Magnus Damm wrote:
> This is V4 of the SuperH Mobile I2C Controller Driver. A simple Master
> only driver for the I2C block included in processors such as sh7343,
> sh7722 and sh7723. Tested on a sh7722 MigoR using a rs5c732b rtc.
> 
> Changes since V3:
>  - Added SUPERH Kconfig dependency
>  - Use spin_lock_irqsave() and spin_unlock_irqrestore()
>  - Use IRQF_DISABLED
>  - Checkpatch fixes
> Changes since V2:
>  - dev_xxx() use
>  - Kill off superfluous ioarea resource
>  - Add SMBus emulation
> Changes since V1:
>  - Use clk_get()/clk_put()/clk_get_rate() to get peripheral clock rate.
>  - Use pdev->dev.bus_id instead of dev->name

Do we really need these in the change message, we tend to assume that
the changes before submission aren't really relevant. I would advise
on removing these.

> Verified with the rtc-rs5c372 SMBus conversion patches currently in -mm.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> ---
> 
>  drivers/i2c/busses/Kconfig         |   10 
>  drivers/i2c/busses/Makefile        |    1 
>  drivers/i2c/busses/i2c-sh_mobile.c |  498 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 509 insertions(+)
> 
> --- 0001/drivers/i2c/busses/Kconfig
> +++ work/drivers/i2c/busses/Kconfig	2008-03-28 16:45:42.000000000 +0900
> @@ -672,4 +672,14 @@ config I2C_PMCMSP
>  	  This driver can also be built as module. If so, the module
>  	  will be called i2c-pmcmsp.
>  
> +config I2C_SH_MOBILE
> +	tristate "SuperH Mobile I2C Controller"
> +	depends on SUPERH
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  built-in I2C interface on the Renesas SH-Mobile processor.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-sh_mobile.
> +
>  endmenu
> --- 0001/drivers/i2c/busses/Makefile
> +++ work/drivers/i2c/busses/Makefile	2008-03-28 16:35:37.000000000 +0900
> @@ -52,6 +52,7 @@ obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
>  obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
>  obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
>  obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
> +obj-$(CONFIG_I2C_SH_MOBILE)	+= i2c-sh_mobile.o
>  
>  ifeq ($(CONFIG_I2C_DEBUG_BUS),y)
>  EXTRA_CFLAGS += -DDEBUG
> --- /dev/null
> +++ work/drivers/i2c/busses/i2c-sh_mobile.c	2008-03-28 17:24:11.000000000 +0900
> @@ -0,0 +1,498 @@
> +/*
> + * SuperH Mobile I2C Controller
> + *
> + * Copyright (C) 2008 Magnus Damm
> + *
> + * Based on i2c-simtec.c by Ben Dooks <ben@simtec.co.uk>
> + * Copyright (C) 2005 Simtec Electronics
> + *

I think you can probably entirely remove that, I don't see enough of
a similarity with my i2c-simtec driver (a cpld based gpio style
adaptor).

> + * Portions of the code based on out-of-tree driver i2c-sh7343.c
> + * Copyright (c) 2006 Carlos Munoz <carlos@kenati.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +enum {
> +	OP_START = 0,
> +	OP_TX_ONLY,
> +	OP_TX_STOP,
> +	OP_TX_TO_RX,
> +	OP_RX_ONLY,
> +	OP_RX_STOP,
> +};

Please name the enum something like sh_mobile_i2c_op, and use the
named enum when you are using this in the rest of the code, this way
gcc will catch missed cases in case statements.

> +
> +struct sh_mobile_i2c_data {
> +	struct device *dev;
> +	void __iomem *reg;
> +	struct i2c_adapter adap;
> +
> +	struct clk *clk;
> +	u_int8_t iccl;
> +	u_int8_t icch;
> +
> +	int fast_mode;
> +	int rx_ack_high;

interesting, why not use smaller variables or flags for these
variables?

> +
> +	spinlock_t lock;
> +	wait_queue_head_t wait;
> +	struct i2c_msg *msg;
> +	int pos;
> +	int sr;
> +};
> +
> +#define NORMAL_SPEED		100000
> +#define FAST_SPEED		400000
> +
> +/* Register offsets */
> +#define	ICDR(pd)		(pd->reg + 0x00)
> +#define	ICCR(pd)		(pd->reg + 0x04)
> +#define	ICSR(pd)		(pd->reg + 0x08)
> +#define	ICIC(pd)		(pd->reg + 0x0c)
> +#define	ICCL(pd)		(pd->reg + 0x10)
> +#define	ICCH(pd)		(pd->reg + 0x14)
> +
> +/* Register bits */
> +#define ICCR_ICE		0x80
> +#define ICCR_RACK		0x40
> +#define ICCR_TRS		0x10
> +#define ICCR_BBSY		0x04
> +#define ICCR_SCP		0x01
> +
> +#define ICSR_SCLM		0x80
> +#define ICSR_SDAM		0x40
> +#define SW_DONE			0x20
> +#define ICSR_BUSY		0x10
> +#define ICSR_AL			0x08
> +#define ICSR_TACK		0x04
> +#define ICSR_WAIT		0x02
> +#define ICSR_DTE		0x01
> +
> +#define ICIC_ALE		0x08
> +#define ICIC_TACKE		0x04
> +#define ICIC_WAITE		0x02
> +#define ICIC_DTEE		0x01
> +
> +static void activate_ch(struct sh_mobile_i2c_data *pd)
> +{
> +	/* Enable channel and configure rx ack */
> +	iowrite8(ioread8(ICCR(pd))  | ICCR_ICE |
> +		 (pd->rx_ack_high ? ICCR_RACK : 0), ICCR(pd));
> +
> +	/* Mask all interrupts */
> +	iowrite8(0, ICIC(pd));
> +
> +	/* Set the clock */
> +	iowrite8(pd->iccl, ICCL(pd));
> +	iowrite8(pd->icch, ICCH(pd));
> +}
> +
> +static void deactivate_ch(struct sh_mobile_i2c_data *pd)
> +{
> +	/* Clear/disable interrupts */
> +	iowrite8(0, ICSR(pd));
> +	iowrite8(0, ICIC(pd));
> +
> +	/* Initialize channel */
> +	iowrite8(ioread8(ICCR(pd)) & ~ICCR_ICE, ICCR(pd));
> +}
> +
> +static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
> +			    int op, unsigned char data)

see above comment on the use of the named enum for the op field.

> +{
> +	unsigned char ret = 0;
> +	unsigned long flags;
> +
> +	dev_dbg(pd->dev, "op %d, data in 0x%02x\n", op, data);
> +
> +	spin_lock_irqsave(&pd->lock, flags);
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
> +	spin_unlock_irqrestore(&pd->lock, flags);
> +
> +	dev_dbg(pd->dev, "op %d, data out 0x%02x\n", op, ret);
> +	return ret;
> +}
> +
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
> +		wakeup = 1;
> +		goto do_wakeup;
> +	}
> +
> +	if (pd->pos = -1) {
> +		data = (msg->addr & 0x7f) << 1;
> +		data |= (msg->flags & I2C_M_RD) ? 1 : 0;
> +	} else
> +		data = msg->buf[pd->pos];
> +
> +	if ((pd->pos = -1) || !(msg->flags & I2C_M_RD)) {
> +		if (msg->flags & I2C_M_RD)
> +			i2c_op(pd, OP_TX_TO_RX, data);
> +		else if (pd->pos = (msg->len - 1)) {
> +			i2c_op(pd, OP_TX_STOP, data);
> +			wakeup = 1;
> +		} else
> +			i2c_op(pd, OP_TX_ONLY, data);
> +	} else {
> +		if (pd->pos = (msg->len - 1))
> +			data = i2c_op(pd, OP_RX_STOP, 0);
> +		else
> +			data = i2c_op(pd, OP_RX_ONLY, 0);
> +
> +		msg->buf[pd->pos] = data;
> +	}
> +	pd->pos++;
> +
> + do_wakeup:
> +	if (wakeup) {
> +		pd->sr |= SW_DONE;
> +		wake_up(&pd->wait);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg)
> +{
> +	/* Initialize channel registers */
> +	iowrite8(ioread8(ICCR(pd)) & ~ICCR_ICE, ICCR(pd));
> +
> +	/* Enable channel and configure rx ack */
> +	iowrite8(ioread8(ICCR(pd)) | ICCR_ICE |
> +		 (pd->rx_ack_high ? ICCR_RACK : 0), ICCR(pd));
> +
> +	/* Set the clock */
> +	iowrite8(pd->iccl, ICCL(pd));
> +	iowrite8(pd->icch, ICCH(pd));
> +
> +	pd->msg = usr_msg;
> +	pd->pos = -1;
> +	pd->sr = 0;
> +
> +	/* Enable all interrupts except wait */
> +	iowrite8(ioread8(ICIC(pd)) | ICIC_ALE | ICIC_TACKE | ICIC_DTEE,
> +		 ICIC(pd));
> +	return 0;
> +}
> +
> +static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
> +			      struct i2c_msg *msgs,
> +			      int num)
> +{
> +	struct sh_mobile_i2c_data *pd = i2c_get_adapdata(adapter);
> +	struct i2c_msg	*msg;
> +	int err = 0;
> +	u_int8_t val;
> +	int i, k;
> +
> +	activate_ch(pd);
> +
> +	/* Process all messages */
> +	for (i = 0; i < num; i++) {
> +		msg = &msgs[i];
> +
> +		err = start_ch(pd, msg);
> +		if (err)
> +			break;
> +
> +		i2c_op(pd, OP_START, 0);
> +
> +		/* The interrupt handler takes care of the rest... */
> +		k = wait_event_timeout(pd->wait,
> +				       pd->sr & (ICSR_TACK | SW_DONE),
> +				       5 * HZ);
> +		if (!k)
> +			dev_err(pd->dev, "Transfer request timed out\n");
> +

Recycling k like this isn't pleasant, but isn't really a show stopper
on getting this driver, however it isn't helpful when trying to work
out what is going on in this loop, so it might be better to try and
split the usage and give them seperate variables such as 'ret' and
'retry_count'.

> +		k = 10;
> +again:
> +		val = ioread8(ICSR(pd));
> +
> +		dev_dbg(pd->dev, "val 0x%02x pd->sr 0x%02x!\n", val, pd->sr);

do you really need that exclamation mark?

> +
> +		if ((val | pd->sr) & (ICSR_TACK | ICSR_AL)) {
> +			err = -EIO;
> +			break;
> +		}
> 

IIRC, the error for not receiving an ACK is -ECONNREFUSED when
transfering data and -EREMOTEIO when sending the device address,
and you should also check the message flags appropriately for
I2C_M_IGNORE_ACK.

> +
> +		if (!(!(val & ICSR_BUSY) && (val & ICSR_SCLM) &&
> +		      (val & ICSR_SDAM))) {
> +			msleep(1);

I assume this is the reason why you aren't trying to go to the next
message in the ISR. Out of interest, why is this here, adding a
comment would explain what is going on here.

> +			if (k--)
> +				goto again;
> +
> +			err = -EIO;
> +			dev_err(pd->dev, "Polling timed out\n");
> +			break;
> +		}
> +	}
> +
> +	deactivate_ch(pd);
> +
> +	if (!err)
> +		err = num;
> +	return err;
> +}
> +
> +static u32 sh_mobile_i2c_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static struct i2c_algorithm sh_mobile_i2c_algorithm = {
> +	.functionality	= sh_mobile_i2c_func,
> +	.master_xfer	= sh_mobile_i2c_xfer,
> +};
> +
> +static void sh_mobile_i2c_setup_channel(struct platform_device *dev)
> +{
> +	struct sh_mobile_i2c_data *pd = platform_get_drvdata(dev);
> +	unsigned long peripheral_clk = clk_get_rate(pd->clk);
> +	u_int32_t num;
> +	u_int32_t denom;
> +	u_int32_t tmp;
> +
> +	spin_lock_init(&pd->lock);
> +	init_waitqueue_head(&pd->wait);
> +
> +	/* Calculate the value for iccl. From the data sheet:
> +	 * iccl = (p clock ÷ transfer rate) × (L ÷ (L + H))
> +	 * where L and H are the SCL low/high ratio (5/4 in this case).
> +	 * We also round off the result.
> +	 */

there are some weird encoding characters in this message, making it
difficult to work out what is going on here.

> +	num = peripheral_clk * 5;
> +	denom = pd->fast_mode ? (FAST_SPEED * 9) : (NORMAL_SPEED * 9);
> +	tmp = num * 10 / denom;
> +	if (tmp % 10 >= 5)
> +		pd->iccl = (u_int8_t)((num/denom) + 1);
> +	else
> +		pd->iccl = (u_int8_t)(num/denom);

Is this a case of using the division macros that round up? 

> +
> +	/* Calculate the value for icch. From the data sheet:
> +	   icch = (p clock ÷ transfer rate) × (H ÷ (L + H)) */
> +	num = peripheral_clk * 4;
> +	tmp = num * 10 / denom;
> +	if (tmp % 10 >= 5)
> +		pd->icch = (u_int8_t)((num/denom) + 1);
> +	else
> +		pd->icch = (u_int8_t)(num/denom);
> +
> +	deactivate_ch(pd);
> +}
> +
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
> +			if (request_irq(n, sh_mobile_i2c_isr, IRQF_DISABLED,
> +					dev->dev.bus_id, dev))
> +				goto rollback;
> +		}
> +		k++;
> +	}
> +
> +	if (hook)
> +		return k > 0 ? 0 : -ENOENT;
> +
> +	k--;
> +	ret = 0;
> +
> + rollback:
> +	for (q = k; k >= 0; k--) {
> +		for (m = n; m >= res->start; m--)
> +			free_irq(m, dev);
> +
> +		res = platform_get_resource(dev, IORESOURCE_IRQ, k - 1);
> +		m = res->end;
> +	}
> +
> +	return ret;
> +}

How many IRQs can one controller have?

> +
> +static int sh_mobile_i2c_probe(struct platform_device *dev)
> +{
> +	struct sh_mobile_i2c_data *pd;
> +	struct i2c_adapter *adap;
> +	struct resource *res;
> +	int size;
> +	int ret;
> +
> +	pd = kzalloc(sizeof(struct sh_mobile_i2c_data), GFP_KERNEL);
> +	if (pd = NULL) {
> +		dev_err(&dev->dev, "cannot allocate private data\n");
> +		return -ENOMEM;
> +	}
> +
> +	pd->clk = clk_get(&dev->dev, "peripheral_clk");
> +	if (IS_ERR(pd->clk)) {
> +		dev_err(&dev->dev, "cannot get peripheral clock\n");
> +		ret = PTR_ERR(pd->clk);
> +		goto err;
> +	}

I note that you do not call clk_enable() or clk_disable() for this
clock, is this some form of global always-on clock, or is an
assumption that some other driver is holding the clock open for you?

> +
> +	ret = sh_mobile_i2c_hook_irqs(dev, 1);
> +	if (ret) {
> +		dev_err(&dev->dev, "cannot request IRQ\n");
> +		goto err_clk;
> +	}
> +
> +	pd->dev = &dev->dev;
> +	platform_set_drvdata(dev, pd);
> +
> +	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (res = NULL) {
> +		dev_err(&dev->dev, "cannot find IO resource\n");
> +		ret = -ENOENT;
> +		goto err_irq;
> +	}
> +
> +	size = (res->end - res->start) + 1;

hmm, has no-one done as res_size() macro yet?

> +
> +	pd->reg = ioremap(res->start, size);
> +	if (pd->reg = NULL) {
> +		dev_err(&dev->dev, "cannot map IO\n");
> +		ret = -ENXIO;
> +		goto err_irq;
> +	}
> +
> +	/* setup the private data */
> +	adap = &pd->adap;
> +	i2c_set_adapdata(adap, pd);
> +
> +	adap->owner = THIS_MODULE;
> +	adap->algo = &sh_mobile_i2c_algorithm;
> +	adap->dev.parent = &dev->dev;
> +	adap->retries = 5;
> +	adap->nr = dev->id;
> +
> +	strlcpy(adap->name, dev->name, sizeof(adap->name));
> +
> +	sh_mobile_i2c_setup_channel(dev);
> +
> +	ret = i2c_add_numbered_adapter(adap);
> +	if (ret < 0)
> +		goto err_all;

Adding a dev_err() statement here to say the adaptor attach failed
would be useful, especially as there are dev_err() statements on all
the other probe points.

> +
> +	return 0;
> +
> + err_all:
> +	iounmap(pd->reg);
> + err_irq:
> +	sh_mobile_i2c_hook_irqs(dev, 0);
> + err_clk:
> +	clk_put(pd->clk);
> + err:
> +	kfree(pd);
> +	return ret;
> +}
> +
> +static int sh_mobile_i2c_remove(struct platform_device *dev)
> +{
> +	struct sh_mobile_i2c_data *pd = platform_get_drvdata(dev);
> +
> +	i2c_del_adapter(&pd->adap);
> +	iounmap(pd->reg);
> +	sh_mobile_i2c_hook_irqs(dev, 0);
> +	clk_put(pd->clk);
> +	kfree(pd);
> +	return 0;
> +}
> +
> +static struct platform_driver sh_mobile_i2c_driver = {
> +	.driver		= {
> +		.name		= "i2c-sh_mobile",
> +		.owner		= THIS_MODULE,
> +	},
> +	.probe		= sh_mobile_i2c_probe,
> +	.remove		= sh_mobile_i2c_remove,
> +};

Possibly you should make the .remove function be __devexit and the
the .remove entry be an __devexit_p() macro.

No suspend and resume support? Not a show stopper, but would have
been nice to see.

> +static int __init sh_mobile_i2c_adap_init(void)
> +{
> +	return platform_driver_register(&sh_mobile_i2c_driver);
> +}
> +
> +static void __exit sh_mobile_i2c_adap_exit(void)
> +{
> +	platform_driver_unregister(&sh_mobile_i2c_driver);
> +}
> +
> +module_init(sh_mobile_i2c_adap_init);
> +module_exit(sh_mobile_i2c_adap_exit);
> +
> +MODULE_DESCRIPTION("SuperH Mobile I2C Bus Controller driver");
> +MODULE_AUTHOR("Magnus Damm");
> +MODULE_LICENSE("GPL");

IIRC, your header license says GPL v2, so this should be changed to
agree with that statement.

Overall, the code looks fine other than a few comments could be added
and possibly some function descriptions before their declerations so
that you can get an idea of what is going on in them.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
