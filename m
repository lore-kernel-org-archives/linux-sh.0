From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 15 Apr 2013 17:21:55 +0000
Subject: Re: [PATCH v6 2/2] sudmac: add support for SUDMAC
Message-Id: <20130415170955.GH12436@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <51664159.7080407@renesas.com>
In-Reply-To: <51664159.7080407@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 11, 2013 at 01:51:37PM +0900, Shimoda, Yoshihiro wrote:
> Some Renesas USB modules have SUDMAC. This patch supports it using
> the shdma-base driver.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  about v6:
>   - remove drivers/dma/sh/sudmac.h
>   - use drivers/dma/sh/kconfig
>   - don't allow using the register definitions in sudmac_channel
> 
>  drivers/dma/Makefile    |    1 +
>  drivers/dma/sh/Kconfig  |    8 +
>  drivers/dma/sh/Makefile |    1 +
>  drivers/dma/sh/sudmac.c |  428 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/sudmac.h  |   55 ++++++
>  5 files changed, 493 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/dma/sh/sudmac.c
>  create mode 100644 include/linux/sudmac.h
> 
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 488e3ff..2f4ef99 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
>  obj-$(CONFIG_MX3_IPU) += ipu/
>  obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
>  obj-$(CONFIG_SH_DMAE) += sh/
> +obj-$(CONFIG_SUDMAC) += sh/
>  obj-$(CONFIG_COH901318) += coh901318.o coh901318_lli.o
>  obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
>  obj-$(CONFIG_IMX_SDMA) += imx-sdma.o
> diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
> index 7e85ad6..9ff3960 100644
> --- a/drivers/dma/sh/Kconfig
> +++ b/drivers/dma/sh/Kconfig
> @@ -9,3 +9,11 @@ config SH_DMAE
>  	select DMA_ENGINE
>  	help
>  	  Enable support for the Renesas SuperH DMA controllers.
> +
> +config SUDMAC
> +	tristate "Renesas SUDMAC support"
> +	depends on (SUPERH && SH_DMA) || (ARM && ARCH_SHMOBILE)
> +	depends on !SH_DMA_API
> +	select DMA_ENGINE
> +	help
> +	  Enable support for the Renesas SUDMAC controllers.
> diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
> index 54ae957..16f9225 100644
> --- a/drivers/dma/sh/Makefile
> +++ b/drivers/dma/sh/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_SH_DMAE) += shdma-base.o
>  obj-$(CONFIG_SH_DMAE) += shdma.o
> +obj-$(CONFIG_SUDMAC) += shdma-base.o sudmac.o
> diff --git a/drivers/dma/sh/sudmac.c b/drivers/dma/sh/sudmac.c
> new file mode 100644
> index 0000000..cd65752
> --- /dev/null
> +++ b/drivers/dma/sh/sudmac.c
> @@ -0,0 +1,428 @@
> +/*
> + * Renesas SUDMAC support
> + *
> + * Copyright (C) 2012 Renesas Solutions Corp.
2013?
> + *
> + * based on drivers/dma/sh/shdma.c:
> + * Copyright (C) 2011-2012 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> + * Copyright (C) 2009 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> + * Copyright (C) 2009 Renesas Solutions, Inc. All rights reserved.
> + * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
> + *
> + * This is free software; you can redistribute it and/or modify
> + * it under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/dmaengine.h>
> +#include <linux/platform_device.h>
> +#include <linux/sudmac.h>
> +
> +struct sudmac_chan {
> +	struct shdma_chan shdma_chan;
> +	void __iomem *base;
> +	char dev_id[16];	/* unique name per DMAC of channel */
> +
> +	u32 offset;		/* for CFG, BA, BBC, CA, CBC, DEN */
> +	u32 cfg;
> +	u32 dint_end_bit;
> +};
> +
> +struct sudmac_device {
> +	struct shdma_dev shdma_dev;
> +	struct sudmac_pdata *pdata;
> +	void __iomem *chan_reg;
> +};
> +
> +struct sudmac_regs {
> +	u32 ba;
> +	u32 bbc;
> +};
> +
> +struct sudmac_desc {
> +	struct sudmac_regs hw;
> +	struct shdma_desc shdma_desc;
> +};
> +
> +#define to_chan(schan) container_of(schan, struct sudmac_chan, shdma_chan)
> +#define to_desc(sdesc) container_of(sdesc, struct sudmac_desc, shdma_desc)
> +#define to_sdev(sc) container_of(sc->shdma_chan.dma_chan.device, \
> +				 struct sudmac_device, shdma_dev.dma_dev)
> +
> +/* SUDMAC register */
> +#define CH0CFG		0x00
> +#define CH0BA		0x10
> +#define CH0BBC		0x18
> +#define CH0CA		0x20
> +#define CH0CBC		0x28
> +#define CH0DEN		0x30
> +#define DSTSCLR		0x38
> +#define DBUFCTRL	0x3C
> +#define DINTCTRL	0x40
> +#define DINTSTS		0x44
> +#define DINTSTSCLR	0x48
> +#define CH0SHCTRL	0x50
Can you pls namespace these aptly

> +
> +/* Definitions for the sudmac_channel.config */
> +#define SUDMAC_SENDBUFM	0x1000 /* b12: Transmit Buffer Mode */
> +#define SUDMAC_RCVENDM	0x0100 /* b8: Receive Data Transfer End Mode */
> +#define SUDMAC_LBA_WAIT	0x0030 /* b5-4: Local Bus Access Wait */
> +
> +/* Definitions for the sudmac_channel.dint_end_bit */
> +#define SUDMAC_CH1ENDE	0x0002 /* b1: Ch1 DMA Transfer End Int Enable */
> +#define SUDMAC_CH0ENDE	0x0001 /* b0: Ch0 DMA Transfer End Int Enable */
> +
> +#define SUDMAC_DRV_NAME "sudmac"
> +
> +static void sudmac_writel(struct sudmac_chan *sc, u32 data, u32 reg)
> +{
> +	iowrite32(data, sc->base + reg);
> +}
> +
> +static u32 sudmac_readl(struct sudmac_chan *sc, u32 reg)
> +{
> +	return ioread32(sc->base + reg);
> +}
> +
> +static bool sudmac_is_busy(struct sudmac_chan *sc)
> +{
> +	u32 den = sudmac_readl(sc, CH0DEN + sc->offset);
> +
> +	if (den)
> +		return true; /* working */
> +
> +	return false; /* waiting */
> +}
> +
> +static void sudmac_set_reg(struct sudmac_chan *sc, struct sudmac_regs *hw,
> +			   struct shdma_desc *sdesc)
> +{
> +	sudmac_writel(sc, sc->cfg, CH0CFG + sc->offset);
> +	sudmac_writel(sc, hw->ba, CH0BA + sc->offset);
> +	sudmac_writel(sc, hw->bbc, CH0BBC + sc->offset);
> +}
> +
> +static void sudmac_start(struct sudmac_chan *sc)
> +{
> +	u32 dintctrl = sudmac_readl(sc, DINTCTRL);
> +
> +	sudmac_writel(sc, dintctrl | sc->dint_end_bit, DINTCTRL);
> +	sudmac_writel(sc, 1, CH0DEN + sc->offset);
> +}
> +
> +static void sudmac_start_xfer(struct shdma_chan *schan,
> +			      struct shdma_desc *sdesc)
> +{
> +	struct sudmac_chan *sc = to_chan(schan);
> +	struct sudmac_desc *sd = to_desc(sdesc);
> +
> +	sudmac_set_reg(sc, &sd->hw, sdesc);
> +	sudmac_start(sc);
> +}
> +
> +static bool sudmac_channel_busy(struct shdma_chan *schan)
> +{
> +	struct sudmac_chan *sc = to_chan(schan);
> +
> +	return sudmac_is_busy(sc);
> +}
> +
> +static void sudmac_setup_xfer(struct shdma_chan *schan, int slave_id)
> +{
> +}
dead code?
> +
> +static const struct sudmac_slave_config *sudmac_find_slave(
> +	struct sudmac_chan *sc, int slave_id)
> +{
> +	struct sudmac_device *sdev = to_sdev(sc);
> +	struct sudmac_pdata *pdata = sdev->pdata;
> +	const struct sudmac_slave_config *cfg;
> +	int i;
> +
> +	for (i = 0, cfg = pdata->slave; i < pdata->slave_num; i++, cfg++)
> +		if (cfg->slave_id = slave_id)
> +			return cfg;
> +
> +	return NULL;
> +}
> +
> +static int sudmac_set_slave(struct shdma_chan *schan, int slave_id, bool try)
> +{
> +	struct sudmac_chan *sc = to_chan(schan);
> +	const struct sudmac_slave_config *cfg = sudmac_find_slave(sc, slave_id);
> +
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	return 0;
> +}
this doesnt seem to set anything...

> +
> +static void sudmac_dma_halt(struct sudmac_chan *sc)
> +{
> +	u32 dintctrl = sudmac_readl(sc, DINTCTRL);
> +
> +	sudmac_writel(sc, 0, CH0DEN + sc->offset);
> +	sudmac_writel(sc, dintctrl & ~sc->dint_end_bit, DINTCTRL);
> +	sudmac_writel(sc, sc->dint_end_bit, DINTSTSCLR);
> +}
how about making this inline

> +
> +static int sudmac_desc_setup(struct shdma_chan *schan,
> +			     struct shdma_desc *sdesc,
> +			     dma_addr_t src, dma_addr_t dst, size_t *len)
> +{
> +	struct sudmac_chan *sc = to_chan(schan);
> +	struct sudmac_desc *sd = to_desc(sdesc);
> +
> +	dev_dbg(sc->shdma_chan.dev, "%s: src=%x, dst=%x, len=%d\n",
> +		__func__, src, dst, *len);
> +
> +	if (*len > schan->max_xfer_len)
> +		*len = schan->max_xfer_len;
> +
> +	if (dst)
> +		sd->hw.ba = dst;
> +	else if (src)
> +		sd->hw.ba = src;
> +	sd->hw.bbc = *len;
> +
> +	return 0;
> +}
> +
> +static void sudmac_halt(struct shdma_chan *schan)
> +{
> +	struct sudmac_chan *sc = to_chan(schan);
> +
> +	sudmac_dma_halt(sc);
> +}
could be inline
> +
> +static bool sudmac_chan_irq(struct shdma_chan *schan, int irq)
> +{
> +	struct sudmac_chan *sc = to_chan(schan);
> +	u32 dintsts = sudmac_readl(sc, DINTSTS);
> +
> +	if (!(dintsts & sc->dint_end_bit))
> +		return false;
> +
> +	/* DMA stop */
> +	sudmac_dma_halt(sc);
> +
> +	return true;
> +}
why should irq stop the channel, sorry not following the logic here.

> +
> +static size_t sudmac_get_partial(struct shdma_chan *schan,
> +				 struct shdma_desc *sdesc)
> +{
> +	struct sudmac_chan *sc = to_chan(schan);
> +	struct sudmac_desc *sd = to_desc(sdesc);
> +	u32 cbc = sudmac_readl(sc, CH0CBC + sc->offset);
user friendly variables pls
> +
> +	return sd->hw.bbc - cbc;
> +}
> +
> +static bool sudmac_desc_completed(struct shdma_chan *schan,
> +				  struct shdma_desc *sdesc)
> +{
> +	struct sudmac_chan *sc = to_chan(schan);
> +	struct sudmac_desc *sd = to_desc(sdesc);
> +	u32 ca = sudmac_readl(sc, CH0CA + sc->offset);
ditto
> +
> +	return sd->hw.ba + sd->hw.bbc = ca;
> +}
> +
> +static int sudmac_chan_probe(struct sudmac_device *su_dev, int id, int irq,
> +			     unsigned long flags)
> +{
> +	struct shdma_dev *sdev = &su_dev->shdma_dev;
> +	struct platform_device *pdev = to_platform_device(sdev->dma_dev.dev);
> +	struct sudmac_chan *sc;
> +	struct shdma_chan *schan;
> +	int err;
> +
> +	sc = devm_kzalloc(&pdev->dev, sizeof(struct sudmac_chan), GFP_KERNEL);
> +	if (!sc) {
> +		dev_err(sdev->dma_dev.dev,
> +			"No free memory for allocating dma channels!\n");
> +		return -ENOMEM;
> +	}
> +
> +	schan = &sc->shdma_chan;
> +	schan->max_xfer_len = 64 * 1024 * 1024 - 1;
> +
> +	shdma_chan_probe(sdev, schan, id);
> +
> +	sc->base = su_dev->chan_reg;
> +
> +	/* get platform_data */
> +	sc->offset = su_dev->pdata->channel->offset;
> +	if (su_dev->pdata->channel->config & SUDMAC_TX_BUFFER_MODE)
> +		sc->cfg |= SUDMAC_SENDBUFM;
> +	if (su_dev->pdata->channel->config & SUDMAC_RX_END_MODE)
> +		sc->cfg |= SUDMAC_RCVENDM;
> +	sc->cfg |= (su_dev->pdata->channel->wait << 4) & SUDMAC_LBA_WAIT;
> +
> +	if (su_dev->pdata->channel->dint_end_bit & SUDMAC_DMA_BIT_CH0)
> +		sc->dint_end_bit |= SUDMAC_CH0ENDE;
> +	if (su_dev->pdata->channel->dint_end_bit & SUDMAC_DMA_BIT_CH1)
> +		sc->dint_end_bit |= SUDMAC_CH1ENDE;
> +
> +	/* set up channel irq */
> +	if (pdev->id >= 0)
> +		snprintf(sc->dev_id, sizeof(sc->dev_id), "sudmac%d.%d",
> +			 pdev->id, id);
> +	else
> +		snprintf(sc->dev_id, sizeof(sc->dev_id), "sudmac%d", id);
> +
> +	err = shdma_request_irq(schan, irq, flags, sc->dev_id);
> +	if (err) {
> +		dev_err(sdev->dma_dev.dev,
> +			"DMA channel %d request_irq failed %d\n", id, err);
> +		goto err_no_irq;
> +	}
> +
> +	return 0;
> +
> +err_no_irq:
> +	/* remove from dmaengine device node */
> +	shdma_chan_remove(schan);
> +	return err;
> +}
> +
> +static void sudmac_chan_remove(struct sudmac_device *su_dev)
> +{
> +	struct dma_device *dma_dev = &su_dev->shdma_dev.dma_dev;
> +	struct shdma_chan *schan;
> +	int i;
> +
> +	shdma_for_each_chan(schan, &su_dev->shdma_dev, i) {
> +		struct sudmac_chan *sc = to_chan(schan);
> +
> +		BUG_ON(!schan);
> +
> +		shdma_free_irq(&sc->shdma_chan);
> +		shdma_chan_remove(schan);
> +	}
> +	dma_dev->chancnt = 0;
> +}
> +
> +static dma_addr_t sudmac_slave_addr(struct shdma_chan *schan)
> +{
> +	/* SUDMAC doesn't need the address */
> +	return 0;
> +}
why is that? This is a slave driver right?
> +
> +static struct shdma_desc *sudmac_embedded_desc(void *buf, int i)
> +{
> +	return &((struct sudmac_desc *)buf)[i].shdma_desc;
> +}
> +
> +static const struct shdma_ops sudmac_shdma_ops = {
> +	.desc_completed = sudmac_desc_completed,
> +	.halt_channel = sudmac_halt,
> +	.channel_busy = sudmac_channel_busy,
> +	.slave_addr = sudmac_slave_addr,
> +	.desc_setup = sudmac_desc_setup,
> +	.set_slave = sudmac_set_slave,
> +	.setup_xfer = sudmac_setup_xfer,
> +	.start_xfer = sudmac_start_xfer,
> +	.embedded_desc = sudmac_embedded_desc,
> +	.chan_irq = sudmac_chan_irq,
> +	.get_partial = sudmac_get_partial,
> +};
> +
> +static int sudmac_probe(struct platform_device *pdev)
> +{
> +	struct sudmac_pdata *pdata = pdev->dev.platform_data;
> +	int err, i;
> +	struct sudmac_device *su_dev;
> +	struct dma_device *dma_dev;
> +	struct resource *chan, *irq_res;
> +
> +	/* get platform data */
> +	if (!pdata)
> +		return -ENODEV;
> +
> +	chan = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!chan || !irq_res)
> +		return -ENODEV;
> +
> +	err = -ENOMEM;
> +	su_dev = devm_kzalloc(&pdev->dev, sizeof(struct sudmac_device),
> +			      GFP_KERNEL);
> +	if (!su_dev) {
> +		dev_err(&pdev->dev, "Not enough memory\n");
> +		return err;
> +	}
> +
> +	dma_dev = &su_dev->shdma_dev.dma_dev;
> +
> +	su_dev->chan_reg = devm_request_and_ioremap(&pdev->dev, chan);
> +	if (!su_dev->chan_reg)
> +		return err;
> +
> +	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> +
> +	su_dev->shdma_dev.ops = &sudmac_shdma_ops;
> +	su_dev->shdma_dev.desc_size = sizeof(struct sudmac_desc);
> +	err = shdma_init(&pdev->dev, &su_dev->shdma_dev, pdata->channel_num);
> +	if (err < 0)
> +		return err;
> +
> +	/* platform data */
> +	su_dev->pdata = pdev->dev.platform_data;
> +
> +	platform_set_drvdata(pdev, su_dev);
> +
> +	/* Create DMA Channel */
> +	for (i = 0; i < pdata->channel_num; i++) {
> +		err = sudmac_chan_probe(su_dev, i, irq_res->start, IRQF_SHARED);
> +		if (err)
> +			goto chan_probe_err;
> +	}
> +
> +	err = dma_async_device_register(&su_dev->shdma_dev.dma_dev);
> +	if (err < 0)
> +		goto chan_probe_err;
> +
> +	return err;
> +
> +chan_probe_err:
> +	sudmac_chan_remove(su_dev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	shdma_cleanup(&su_dev->shdma_dev);
> +
> +	return err;
> +}
> +
> +static int sudmac_remove(struct platform_device *pdev)
> +{
> +	struct sudmac_device *su_dev = platform_get_drvdata(pdev);
> +	struct dma_device *dma_dev = &su_dev->shdma_dev.dma_dev;
> +
> +	dma_async_device_unregister(dma_dev);
> +	sudmac_chan_remove(su_dev);
> +	shdma_cleanup(&su_dev->shdma_dev);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sudmac_driver = {
> +	.driver 	= {
> +		.owner	= THIS_MODULE,
> +		.name	= SUDMAC_DRV_NAME,
> +	},
> +	.probe		= sudmac_probe,
> +	.remove		= sudmac_remove,
> +};
> +module_platform_driver(sudmac_driver);
> +
> +MODULE_AUTHOR("Yoshihiro Shimoda");
> +MODULE_DESCRIPTION("Renesas SUDMAC driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:" SUDMAC_DRV_NAME);
> diff --git a/include/linux/sudmac.h b/include/linux/sudmac.h
> new file mode 100644
> index 0000000..11fe863
> --- /dev/null
> +++ b/include/linux/sudmac.h
> @@ -0,0 +1,55 @@
> +/*
> + * Header for the SUDMAC driver
> + *
> + * Copyright (C) 2012 Renesas Solutions Corp.
13 ?
> + *
> + * based on include/linux/sh_dma.h:
> + * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
No need to mention original copyright, 
> + *
> + * This is free software; you can redistribute it and/or modify

--
~Vinod
