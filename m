From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 28 Feb 2008 20:43:08 +0000
Subject: Re: [i2c] [PATCH] I2C bus driver for SH7760 SoC, #3
Message-Id: <20080228214308.56123f61@hyperion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <20080228133330.GA3288@roarinelk.homelinux.net>
In-Reply-To: <20080228133330.GA3288-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Manuel,

On Thu, 28 Feb 2008 14:33:30 +0100, Manuel Lauss wrote:
> Good Day,
> 
> Version 3 of the SH7760 I2C master driver.
> 
> Changes V2->V3:
> 	- removed the SMBUS quick emulation hack.
> 	- implemented Jean Delvare's suggestions.
> 
> Changes V1->V2:
> 	- implement Paul Mundt'S suggestions.
> 
> Comments, flames, welcome!
> 
> Thanks,
> 	Manuel Lauss
> 
> --- 
> 
> >From c7cf5ec922e59e54275fe9977c14399a8ff79114 Mon Sep 17 00:00:00 2001
> From: Manuel Lauss <mlau@msc-ge.com>
> Date: Thu, 28 Feb 2008 14:24:29 +0100
> Subject: [PATCH] Renesas SH7760 I2C master driver
> 
> Driver for I2C interfaces in master mode on SH7760.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  drivers/i2c/busses/Kconfig      |    9 +
>  drivers/i2c/busses/Makefile     |    1 +
>  drivers/i2c/busses/i2c-sh7760.c |  578 +++++++++++++++++++++++++++++++++++++++
>  include/asm-sh/i2c-sh7760.h     |   22 ++
>  4 files changed, 610 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-sh7760.c
>  create mode 100644 include/asm-sh/i2c-sh7760.h

Thanks for the quick update. I've added your patch to my i2c tree. I've
only changed one thing:

> +static int __devinit sh7760_i2c_probe(struct platform_device *pdev)
> +{
> +	struct sh7760_i2c_platdata *pd;
> +	struct resource *res;
> +	struct cami2c *id;
> +	int ret;
> +
> +	pd = pdev->dev.platform_data;
> +	if (!pd) {
> +		dev_err(&pdev->dev, "no platform_data!\n");
> +		ret = -ENODEV;
> +		goto out0;
> +	}
> +
> +	id = kzalloc(sizeof(struct cami2c), GFP_KERNEL);
> +	if (!id) {
> +		dev_err(&pdev->dev, "no mem for private data\n");
> +		ret = -ENOMEM;
> +		goto out0;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no mmio resources\n");
> +		ret = -ENODEV;
> +		goto out1;
> +	}
> +
> +	id->ioarea = request_mem_region(res->start, REGSIZE, pdev->name);
> +	if (!id->ioarea) {
> +		dev_err(&pdev->dev, "mmio already reserved\n");
> +		ret = -EBUSY;
> +		goto out1;
> +	}
> +
> +	id->iobase = ioremap(res->start, REGSIZE);
> +	if (!id->iobase) {
> +		dev_err(&pdev->dev, "cannot ioremap\n");
> +		ret = -ENODEV;
> +		goto out2;
> +	}
> +
> +	id->irq = platform_get_irq(pdev, 0);
> +
> +	id->adap.nr = pdev->id;
> +	id->adap.algo = &sh7760_i2c_algo;
> +	id->adap.class = I2C_CLASS_ALL;
> +	id->adap.retries = 3;
> +	id->adap.algo_data = id;
> +	id->adap.dev.parent = &pdev->dev;
> +	strcpy(id->adap.name, SH7760_I2C_DEVNAME);
> +	snprintf(id->adap.name, sizeof(id->adap.name),
> +		"SH7760 I2C at %08lx", (unsigned long)res->start);

Obviously the strcpy is superfluous.

> +
> +	OUT32(id, I2CMCR, 0);
> +	OUT32(id, I2CMSR, 0);
> +	OUT32(id, I2CMIER, 0);
> +	OUT32(id, I2CMAR, 0);
> +	OUT32(id, I2CSIER, 0);
> +	OUT32(id, I2CSAR, 0);
> +	OUT32(id, I2CSCR, 0);
> +	OUT32(id, I2CSSR, 0);
> +	OUT32(id, I2CFIER, 0);
> +	OUT32(id, I2CFCR, FCR_RFRST | FCR_TFRST);
> +	OUT32(id, I2CFSR, 0);
> +
> +	ret = calc_CCR(pd->speed_khz * 1000);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "invalid SCL clock: %dkHz\n",
> +			pd->speed_khz);
> +		goto out3;
> +	}
> +	OUT32(id, I2CCCR, ret);
> +
> +	if (request_irq(id->irq, sh7760_i2c_irq, IRQF_DISABLED,
> +			SH7760_I2C_DEVNAME, id)) {
> +		dev_err(&pdev->dev, "cannot get irq %d\n", id->irq);
> +		ret = -EBUSY;
> +		goto out3;
> +	}
> +
> +	ret = i2c_add_numbered_adapter(&id->adap);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "reg adap failed: %d\n", ret);
> +		goto out4;
> +	}
> +
> +	platform_set_drvdata(pdev, id);
> +
> +	dev_info(&pdev->dev, "%d kHz mmio %08x irq %d\n",
> +		 pd->speed_khz, res->start, id->irq);
> +
> +	return 0;
> +
> +out4:
> +	free_irq(id->irq, id);
> +out3:
> +	iounmap(id->iobase);
> +out2:
> +	release_resource(id->ioarea);
> +	kfree(id->ioarea);
> +out1:
> +	kfree(id);
> +out0:
> +	return ret;
> +}

The rest looks alright now. No need to resend, I've fixed the above
myself.

-- 
Jean Delvare
