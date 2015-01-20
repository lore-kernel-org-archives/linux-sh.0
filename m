From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Jan 2015 01:18:48 +0000
Subject: Re: [PATCH] dmaengine: shdma: use normal interface for passing slave id
Message-Id: <871tmqckpf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oapzxxzw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oapzxxzw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> > > Morimoto-san, do you think we need to care about out-of-tree drivers here,
> > > or could we merge slave_id and real_slave_id already ?
> > 
> > Sorry, what does your "out-of-tree" mean ?
> 
> That's the drivers that are not part of the kernel that Arnd mentioned in this 
> commit message.

This patches have out-of-tree code compatibility.
Please check this patch with "shdma_config"

> > > >  drivers/dma/sh/shdma-base.c       |   72 +++++++++++++++++++++---------
> > > >  drivers/mmc/host/sh_mmcif.c       |   12 +++----
> > > >  drivers/mmc/host/sh_mobile_sdhi.c |    2 --
> > > >  drivers/mmc/host/tmio_mmc.h       |    2 --
> > > >  drivers/mmc/host/tmio_mmc_dma.c   |    4 ---
> > > >  drivers/mtd/nand/sh_flctl.c       |    2 --
> > > >  drivers/spi/spi-rspi.c            |    1 -
> > > >  drivers/spi/spi-sh-msiof.c        |    1 -
> > > >  include/linux/shdma-base.h        |    1 +
> > > 
> > > This might need to be split into different patches to avoid conflicts when
> > > merging.
> > 
> > OK, will try in v2
> 
> If you can get the various maintainers involved in this to agree on a single 
> tree through which to merge the patch there will be no need to split it, but 
> as 3 subsystems are involved it might be difficult to avoid merge conflicts.

Thank you for your comment.
I have concerned about conflict issue for LTSI backporting too.
So, split into different patches is good idea :)

Best regards
---
Kuninori Morimoto
