From: Niklas =?iso-8859-1?Q?S=F6derlund?=  <niklas.soderlund+renesas@ragnatech.se>
Date: Wed, 13 Jan 2016 13:55:50 +0000
Subject: Re: [PATCH 1/2] dmaengine: rcar-dmac: add iommu support for slave transfers
Message-Id: <20160113135550.GA25600@bigcity.dyn.berto.se>
List-Id: <linux-sh.vger.kernel.org>
References: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

* Vinod Koul <vinod.koul@intel.com> [2016-01-13 19:06:01 +0530]:

> On Mon, Jan 11, 2016 at 03:17:46AM +0100, Niklas S=F6derlund wrote:
> > Enable slave transfers to devices behind IPMMU:s by mapping the slave
> > addresses using the dma-mapping API.
> >
> > Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.s=
e>
> > ---
> >  drivers/dma/sh/rcar-dmac.c | 64 ++++++++++++++++++++++++++++++++++++++=
+++++---
> >  1 file changed, 60 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> > index 7820d07..da94809 100644
> > --- a/drivers/dma/sh/rcar-dmac.c
> > +++ b/drivers/dma/sh/rcar-dmac.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/dma-mapping.h>
> >  #include <linux/dmaengine.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/iommu.h>
> >  #include <linux/list.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > @@ -1101,6 +1102,24 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan,=
 dma_addr_t buf_addr,
> >  	return desc;
> >  }
> >
> > +static dma_addr_t __rcar_dmac_dma_map(struct dma_chan *chan, phys_addr=
_t addr,
> > +		size_t size, enum dma_data_direction dir)
> > +{
> > +	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
> > +	struct page *page =3D phys_to_page(addr);
> > +	size_t offset =3D addr - page_to_phys(page);
> > +	dma_addr_t map =3D dma_map_page(chan->device->dev, page, offset, size,
> > +			dir);
>
> Hmmmm, dmaengine APIs for slave cases expect that client has already
> ammped and provided an address which the dmaengine understands. So doing
> this in driver here does not sound good to me

It was my understanding that clients do not do this mapping and in fact
are expected not to. Is this not what Linus Walleij is trying to address
in '[PATCH] dmaengine: use phys_addr_t for slave configuration'?

 >> On Fri, Apr 26, 2013 at 11:06 AM, Linus Walleij
 >> <linus.walleij@linaro.org> wrote:
 >> > The documentation already says these are physical addresses, and
 >> > we have concluded that any translation into the DMA address space
 >> > needs to reside in the dmaengine driver, so change the type of
 >> > the passed arguments

--
// Niklas
