From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 10 Aug 2008 14:29:31 +0000
Subject: Re: [PATCH] i2c: Renesas Highlander FPGA SMBus support, v2.
Message-Id: <20080810162931.3d9221af@hyperion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <20080731104354.GA21764@linux-sh.org>
In-Reply-To: <20080731104354.GA21764@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Trent Piepho <xyzzy@speakeasy.org>, Andrew Morton <akpm@linux-foundation.org>, i2c@lm-sensors.org, linux-sh@vger.kernel.org

Hi Paul,

On Thu, 31 Jul 2008 19:43:54 +0900, Paul Mundt wrote:
> This adds support for the SMBus adapter found in the various FPGAs on
> the Renesas Highlander platforms. Particularly the R0P7780LC0011RL and
> R0P7785LC0011RL FPGAs.
> 
> Functionality is fairly restricted, in that only byte and block data
> transfers are supported. Normal/fast mode and IRQ/polling are also
> supported. Primarily used for various RTCs and thermal sensors.
> 
> This version incorporates all of the comments from Jean Delvare and
> Trent Piepho.
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> 
> ---
> 
>  drivers/i2c/busses/Kconfig          |   12 
>  drivers/i2c/busses/Makefile         |    1 
>  drivers/i2c/busses/i2c-highlander.c |  495 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 508 insertions(+)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 6ee997b..e54b9fe 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -330,6 +330,18 @@ config I2C_GPIO
>  	  This is a very simple bitbanging I2C driver utilizing the
>  	  arch-neutral GPIO API to control the SCL and SDA lines.
>  
> +config I2C_HIGHLANDER
> +	tristate "Highlander FPGA SMBus interface"
> +	depends on SH_HIGHLANDER
> +	help
> +	  If you say yes to this option, support will be included for
> +	  the SMBus interface located in the FPGA on various Highlander
> +	  boards, particularly the R0P7780LC0011RL and R0P7785LC0011RL
> +	  FPGAs. This is wholly unrelated to the SoC I2C.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-highlander.
> +
>  config I2C_IBM_IIC
>  	tristate "IBM PPC 4xx on-chip I2C interface"
>  	depends on 4xx
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 97dbfa2..0c2c4b2 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_I2C_BLACKFIN_TWI)	+= i2c-bfin-twi.o
>  obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
>  obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
>  obj-$(CONFIG_I2C_GPIO)		+= i2c-gpio.o
> +obj-$(CONFIG_I2C_HIGHLANDER)	+= i2c-highlander.o
>  obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
>  obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
>  obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
> --- /dev/null	2008-06-05 00:27:47.457594308 +0900
> +++ b/drivers/i2c/busses/i2c-highlander.c	2008-07-31 19:35:26.000000000 +0900
> @@ -0,0 +1,495 @@
> +/*
> + * Renesas Solutions Highlander FPGA I2C/SMBus support.
> + *
> + * Supported devices: R0P7780LC0011RL, R0P7785LC0011RL
> + *
> + * Copyright (C) 2008  Paul Mundt
> + * Copyright (C) 2008  Renesas Solutions Corp.
> + * Copyright (C) 2008  Atom Create Engineering Co., Ltd.
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License version 2. See the file "COPYING" in the main directory
> + * of this archive for more details.
> + */
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/platform_device.h>
> +#include <linux/completion.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +
> +#define SMCR		0x00
> +#define SMCR_START	(1 << 0)
> +#define SMCR_IRIC	(1 << 1)
> +#define SMCR_BBSY	(1 << 2)
> +#define SMCR_ACKE	(1 << 3)
> +#define SMCR_RST	(1 << 4)
> +#define SMCR_IEIC	(1 << 6)
> +
> +#define SMSMADR		0x02
> +
> +#define SMMR		0x04
> +#define SMMR_MODE0	(1 << 0)
> +#define SMMR_MODE1	(1 << 1)
> +#define SMMR_CAP	(1 << 3)
> +#define SMMR_TMMD	(1 << 4)
> +#define SMMR_SP		(1 << 7)
> +
> +#define SMSADR		0x06
> +#define SMTRDR		0x46
> +
> +struct highlander_i2c_dev {
> +	struct device		*dev;
> +	void __iomem		*base;
> +	struct i2c_adapter	adapter;
> +	struct completion	cmd_complete;
> +	unsigned long		last_read_time;
> +	int			irq;
> +	u8			*buf;
> +	size_t			buf_len;
> +};
> +
> +static int iic_force_poll, iic_force_normal;
> +static int iic_timeout = 1000, iic_read_delay = 0;

There's a comment in the driver that says that this delay is needed for
several devices. So I'm a bit surprised that the default value is 0.
Shouldn't the default be such that the driver works on all devices by
default?

> +
> +static inline void highlander_i2c_irq_enable(struct highlander_i2c_dev *dev)
> +{
> +	iowrite16(ioread16(dev->base + SMCR) | SMCR_IEIC, dev->base + SMCR);
> +}
> +
> +static inline void highlander_i2c_irq_disable(struct highlander_i2c_dev *dev)
> +{
> +	iowrite16(ioread16(dev->base + SMCR) & ~SMCR_IEIC, dev->base + SMCR);
> +}
> +
> +static inline void highlander_i2c_start(struct highlander_i2c_dev *dev)
> +{
> +	iowrite16(ioread16(dev->base + SMCR) | SMCR_START, dev->base + SMCR);
> +}
> +
> +static inline void highlander_i2c_done(struct highlander_i2c_dev *dev)
> +{
> +	iowrite16(ioread16(dev->base + SMCR) | SMCR_IRIC, dev->base + SMCR);
> +}
> +
> +static void highlander_i2c_setup(struct highlander_i2c_dev *dev)
> +{
> +	u16 smmr;
> +
> +	smmr = ioread16(dev->base + SMMR);
> +	smmr |= SMMR_TMMD;
> +
> +	if (iic_force_normal)
> +		smmr &= ~SMMR_SP;
> +	else
> +		smmr |= SMMR_SP;
> +
> +	iowrite16(smmr, dev->base + SMMR);
> +}
> +
> +static void smbus_write_data(u8 *src, u16 *dst, int len)
> +{
> +	for (; len > 1; len -= 2) {
> +		*dst++ = be16_to_cpup((u16 *)src);
> +		src += 2;
> +	}
> +
> +	if (len)
> +		*dst = *src << 8;
> +}
> +
> +static void smbus_read_data(u16 *src, u8 *dst, int len)
> +{
> +	for (; len > 1; len -= 2) {
> +		*(u16 *)dst = cpu_to_be16p(src++);
> +		dst += 2;
> +	}
> +
> +	if (len)
> +		*dst = *src >> 8;
> +}
> +
> +static void highlander_i2c_command(struct highlander_i2c_dev *dev, u8 command, int len)
> +{
> +	unsigned int i;
> +	u16 cmd = (command << 8) | command;
> +
> +	for (i = 0; i < len; i += 2) {
> +		if (len - i = 1)
> +			cmd = command << 8;
> +		iowrite16(cmd, dev->base + SMSADR + i);
> +		dev_dbg(dev->dev, "command data[%x] 0x%04x\n", i/2, cmd);
> +	}
> +}
> +
> +static int highlander_i2c_wait_for_bbsy(struct highlander_i2c_dev *dev)
> +{
> +	unsigned long timeout;
> +
> +	timeout = jiffies + msecs_to_jiffies(iic_timeout);
> +	while (ioread16(dev->base + SMCR) & SMCR_BBSY) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_warn(dev->dev, "timeout waiting for bus ready\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		msleep(1);
> +	}
> +
> +	return 0;
> +}
> +
> +static int highlander_i2c_reset(struct highlander_i2c_dev *dev)
> +{
> +	iowrite16(ioread16(dev->base + SMCR) | SMCR_RST, dev->base + SMCR);
> +	return highlander_i2c_wait_for_bbsy(dev);
> +}
> +
> +static int highlander_i2c_wait_for_ack(struct highlander_i2c_dev *dev)
> +{
> +	u16 tmp = ioread16(dev->base + SMCR);
> +
> +	if ((tmp & (SMCR_IRIC | SMCR_ACKE)) = SMCR_ACKE) {
> +		dev_warn(dev->dev, "ack abnormality\n");
> +		return highlander_i2c_reset(dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t highlander_i2c_irq(int irq, void *dev_id)
> +{
> +	struct highlander_i2c_dev *dev = dev_id;
> +
> +	highlander_i2c_done(dev);
> +	complete(&dev->cmd_complete);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void highlander_i2c_poll(struct highlander_i2c_dev *dev)
> +{
> +	unsigned long timeout;
> +	u16 smcr;
> +
> +	timeout = jiffies + msecs_to_jiffies(iic_timeout);
> +	for (;;) {
> +		smcr = ioread16(dev->base + SMCR);
> +
> +		/*
> +		 * Don't bother checking ACKE here, this and the reset
> +		 * are handled in highlander_i2c_wait_xfer_done() when
> +		 * waiting for the ACK.
> +		 */
> +
> +		if (smcr & SMCR_IRIC)
> +			return;
> +		if (time_after(jiffies, timeout))
> +			break;
> +
> +		cpu_relax();
> +		cond_resched();
> +	}
> +
> +	dev_err(dev->dev, "polling timed out\n");
> +}
> +
> +static inline int highlander_i2c_wait_xfer_done(struct highlander_i2c_dev *dev)
> +{
> +	if (dev->irq)
> +		wait_for_completion_interruptible_timeout(&dev->cmd_complete,
> +					  msecs_to_jiffies(iic_timeout));
> +	else
> +		/* busy looping, the IRQ of champions */
> +		highlander_i2c_poll(dev);
> +
> +	return highlander_i2c_wait_for_ack(dev);
> +}
> +
> +static int highlander_i2c_read(struct highlander_i2c_dev *dev)
> +{
> +	int i, cnt;
> +	u16 data[16];
> +
> +	if (highlander_i2c_wait_for_bbsy(dev))
> +		return -EAGAIN;
> +
> +	highlander_i2c_start(dev);
> +
> +	if (highlander_i2c_wait_xfer_done(dev)) {
> +		dev_err(dev->dev, "Arbitration loss\n");
> +		return -EAGAIN;
> +	}
> +
> +	/*
> +	 * The R0P7780LC0011RL FPGA needs a significant delay between
> +	 * data read cycles, otherwise the transciever gets confused and
> +	 * garbage is returned when the read is subsequently aborted.
> +	 *
> +	 * It is not sufficient to wait for BBSY.
> +	 *
> +	 * While this generally only applies to the older SH7780-based
> +	 * Highlanders, the same issue can be observed on SH7785 ones,
> +	 * albeit less frequently. SH7780-based Highlanders may need
> +	 * this to be as high as 1000 ms.
> +	 */
> +	if (iic_read_delay && time_before(jiffies, dev->last_read_time +
> +				 msecs_to_jiffies(iic_read_delay)))
> +		msleep_interruptible(jiffies_to_msecs((dev->last_read_time +
> +				msecs_to_jiffies(iic_read_delay)) - jiffies));
> +
> +	cnt = (dev->buf_len + 1) >> 1;
> +	for (i = 0; i < cnt; i++) {
> +		data[i] = ioread16(dev->base + SMTRDR + (i * sizeof(u16)));
> +		dev_dbg(dev->dev, "read data[%x] 0x%04x\n", i, data[i]);
> +	}
> +
> +	smbus_read_data(data, dev->buf, dev->buf_len);
> +
> +	dev->last_read_time = jiffies;
> +
> +	return 0;
> +}
> +
> +static int highlander_i2c_write(struct highlander_i2c_dev *dev)
> +{
> +	int i, cnt;
> +	u16 data[16];
> +
> +	smbus_write_data(dev->buf, data, dev->buf_len);
> +
> +	cnt = (dev->buf_len + 1) >> 1;
> +	for (i = 0; i < cnt; i++) {
> +		iowrite16(data[i], dev->base + SMTRDR + (i * sizeof(u16)));
> +		dev_dbg(dev->dev, "write data[%x] 0x%04x\n", i, data[i]);
> +	}
> +
> +	if (highlander_i2c_wait_for_bbsy(dev))
> +		return -EAGAIN;
> +
> +	highlander_i2c_start(dev);
> +
> +	return highlander_i2c_wait_xfer_done(dev);
> +}
> +
> +static int highlander_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr,
> +				  unsigned short flags, char read_write,
> +				  u8 command, int size,
> +				  union i2c_smbus_data *data)
> +{
> +	struct highlander_i2c_dev *dev = i2c_get_adapdata(adap);
> +	int read = read_write & I2C_SMBUS_READ;
> +	u16 tmp;
> +
> +	init_completion(&dev->cmd_complete);
> +
> +	dev_dbg(dev->dev, "addr %04x, command %02x, read_write %d, size %d\n",
> +		addr, command, read_write, size);
> +
> +	/*
> +	 * Set up the buffer and transfer size
> +	 */
> +	switch (size) {
> +	case I2C_SMBUS_BYTE_DATA:
> +		dev->buf = &data->byte;
> +		dev->buf_len = 1;
> +		break;
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		dev->buf = &data->block[1];
> +		dev->buf_len = data->block[0];
> +		break;
> +	default:
> +		dev_err(dev->dev, "unsupported command %d\n", size);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Encode the mode setting
> +	 */
> +	tmp = ioread16(dev->base + SMMR);
> +	tmp &= ~(SMMR_MODE0 | SMMR_MODE1);
> +
> +	switch (dev->buf_len) {
> +	case 1:
> +		/* default */
> +		break;
> +	case 8:
> +		tmp |= SMMR_MODE0;
> +		break;
> +	case 16:
> +		tmp |= SMMR_MODE1;
> +		break;
> +	case 32:
> +		tmp |= (SMMR_MODE0 | SMMR_MODE1);
> +		break;
> +	default:
> +		dev_err(dev->dev, "unsupported xfer size %d\n", dev->buf_len);
> +		return -EINVAL;
> +	}
> +
> +	iowrite16(tmp, dev->base + SMMR);
> +
> +	/* Ensure we're in a sane state */
> +	highlander_i2c_done(dev);
> +
> +	/* Set slave address */
> +	iowrite16((addr << 1) | read, dev->base + SMSMADR);
> +
> +	highlander_i2c_command(dev, command, dev->buf_len);
> +
> +	if (read)
> +		return highlander_i2c_read(dev);
> +	else
> +		return highlander_i2c_write(dev);
> +}
> +
> +static u32 highlander_i2c_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_I2C_BLOCK;
> +}
> +
> +static const struct i2c_algorithm highlander_i2c_algo = {
> +	.smbus_xfer	= highlander_i2c_smbus_xfer,
> +	.functionality	= highlander_i2c_func,
> +};
> +
> +static int __devinit highlander_i2c_probe(struct platform_device *pdev)
> +{
> +	struct highlander_i2c_dev *dev;
> +	struct i2c_adapter *adap;
> +	struct resource *res;
> +	int ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (unlikely(!res)) {
> +		dev_err(&pdev->dev, "no mem resource\n");
> +		return -ENODEV;
> +	}
> +
> +	dev = kzalloc(sizeof(struct highlander_i2c_dev), GFP_KERNEL);
> +	if (unlikely(!dev))
> +		return -ENOMEM;
> +
> +	dev->base = ioremap_nocache(res->start, res->end - res->start + 1);
> +	if (unlikely(!dev->base)) {
> +		ret = -ENXIO;
> +		goto err;
> +	}
> +
> +	dev->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, dev);
> +
> +	dev->irq = platform_get_irq(pdev, 0);
> +	if (iic_force_poll)
> +		dev->irq = 0;
> +
> +	if (dev->irq) {
> +		ret = request_irq(dev->irq, highlander_i2c_irq, IRQF_DISABLED,
> +				  pdev->name, dev);
> +		if (unlikely(ret))
> +			goto err_unmap;
> +
> +		highlander_i2c_irq_enable(dev);
> +	} else {
> +		dev_notice(&pdev->dev, "no IRQ, using polling mode\n");
> +		highlander_i2c_irq_disable(dev);
> +	}
> +
> +	dev->last_read_time = jiffies;	/* initial read jiffies */
> +
> +	highlander_i2c_setup(dev);
> +
> +	adap = &dev->adapter;
> +	i2c_set_adapdata(adap, dev);
> +	adap->owner = THIS_MODULE;
> +	adap->class = I2C_CLASS_HWMON;
> +	strlcpy(adap->name, "HL FPGA I2C adapter", I2C_NAME_SIZE);

I2C_NAME_SIZE isn't the size of i2c_adapter.name. Use
sizeof(adap->name) instead (as your original code was doing.)

> +	adap->algo = &highlander_i2c_algo;
> +	adap->dev.parent = &pdev->dev;
> +	adap->nr = pdev->id;
> +
> +	/*
> +	 * Reset the adapter
> +	 */
> +	ret = highlander_i2c_reset(dev);
> +	if (unlikely(ret)) {
> +		dev_err(&pdev->dev, "controller didn't come up\n");
> +		goto err_free_irq;
> +	}
> +
> +	ret = i2c_add_numbered_adapter(adap);
> +	if (unlikely(ret)) {
> +		dev_err(&pdev->dev, "failure adding adapter\n");
> +		goto err_free_irq;
> +	}
> +
> +	return 0;
> +
> +err_free_irq:
> +	if (dev->irq)
> +		free_irq(dev->irq, dev);
> +err_unmap:
> +	iounmap(dev->base);
> +err:
> +	kfree(dev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return ret;
> +}
> +
> +static int __devexit highlander_i2c_remove(struct platform_device *pdev)
> +{
> +	struct highlander_i2c_dev *dev = platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(&dev->adapter);
> +
> +	if (dev->irq)
> +		free_irq(dev->irq, dev);
> +
> +	iounmap(dev->base);
> +	kfree(dev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver highlander_i2c_driver = {
> +	.driver		= {
> +		.name	= "i2c-highlander",
> +		.owner	= THIS_MODULE,
> +	},
> +
> +	.probe		= highlander_i2c_probe,
> +	.remove		= __devexit_p(highlander_i2c_remove),
> +};
> +
> +static int __init highlander_i2c_init(void)
> +{
> +	return platform_driver_register(&highlander_i2c_driver);
> +}
> +
> +static void __exit highlander_i2c_exit(void)
> +{
> +	platform_driver_unregister(&highlander_i2c_driver);
> +}
> +
> +module_init(highlander_i2c_init);
> +module_exit(highlander_i2c_exit);
> +
> +MODULE_AUTHOR("Paul Mundt");
> +MODULE_DESCRIPTION("Renesas Highlander FPGA I2C/SMBus adapter");
> +MODULE_LICENSE("GPL v2");
> +
> +module_param(iic_force_poll, bool, 0);
> +module_param(iic_force_normal, bool, 0);
> +module_param(iic_timeout, int, 0);
> +module_param(iic_read_delay, int, 0);
> +
> +MODULE_PARM_DESC(iic_force_poll, "Force polling mode");
> +MODULE_PARM_DESC(iic_force_normal, "Force normal mode (100 kHz), default is fast mode (400 kHz)");
> +MODULE_PARM_DESC(iic_timeout, "Set timeout value in msecs (default 1000 ms)");
> +MODULE_PARM_DESC(iic_read_delay, "Delay between data read cycles (default 0 ms)");

In general I am curious why all these are module parameters instead of
platform device attributes. Shouldn't the platform code know the
correct values? If so, that would be less error prone than leaving it
on the user to pass the right parameters to the module.

-- 
Jean Delvare
