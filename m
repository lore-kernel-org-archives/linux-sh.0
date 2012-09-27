From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 27 Sep 2012 15:05:49 +0000
Subject: Re: [PATCH v2 1/2] mtd: sh_flctl: Setup and release DMA channels
Message-Id: <Pine.LNX.4.64.1209271656020.7862@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1348478315-10789-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1348478315-10789-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Hi Bastian

On Mon, 24 Sep 2012, Bastian Hecht wrote:

> The code probes if DMA channels can get allocated and tears them down at
> removal/failure if needed.

I'm not sure it makes sense to break this code into two patches - the 
first one makes no sense without the second one.

> 
> Based on Guennadi Liakhovetski's code from the sh_mmcif driver.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
> ---
> v2: incorporated Vikram Narayanan's thoughts
> 	- added a missing "static".
> 	- reordered things to get rid of a forward declaration
> 
> Based on l2-mtd with reverted commit e26c113b4130aefa1d8446602bb5b05cfd646bfe.
> 
>  drivers/mtd/nand/sh_flctl.c  |   74 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/sh_flctl.h |   10 ++++++
>  2 files changed, 84 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
> index 4fbfe96..9659483 100644
> --- a/drivers/mtd/nand/sh_flctl.c
> +++ b/drivers/mtd/nand/sh_flctl.c
> @@ -106,6 +106,76 @@ static void wait_completion(struct sh_flctl *flctl)
>  	writeb(0x0, FLTRCR(flctl));
>  }
>  
> +static void flctl_release_dma(struct sh_flctl *flctl)
> +{
> +	if (flctl->chan_fifo0_rx) {
> +		dma_release_channel(flctl->chan_fifo0_rx);

You add dmaengine API calls to the file, so, you have to include 
header(s). dma_release_channel() requires dmaengine.h.

> +		flctl->chan_fifo0_rx = NULL;
> +	}
> +	if (flctl->chan_fifo0_tx) {
> +		dma_release_channel(flctl->chan_fifo0_tx);
> +		flctl->chan_fifo0_tx = NULL;
> +	}
> +}
> +
> +static void flctl_setup_dma(struct sh_flctl *flctl)
> +{
> +	dma_cap_mask_t mask;
> +	struct dma_slave_config cfg;
> +	struct platform_device *pdev = flctl->pdev;
> +	struct sh_flctl_platform_data *pdata = pdev->dev.platform_data;
> +	int ret;
> +
> +	if (!pdata)
> +		return;
> +
> +	if (pdata->slave_id_fifo0_tx <= 0 || pdata->slave_id_fifo0_rx <= 0)
> +		return;
> +
> +	/* We can only either use DMA for both Tx and Rx or not use it at all */
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	flctl->chan_fifo0_tx = dma_request_channel(mask, shdma_chan_filter,

shdma_chan_filter() requires sh_dma.h. And no, including these headers in 
your header is not quite correct.

> +					    (void *)pdata->slave_id_fifo0_tx);
> +	dev_dbg(&pdev->dev, "%s: TX: got channel %p\n", __func__,
> +		flctl->chan_fifo0_tx);
> +
> +	if (!flctl->chan_fifo0_tx)
> +		return;
> +
> +	cfg.slave_id = pdata->slave_id_fifo0_tx;
> +	cfg.direction = DMA_MEM_TO_DEV;
> +	cfg.dst_addr = (dma_addr_t)FLDTFIFO(flctl);
> +	cfg.src_addr = 0;
> +	ret = dmaengine_slave_config(flctl->chan_fifo0_tx, &cfg);

Ok, you copied my mistake here:-) "cfg" is allocated on stack and never 
initialised. You set those its members, that are needed by the sh-dma 
driver, but it can change at any time to begin using further fields from 
struct dma_slave_config, so, it has to be zeroed first. E.g., you could do

+	struct dma_slave_config cfg = {.device_fc = false,};

> +	if (ret < 0)
> +		goto err;
> +
> +	flctl->chan_fifo0_rx = dma_request_channel(mask, shdma_chan_filter,
> +					    (void *)pdata->slave_id_fifo0_rx);
> +	dev_dbg(&pdev->dev, "%s: RX: got channel %p\n", __func__,
> +		flctl->chan_fifo0_rx);
> +
> +	if (!flctl->chan_fifo0_rx)
> +		goto err;
> +
> +	cfg.slave_id = pdata->slave_id_fifo0_rx;
> +	cfg.direction = DMA_DEV_TO_MEM;
> +	cfg.dst_addr = 0;
> +	cfg.src_addr = (dma_addr_t)FLDTFIFO(flctl);
> +	ret = dmaengine_slave_config(flctl->chan_fifo0_rx, &cfg);
> +	if (ret < 0)
> +		goto err;
> +
> +	init_completion(&flctl->dma_complete);
> +
> +	return;
> +
> +err:
> +	flctl_release_dma(flctl);
> +}
> +
>  static void set_addr(struct mtd_info *mtd, int column, int page_addr)
>  {
>  	struct sh_flctl *flctl = mtd_to_flctl(mtd);
> @@ -930,6 +1000,8 @@ static int __devinit flctl_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>  	pm_runtime_resume(&pdev->dev);
>  
> +	flctl_setup_dma(flctl);
> +
>  	ret = nand_scan_ident(flctl_mtd, 1, NULL);
>  	if (ret)
>  		goto err_chip;
> @@ -947,6 +1019,7 @@ static int __devinit flctl_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_chip:
> +	flctl_release_dma(flctl);
>  	pm_runtime_disable(&pdev->dev);
>  	free_irq(irq, flctl);
>  err_flste:
> @@ -960,6 +1033,7 @@ static int __devexit flctl_remove(struct platform_device *pdev)
>  {
>  	struct sh_flctl *flctl = platform_get_drvdata(pdev);
>  
> +	flctl_release_dma(flctl);
>  	nand_release(&flctl->mtd);
>  	pm_runtime_disable(&pdev->dev);
>  	free_irq(platform_get_irq(pdev, 0), flctl);
> diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
> index 01e4b15..20d3f48 100644
> --- a/include/linux/mtd/sh_flctl.h
> +++ b/include/linux/mtd/sh_flctl.h
> @@ -20,10 +20,12 @@
>  #ifndef __SH_FLCTL_H__
>  #define __SH_FLCTL_H__
>  
> +#include <linux/dmaengine.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/nand.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/pm_qos.h>
> +#include <linux/sh_dma.h>

Here headers aren't actually needed - you can just forward-declare "struct 
dma_chan." OTOH, what _is_ indeed needed is <linux/completion.h>.

>  
>  /* FLCTL registers */
>  #define FLCMNCR(f)		(f->reg + 0x0)
> @@ -161,6 +163,11 @@ struct sh_flctl {
>  	unsigned hwecc:1;	/* Hardware ECC (0 = disabled, 1 = enabled) */
>  	unsigned holden:1;	/* Hardware has FLHOLDCR and HOLDEN is set */
>  	unsigned qos_request:1;	/* QoS request to prevent deep power shutdown */
> +
> +	/* DMA related objects */
> +	struct dma_chan		*chan_fifo0_rx;
> +	struct dma_chan		*chan_fifo0_tx;
> +	struct completion	dma_complete;
>  };
>  
>  struct sh_flctl_platform_data {
> @@ -170,6 +177,9 @@ struct sh_flctl_platform_data {
>  
>  	unsigned has_hwecc:1;
>  	unsigned use_holden:1;
> +
> +	unsigned int            slave_id_fifo0_tx;
> +	unsigned int            slave_id_fifo0_rx;
>  };
>  
>  static inline struct sh_flctl *mtd_to_flctl(struct mtd_info *mtdinfo)
> -- 
> 1.7.5.4
> 

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
