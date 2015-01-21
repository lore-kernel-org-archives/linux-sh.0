From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jan 2015 01:33:10 +0000
Subject: Re: [PATCH 7/8 v2] ASoC: fsi: remove slave_id settings for DMAEngine
Message-Id: <87h9vkor1v.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bnluaxtt.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bnluaxtt.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Arnd

> > diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
> > index 8869971..c4eb234 100644
> > --- a/sound/soc/sh/fsi.c
> > +++ b/sound/soc/sh/fsi.c
> > @@ -1374,10 +1374,9 @@ static int fsi_dma_probe(struct fsi_priv *fsi, struct fsi_stream *io, struct dev
> >                                 shdma_chan_filter, (void *)io->dma_id,
> >                                 dev, is_play ? "tx" : "rx");
> >         if (io->chan) {
> > -               struct dma_slave_config cfg;
> > +               struct dma_slave_config cfg = {};
> >                 int ret;
> >  
> > -               cfg.slave_id    = io->dma_id;
> >                 cfg.dst_addr    = 0; /* use default addr */
> >                 cfg.src_addr    = 0; /* use default addr */
> >                 cfg.direction   = is_play ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
> 
> As the dma_slave_config structure is now initialized to all-zeroes, the
> two address assignments are not strictly required any more.
> 
> However, I also suspect that that particular initialization to zero
> is also incorrect: When booting with DT, the dst_addr/src_addr fields
> are no longer passed in the platform data for the DMA engine but
> are expected to be set by the slave driver.
> 
> Also set the correct address width, which has the same problem.

Thank you for pointing it.
But, unfortunately, this FSI driver is not used from DT.
(It is supporting DT probe, but no one use it)
So, it is assuming that dst_addr/src_addr fields are come
from platform data.

Best regards
---
Kuninori Morimoto
