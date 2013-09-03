From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 03 Sep 2013 12:56:46 +0000
Subject: Re: [PATCH] EMMA: Add em i2c driver
Message-Id: <5225DC8E.7070001@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <CANqRtoRK+Ur=87-me7CpP+s9SO5g0ZVZSEOrqwDf4HFfjZZmZA@mail.gmail.com> <1378207832-3412-1-git-send-email-ian.molton@codethink.co.uk> <1378207832-3412-2-git-send-email-ian.molton@codethink.co.uk>
In-Reply-To: <1378207832-3412-2-git-send-email-ian.molton@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian.molton@codethink.co.uk>
Cc: magnus.damm@gmail.com, grant.likely@linaro.org, rob.herring@calxeda.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org

On 03/09/13 12:30, Ian Molton wrote:
> Add a driver for the EMMA mobile I2C block.
>
> The driver supports low and high-speed interrupt driven PIO transfers.
>
> Signed-off-by: Ian Molton<ian.molton@codethink.co.uk>
> ---
>   drivers/i2c/busses/Kconfig  |   10 +
>   drivers/i2c/busses/Makefile |    1 +
>   drivers/i2c/busses/i2c-em.c |  534 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 545 insertions(+)
>   create mode 100644 drivers/i2c/busses/i2c-em.c
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index dc6dea6..e5cda34 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -777,6 +777,16 @@ config I2C_RCAR
>   	  This driver can also be built as a module.  If so, the module
>   	  will be called i2c-rcar.
>
> +config I2C_EM
> +	tristate "EMMA Mobile series I2C adapter"
> +	depends on I2C&&  HAVE_CLK
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  I2C interface on the Renesas Electronics EM/EV of processors.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-em
> +
>   comment "External I2C/SMBus adapter drivers"
>
>   config I2C_DIOLAN_U2C
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index d00997f..f7022ab 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
>   obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
>   obj-$(CONFIG_I2C_XLR)		+= i2c-xlr.o
>   obj-$(CONFIG_I2C_RCAR)		+= i2c-rcar.o
> +obj-$(CONFIG_I2C_EM)            += i2c-em.o
>
>   # External I2C/SMBus adapter drivers
>   obj-$(CONFIG_I2C_DIOLAN_U2C)	+= i2c-diolan-u2c.o
> diff --git a/drivers/i2c/busses/i2c-em.c b/drivers/i2c/busses/i2c-em.c
> new file mode 100644
> index 0000000..e8fc7aa
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-em.c
> @@ -0,0 +1,534 @@
> +/*
> + * (c) 2013 Ian Molton<ian.molton@codethink.co.uk>

Copyright Codethink Ltd.

> + * Parts (c) 2010 Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software Foundation,
> + * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1335, USA.
> + */
> +
> +#include<linux/kernel.h>
> +#include<linux/module.h>
> +#include<linux/init.h>
> +#include<linux/delay.h>
> +#include<linux/of_i2c.h>
> +#include<linux/clk.h>
> +#include<linux/io.h>
> +#include<linux/sched.h>
> +
> +#include<linux/interrupt.h>
> +#include<linux/device.h>
> +#include<linux/of_device.h>
> +#include<linux/platform_device.h>
> +
> +/* INT Reg */
> +#define EMXX_I2C_INT_RAW	(IO_ADDRESS(EMXX_INTA_D_BASE) + 0x014)
> +#define EMXX_I2C_INT_IIR	(IO_ADDRESS(EMXX_INTA_D_BASE) + 0x024)

couldn't find these being used, can they be removed?

> +/* INT Reg bit */
> +#define EMXX_I2C0_INTC_MST	(1<<  0)
> +#define EMXX_I2C1_INTC_MST	(1<<  1)
> +#define EMXX_I2C0_INTC_IIR	(1<<  16)
> +#define EMXX_I2C1_INTC_IIR	(1<<  17)
> +
> +/* I2C Registers */
> +
> +#define I2C_OFS_IICACT0		0x00	/* start */
> +#define I2C_OFS_IIC0		0x04	/* shift */
> +#define I2C_OFS_IICC0		0x08	/* control */
> +#define I2C_OFS_SVA0		0x0c	/* slave address */
> +#define I2C_OFS_IICCL0		0x10	/* clock select */
> +#define I2C_OFS_IICX0		0x14	/* extention */
> +#define I2C_OFS_IICS0		0x18	/* status */
> +#define I2C_OFS_IICSE0		0x1c	/* status For emulation */
> +#define I2C_OFS_IICF0		0x20	/* IIC flag */
> +
> +
> +/* I2C IICACT0 Masks */
> +#define I2C_BIT_IICE0		0x0001
> +
> +/* I2C IICC0 Masks */
> +#define I2C_BIT_LREL0		0x0040
> +#define I2C_BIT_WREL0		0x0020
> +#define I2C_BIT_SPIE0		0x0010
> +#define I2C_BIT_WTIM0		0x0008
> +#define I2C_BIT_ACKE0		0x0004
> +#define I2C_BIT_STT0		0x0002
> +#define I2C_BIT_SPT0		0x0001
> +
> +/* I2C IICCL0 Masks */
> +#define I2C_BIT_CLD0		0x0020
> +#define I2C_BIT_DAD0		0x0010
> +#define I2C_BIT_SMC0		0x0008
> +#define I2C_BIT_DFC0		0x0004
> +#define I2C_BIT_CLO1		0x0002
> +#define I2C_BIT_CLO0		0x0001
> +
> +/* I2C IICSE0 Masks */
> +#define I2C_BIT_MSTS0		0x0080
> +#define I2C_BIT_ALD0		0x0040
> +#define I2C_BIT_EXC0		0x0020
> +#define I2C_BIT_COI0		0x0010
> +#define I2C_BIT_TRC0		0x0008
> +#define I2C_BIT_ACKD0		0x0004
> +#define I2C_BIT_STD0		0x0002
> +#define I2C_BIT_SPD0		0x0001
> +
> +/* I2C IICF0 Masks */
> +#define I2C_BIT_STCF		0x0080
> +#define I2C_BIT_IICBSY		0x0040
> +#define I2C_BIT_STCEN		0x0002
> +#define I2C_BIT_IICRSV		0x0001
> +
> +/* For setting of sending and receiving */
> +#define I2C_DIR_R		0x01
> +
> +static int em_i2c_xfer(struct i2c_adapter *, struct i2c_msg[], int);
> +
> +struct em_i2c_device {
> +	struct i2c_adapter	adap;
> +	wait_queue_head_t	i2c_wait;
> +	void __iomem		*membase;
> +	struct clk              *clk;
> +	struct clk              *sclk;
> +	int			irq;
> +	int			flags;
> +	int			pending;
> +	spinlock_t              irq_lock;
> +};
> +
> +static u32 em_i2c_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static struct i2c_algorithm em_i2c_algo = {
> +	.master_xfer = em_i2c_xfer,
> +	.smbus_xfer = NULL,
> +	.functionality = em_i2c_func,
> +};
> +
> +static void em_i2c_enable_clock(struct em_i2c_device *i2c_dev)
> +{
> +	clk_enable(i2c_dev->clk);
> +	clk_enable(i2c_dev->sclk);
> +}
> +
> +static void em_i2c_disable_clock(struct em_i2c_device *i2c_dev)
> +{
> +	clk_disable(i2c_dev->sclk);
> +	clk_disable(i2c_dev->clk);
> +}
> +
> +static int em_i2c_wait_for_event(struct em_i2c_device *i2c_dev, u16 *status)
> +{
> +	int interrupted;
> +
> +	do {
> +		interrupted = wait_event_interruptible_timeout(
> +				i2c_dev->i2c_wait, i2c_dev->pending,
> +				i2c_dev->adap.timeout);
> +
> +		if (i2c_dev->pending) {
> +			spin_lock_irq(&i2c_dev->irq_lock);
> +			i2c_dev->pending = 0;
> +			spin_unlock_irq(&i2c_dev->irq_lock);
> +			*status = readl(i2c_dev->membase + I2C_OFS_IICSE0);
> +			return 0;
> +		}
> +
> +	} while (interrupted);
> +
> +	*status = 0;
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int em_i2c_stop(struct em_i2c_device *i2c_dev)
> +{
> +	u16 status;
> +
> +	/* Send Stop condition */
> +	writel((readl(i2c_dev->membase + I2C_OFS_IICC0) | I2C_BIT_SPT0 |
> +		I2C_BIT_SPIE0), i2c_dev->membase + I2C_OFS_IICC0);
> +
> +	/* Wait for stop condition */
> +	em_i2c_wait_for_event(i2c_dev,&status);
> +	/* FIXME - check status? */
> +
> +	if ((readl(i2c_dev->membase + I2C_OFS_IICSE0)&  I2C_BIT_SPD0) != 0)
> +		return 0;
> +
> +	return -EBUSY;
> +}
> +
> +static int em_i2c_start(struct em_i2c_device *i2c_dev)
> +{
> +	/* Send start condition */
> +	writel((readl(i2c_dev->membase + I2C_OFS_IICC0)) | I2C_BIT_ACKE0 |
> +		I2C_BIT_WTIM0, i2c_dev->membase + I2C_OFS_IICC0);
> +
> +	writel((readl(i2c_dev->membase + I2C_OFS_IICC0) | I2C_BIT_STT0),
> +		i2c_dev->membase + I2C_OFS_IICC0);
> +
> +	return -EBUSY;
> +}
> +
> +static void em_i2c_reset(struct i2c_adapter *adap)
> +{
> +	struct em_i2c_device *i2c_dev > +		(struct em_i2c_device *)(i2c_get_adapdata(adap));
> +
> +	/* If I2C active */
> +	if (readl(i2c_dev->membase + I2C_OFS_IICACT0)&  I2C_BIT_IICE0) {
> +
> +		/* Disable I2C operation */
> +		writel(0, i2c_dev->membase + I2C_OFS_IICACT0);
> +
> +		while (readl(i2c_dev->membase + I2C_OFS_IICACT0) = 1)
> +			;
> +	}
> +
> +	/* Transfer mode set */
> +	writel(i2c_dev->flags, i2c_dev->membase + I2C_OFS_IICCL0);
> +
> +	/* Can Issue start without detecting a stop, Reservation disabled. */
> +	writel(I2C_BIT_STCEN | I2C_BIT_IICRSV,
> +		i2c_dev->membase + I2C_OFS_IICF0);
> +
> +	/* I2C enable, 9 bit interrupt mode */
> +	writel(I2C_BIT_WTIM0, i2c_dev->membase + I2C_OFS_IICC0);
> +
> +	/* Enable I2C operation */
> +	writel(I2C_BIT_IICE0, i2c_dev->membase + I2C_OFS_IICACT0);
> +
> +	while (readl(i2c_dev->membase + I2C_OFS_IICACT0) = 0)
> +		;
> +}
> +
> +static int __em_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
> +				int stop)
> +{
> +	struct em_i2c_device *i2c_dev > +		(struct em_i2c_device *)i2c_get_adapdata(adap);
> +	int count = 0;
> +	u16 status;
> +
> +	/* Start transfer */
> +	em_i2c_start(i2c_dev);
> +
> +	/* Send slave address and R/W type */
> +	writel((msg->addr<<  1) | ((msg->flags&  I2C_M_RD) ? 1 : 0),
> +		i2c_dev->membase + I2C_OFS_IIC0);
> +
> +	/* Wait for transaction */
> +	if (em_i2c_wait_for_event(i2c_dev,&status))
> +		goto out_reset;
> +
> +	/* Arbitration, Extension mode or Slave mode are all errors */
> +	if (status&  (I2C_BIT_EXC0 | I2C_BIT_COI0 | I2C_BIT_ALD0)
> +			|| !(status&  I2C_BIT_MSTS0))
> +		goto out_reset;
> +
> +	/* Extra setup for read transactions */
> +	if (!(status&  I2C_BIT_TRC0)) {
> +
> +		/* msg->flags is Write type */
> +		if (!(msg->flags&  I2C_M_RD))
> +			goto out_reset;
> +
> +		/* Recieved No ACK (result of setting slave address and R/W) */
> +		if (!(status&  I2C_BIT_ACKD0)) {
> +			em_i2c_stop(i2c_dev);
> +			goto out;
> +		}
> +
> +		/* 8 bit interrupt mode */
> +		writel((readl(i2c_dev->membase + I2C_OFS_IICC0)
> +				&  ~I2C_BIT_WTIM0) | I2C_BIT_ACKE0,
> +				i2c_dev->membase + I2C_OFS_IICC0);
> +		writel((readl(i2c_dev->membase + I2C_OFS_IICC0)
> +				&  ~I2C_BIT_WTIM0) | I2C_BIT_WREL0,
> +				i2c_dev->membase + I2C_OFS_IICC0);
> +
> +		/* Wait for transaction */
> +		if (em_i2c_wait_for_event(i2c_dev,&status))
> +			goto out_reset;
> +	}
> +
> +	/* Send / receive data */
> +	do {
> +		/* Arbitration, Extension mode or Slave mode are errors*/
> +		if (status&  (I2C_BIT_EXC0 | I2C_BIT_COI0 | I2C_BIT_ALD0)
> +				|| !(status&  I2C_BIT_MSTS0))
> +			goto out_reset;
> +
> +		if (!(status&  I2C_BIT_TRC0)) { /* Read transaction */
> +
> +			/* msg->flags is Write type */
> +			if (!(msg->flags&  I2C_M_RD))
> +				goto out_reset;
> +
> +			if (count = msg->len)
> +				break;
> +
> +			msg->buf[count++] > +				readl(i2c_dev->membase + I2C_OFS_IIC0);
> +
> +
> +			writel((readl(i2c_dev->membase + I2C_OFS_IICC0)
> +				| I2C_BIT_WREL0),
> +				i2c_dev->membase + I2C_OFS_IICC0);
> +
> +		} else { /* Write transaction */
> +
> +			/* msg->flags is Read type */
> +			if ((msg->flags&  I2C_M_RD))
> +				goto out_reset;
> +
> +			/* Recieved No ACK */
> +			if (!(status&  I2C_BIT_ACKD0)) {
> +				em_i2c_stop(i2c_dev);
> +				goto out;
> +			}
> +
> +			if (count = msg->len)
> +				break;
> +
> +			/* Write data */
> +			writel(msg->buf[count++], i2c_dev->membase
> +				+ I2C_OFS_IIC0);
> +		}
> +
> +		/* Wait for R/W transaction */
> +		if (em_i2c_wait_for_event(i2c_dev,&status))
> +			goto out_reset;
> +
> +	} while (1);
> +
> +	if (stop)
> +		em_i2c_stop(i2c_dev);
> +
> +	return count;
> +
> +out_reset:
> +	em_i2c_reset(adap);
> +out:
> +	return -EREMOTEIO;
> +}
> +
> +static int em_i2c_wait_free(struct i2c_adapter *adap)
> +{
> +	struct em_i2c_device *i2c_dev;
> +	int status;
> +	int timeout = adap->timeout;
> +
> +	i2c_dev = (struct em_i2c_device *)(i2c_get_adapdata(adap));
> +
> +	/* wait until I2C bus free */
> +	while ((readl(i2c_dev->membase + I2C_OFS_IICF0)&  I2C_BIT_IICBSY)
> +			&&  timeout--) {
> +		schedule_timeout_uninterruptible(1);
> +	}
> +
> +	status = (timeout<= 0);
> +
> +	if (status)
> +		dev_info(&adap->dev, "I2C bus is busy\n");
> +
> +	return status;
> +}
> +
> +static int em_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +	int num)
> +{
> +	struct em_i2c_device *i2c_dev > +		(struct em_i2c_device *)(i2c_get_adapdata(adap));

if this is used enough it may have been easier to add an to_em_i2c()
macro.

> +	int ret = 0;
> +	int i;
> +
> +	if (msgs = NULL)
> +		return -EINVAL;
> +
> +	for (i = 0; i<  num; i++)
> +		if (msgs[i].buf = NULL)
> +			return -EINVAL;

do we really need this check? does the core validate the
message list beforehand, and has anyone been silly enough
to do this from a driver?

> +	em_i2c_enable_clock(i2c_dev);
> +	em_i2c_reset(adap);
> +
> +	/* Attempt to gain control of the adapter */
> +	i = 0;
> +	while (em_i2c_wait_free(adap)) {
> +		switch (i) {
> +		case 0:
> +			if (!(readl(i2c_dev->membase + I2C_OFS_IICSE0)
> +					&  I2C_BIT_MSTS0)) {
> +				/* Slave mode ->  Error */
> +				ret = -EBUSY;
> +				goto out;
> +			}
> +
> +			em_i2c_stop(i2c_dev);
> +			break;
> +		case 1:
> +			em_i2c_reset(adap);
> +			break;
> +		case 2:
> +			ret = -EREMOTEIO;
> +			goto out;
> +		}
> +		i++;
> +	}
> +
> +	/* Send messages */
> +	for (i = 0; i<  num; i++) {
> +		ret = __em_i2c_xfer(adap,&msgs[i], (i = (num - 1)));
> +		if (ret<  0)
> +			goto out;
> +	}
> +
> +	/* I2C transfer completed */
> +	ret = i;
> +
> +out:
> +	em_i2c_disable_clock(i2c_dev);
> +
> +	return ret;
> +}
> +
> +static irqreturn_t em_i2c_irq_handler(int this_irq, void *dev_id)
> +{
> +	struct em_i2c_device *i2c_dev = dev_id;
> +
> +	i2c_dev->pending = 1;
> +
> +	wake_up_interruptible(&i2c_dev->i2c_wait);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int em_i2c_probe(struct platform_device *pdev)
> +{
> +	struct em_i2c_device *i2c_dev;
> +	struct resource *r;
> +	int ret;
> +
> +	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(struct em_i2c_device),
> +				GFP_KERNEL);
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	i2c_dev->membase = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(i2c_dev->membase))
> +		return PTR_ERR(i2c_dev->membase);
> +
> +	strlcpy(i2c_dev->adap.name, "em_i2c", sizeof(i2c_dev->adap.name));
> +
> +	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (!IS_ERR(i2c_dev->clk))
> +		clk_prepare(i2c_dev->clk);
> +
> +	i2c_dev->sclk = devm_clk_get(&pdev->dev, "sclk");
> +	if (!IS_ERR(i2c_dev->sclk))
> +		clk_prepare(i2c_dev->sclk);
> +
> +	i2c_dev->irq = platform_get_irq(pdev, 0);
> +	i2c_dev->adap.timeout = msecs_to_jiffies(100);
> +	i2c_dev->adap.dev.parent =&pdev->dev;
> +	i2c_dev->adap.algo =&em_i2c_algo;
> +	i2c_dev->adap.owner = THIS_MODULE;
> +	i2c_dev->adap.nr = pdev->id;
> +	i2c_dev->adap.dev.of_node = pdev->dev.of_node;
> +
> +	init_waitqueue_head(&i2c_dev->i2c_wait);
> +
> +	spin_lock_init(&i2c_dev->irq_lock);
> +
> +	i2c_dev->flags = I2C_BIT_DFC0;
> +
> +	if (of_find_property(pdev->dev.of_node, "high-speed", NULL))
> +		i2c_dev->flags |= I2C_BIT_SMC0;

is there no standard i2c property for bus speed you could check
for being >100kHz?

> +	platform_set_drvdata(pdev, i2c_dev);
> +	i2c_set_adapdata(&i2c_dev->adap, i2c_dev);
> +
> +	em_i2c_enable_clock(i2c_dev);
> +	em_i2c_reset(&i2c_dev->adap);
> +	em_i2c_disable_clock(i2c_dev);
> +
> +	ret = devm_request_irq(&pdev->dev, i2c_dev->irq, em_i2c_irq_handler, 0,
> +				"em_i2c", i2c_dev);
> +
> +	if (ret)
> +		goto exit_clk;
> +
> +	ret = i2c_add_numbered_adapter(&i2c_dev->adap);
> +
> +	if (ret != 0)
> +		goto exit_clk;
> +
> +	of_i2c_register_devices(&i2c_dev->adap);
> +
> +	dev_info(&pdev->dev, "Added i2c controller %d irq %d @ 0x%p\n",
> +		i2c_dev->adap.nr, i2c_dev->irq, i2c_dev->membase);
> +
> +	return 0;
> +
> +exit_clk:
> +	clk_disable(i2c_dev->clk);
> +	clk_unprepare(i2c_dev->clk);
> +	return ret;
> +}
> +
> +static int em_i2c_remove(struct platform_device *dev)
> +{
> +	struct em_i2c_device *i2c_dev = platform_get_drvdata(dev);
> +
> +	i2c_del_adapter(&i2c_dev->adap);
> +
> +	clk_disable(i2c_dev->clk);
> +	clk_unprepare(i2c_dev->clk);
> +
> +	return 0;
> +}
> +
> +static struct of_device_id em_i2c_ids[] = {
> +	{ .compatible = "renesas,em-i2c", },
> +	{ }
> +};

module device table is also missing here.

> +static struct platform_driver em_i2c_driver = {
> +	.probe = em_i2c_probe,
> +	.remove = em_i2c_remove,
> +	.driver = {
> +		.name = "em-i2c",
> +		.owner = THIS_MODULE,
> +		.of_match_table = em_i2c_ids,
> +	}
> +};


> +
> +static int __init em_i2c_init(void)
> +{
> +	return platform_driver_register(&em_i2c_driver);
> +}
> +
> +static void __exit em_i2c_exit(void)
> +{
> +	platform_driver_unregister(&em_i2c_driver);
> +}
> +
> +MODULE_LICENSE("GPLv2");
> +
> +module_init(em_i2c_init);
> +module_exit(em_i2c_exit);

see previous comments about the module_platform_driver() macro.

also
MODULE_DESCRIPTION() is missing
MODULE_AUTHOR() is missing


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
