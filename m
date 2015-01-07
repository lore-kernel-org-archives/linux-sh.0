From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 07 Jan 2015 09:23:49 +0000
Subject: Re: [PATCH 2/9] mmc: tmio: tmio_mmc_host has .dma
Message-Id: <2017134.He5GnynN45@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <87zj9xogln.wl%kuninori.morimoto.gx@renesas.com> <7306460.62PqiTEhxi@wuerfel> <87fvbnpblr.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvbnpblr.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Wednesday 07 January 2015 02:28:43 Kuninori Morimoto wrote:
> 
> Hi Arnd
> 
> Thank you for your DMAEngine fixup patch.
> I tried this patch, and have comment.

Thanks for looking at the changes

> >  
> > -	sdev = to_shdma_dev(schan->dma_chan.device);
> > -	ret = sdev->ops->set_slave(schan, match, 0, true);
> > +	ret = sdev->ops->set_slave(schan, schan->real_slave_id, 0, true);
> > +	schan->real_slave_id = slave_id;
> >  	if (ret < 0)
> >  		return false;
> 
> Here, your patch is
> 
> 	ret = sdev->ops->set_slave(schan, schan->real_slave_id, 0, true);
> 	schan->real_slave_id = slave_id;
> 	if (ret < 0)
> 
> But, it doesn't work. Maybe, you want this
> 
> 	schan->real_slave_id = slave_id;
> 	ret = sdev->ops->set_slave(schan, schan->real_slave_id, 0, true);
> 	if (ret < 0)

Right, I broke it in a last-minute change. Originally I had

 	schan->real_slave_id = slave_id;
 	ret = sdev->ops->set_slave(schan, schan->real_slave_id, 0, true);
 	if (ret < 0) {
		schan->real_slave_id = 0;
		return ret;
	}

and then meant to shorten it to

 	ret = sdev->ops->set_slave(schan, slave_id, 0, true);
 	if (ret < 0)
		return ret;
 	schan->real_slave_id = slave_id;

Either of those should be fine, but what I wrote was instead was
completely wrong.

> > diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> > index 7d9d6a321521..df3a537f5a83 100644
> > --- a/drivers/mmc/host/sh_mmcif.c
> > +++ b/drivers/mmc/host/sh_mmcif.c
> > @@ -388,7 +388,7 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
> >  {
> >  	struct dma_slave_config cfg = { 0, };
> >  	struct dma_chan *chan;
> > -	unsigned int slave_id;
> > +	void *slave_data;
> >  	struct resource *res;
> >  	dma_cap_mask_t mask;
> >  	int ret;
> > @@ -414,8 +414,6 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
> >  
> >  	res = platform_get_resource(host->pd, IORESOURCE_MEM, 0);
> >  
> > -	/* In the OF case the driver will get the slave ID from the DT */
> > -	cfg.slave_id = slave_id;
> >  	cfg.direction = direction;
> >  
> >  	if (direction = DMA_DEV_TO_MEM) {
> 
> I got error here
> 
> 
> /opt/home/morimoto/linux/drivers/mmc/host/sh_mmcif.c: In function ‘sh_mmcif_request_dma_one’:
> /opt/home/morimoto/linux/drivers/mmc/host/sh_mmcif.c:400:3: error: ‘slave_id’ undeclared (first use in this function)
>    slave_id = direction = DMA_MEM_TO_DEV
>    ^
> /opt/home/morimoto/linux/drivers/mmc/host/sh_mmcif.c:400:3: note: each undeclared identifier is reported only once for each function it appears in
> /opt/home/morimoto/linux/drivers/mmc/host/sh_mmcif.c:391:8: warning: unused variable ‘slave_data’ [-Wunused-variable]
>   void *slave_data;
>         ^
> 
> Maybe you are missing this
> 
>         if (pdata)
> -               slave_id = direction = DMA_MEM_TO_DEV
> -                        ? pdata->slave_id_tx : pdata->slave_id_rx;
> +               slave_data = direction = DMA_MEM_TO_DEV
> +                       ? (void *)pdata->slave_id_tx : (void *)pdata->slave_id_rx;
>         else
> -               slave_id = 0;
> +               slave_data = 0;
>  
>         chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
> -                               (void *)(unsigned long)slave_id, &host->pd->dev,
> +                               slave_data, &host->pd->dev,
>                                 direction = DMA_MEM_TO_DEV ? "tx" : "rx");
>  
>         dev_dbg(&host->pd->dev, "%s: %s: got channel %p\n", __func__,
> 
> 
> sh_mobile_sdhi DMA works if I fixuped above

Either that or undo the change to the type. I originally planned to change the
sh_mmcif_plat_data to use a void* type already, but then didn't do that because
it conflicts with your other patch, and I failed to revert my earlier change
correctly.

	Arnd
