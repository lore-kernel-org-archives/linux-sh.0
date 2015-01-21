From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jan 2015 01:27:41 +0000
Subject: Re: [PATCH 2/8 v2] mmc: sh_mmcif: remove slave_id settings for DMAEngine
Message-Id: <87k30goraz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87iog2axxx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87iog2axxx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Ulf

> > @@ -397,13 +397,13 @@ sh_mmcif_request_dma_one(struct sh_mmcif_host *host,
> >         dma_cap_set(DMA_SLAVE, mask);
> >
> >         if (pdata)
> > -               slave_id = direction = DMA_MEM_TO_DEV
> > -                        ? pdata->slave_id_tx : pdata->slave_id_rx;
> > +               slave_data = direction = DMA_MEM_TO_DEV
> > +                       ? (void *)pdata->slave_id_tx : (void *)pdata->slave_id_rx;
> >         else
> 
> You may get rid of this else clause. Just assign slave_data to NULL
> while declaring it above.
> 
> > -               slave_id = 0;
> > +               slave_data = 0;

Thank you
Will fix in v2 patch

Best regards
---
Kuninori Morimoto
