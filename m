From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Jan 2015 00:37:04 +0000
Subject: Re: [PATCH] dmaengine: shdma: use normal interface for passing slave id
Message-Id: <877fwicmmz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oapzxxzw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oapzxxzw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> > The shmobile platform is one of only two users of the slave_id field
> > in dma_slave_config, which is incompatible with the way that the
> > dmaengine API normally works.
> >
> > I've had a closer look at the existing code now and found that all
> > slave drivers that pass a slave_id in dma_slave_config for SH do that
> > right after passing the same ID into shdma_chan_filter, so we can just
> > rely on that. However, the various shdma drivers currently do not
> > remember the slave ID that was passed into the filter function when
> > used in non-DT mode and only check the value to find a matching channel,
> > unlike all other drivers.
> > 
> > There might still be drivers that are not part of the kernel that rely
> > on setting the slave_id to some other value, so to be on the safe side,
> > this adds another 'real_slave_id' field to shdma_chan that remembers
> > the ID and uses it when a driver passes a zero slave_id in dma_slave_config,
> > like most drivers do.
> > 
> > Eventually, the real_slave_id and slave_id fields should just get merged
> > into one field, but that requires other changes.
> 
> Morimoto-san, do you think we need to care about out-of-tree drivers here, or 
> could we merge slave_id and real_slave_id already ?

Sorry, what does your "out-of-tree" mean ?

> >  drivers/dma/sh/shdma-base.c       |   72 ++++++++++++++++++++++++----------
> >  drivers/mmc/host/sh_mmcif.c       |   12 +++----
> >  drivers/mmc/host/sh_mobile_sdhi.c |    2 --
> >  drivers/mmc/host/tmio_mmc.h       |    2 --
> >  drivers/mmc/host/tmio_mmc_dma.c   |    4 ---
> >  drivers/mtd/nand/sh_flctl.c       |    2 --
> >  drivers/spi/spi-rspi.c            |    1 -
> >  drivers/spi/spi-sh-msiof.c        |    1 -
> >  include/linux/shdma-base.h        |    1 +
> 
> This might need to be split into different patches to avoid conflicts when 
> merging.

OK, will try in v2

Best regards
---
Kuninori Morimoto
