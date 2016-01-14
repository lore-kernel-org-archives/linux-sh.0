From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Jan 2016 23:27:50 +0000
Subject: Re: [PATCH 1/2] dmaengine: rcar-dmac: add iommu support for slave transfers
Message-Id: <5633580.zmkmTa5lyY@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Niklas,

On Thursday 14 January 2016 22:37:18 Niklas S=F6derlund wrote:
> * Laurent Pinchart [2016-01-14 01:37:37 +0200]:
> > Hi Niklas,
> >=20
> > Thank you for the patch, and welcome to the hairy details of the DMA
> > mapping API :-)
>=20
> Thanks and thank you for your feedback.
>=20
> > On Monday 11 January 2016 03:17:46 Niklas S=F6derlund wrote:
> > > Enable slave transfers to devices behind IPMMU:s by mapping the slave
> > > addresses using the dma-mapping API.
> > >=20
> > > Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech=
.se>
> > > ---
> > >=20
> > >  drivers/dma/sh/rcar-dmac.c | 64 ++++++++++++++++++++++++++++++++++++=
---
> > >  1 file changed, 60 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> > > index 7820d07..da94809 100644
> > > --- a/drivers/dma/sh/rcar-dmac.c
> > > +++ b/drivers/dma/sh/rcar-dmac.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/dma-mapping.h>
> > >  #include <linux/dmaengine.h>
> > >  #include <linux/interrupt.h>
> > > +#include <linux/iommu.h>
> > >  #include <linux/list.h>
> > >  #include <linux/module.h>
> > >  #include <linux/mutex.h>
> > > @@ -1101,6 +1102,24 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *cha=
n,
> > > dma_addr_t buf_addr,
> > >  	return desc;
> > >  }
> > >=20
> > > +static dma_addr_t __rcar_dmac_dma_map(struct dma_chan *chan,
> > > phys_addr_t addr,
> > > +		size_t size, enum dma_data_direction dir)
> > > +{
> > > +	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
> > > +	struct page *page =3D phys_to_page(addr);
> >=20
> > I wonder if that's really safe given that the physical address, not bei=
ng
> > part of RAM, is (unless I'm mistaken) not backed by a struct page.
>=20
> I agree it's not how I wanted to do it but I could not figure out a way
> that do not end up calling ops->map_page in dma-mapping-common.h. I did
> also get a note from 'kbuild test robot' that phys_to_page is not
> available on all platforms. So in my v2 of this series I currently use:
>=20
>     page =3D pfn_to_page(addr >> PAGE_SHIFT);
>=20
> But I guess it's just as safe as phys_to_page.

At least the kmemcheck_mark_initialized(page_address(page) + offset, size);=
=20
and debug_dma_map_page() calls in dma_map_page() look dangerous to me, as=20
page_address() can dereference the struct page pointer depending on the=20
platform.

Even the page_to_pfn() and page_to_phys() calls in the ARM map_page=20
implementation would need to be checked for correctness as they depend on t=
he=20
memory model used by the platform. The cache sync code paths also worry me,=
=20
but we should skip them anyway.

I wonder if we should have a dma_map_pfn or dma_map_phys...

> > > +	size_t offset =3D addr - page_to_phys(page);
> > > +	dma_addr_t map =3D dma_map_page(chan->device->dev, page, offset, si=
ze,
> > > +			dir);
> >=20
> > You might want to use an _attrs() version of the call to pass the
> > DMA_ATTR_NO_KERNEL_MAPPING and DMA_ATTR_SKIP_CPU_SYNC flags. Unfortunat=
ely
> > there's no dma_map_page_attrs(), maybe it should be added.
>=20
> I have implemented and are using such a construct for my v2. I also
> found the following patch but I could not determine if the idea of of a
> dma_map_pag_attrs was accepted or rejected.
>=20
> PATCH v1 1/2] dma-mapping-common: add dma_map_page_attrs API
> https://www.spinics.net/lists/linux-arch/msg32334.html

The approach looks fine to me (and the second patch could be interesting to=
o,=20
but might not be the best way to do that), the series should probably be=20
resurrected.

> > > +
> > > +	if (dma_mapping_error(chan->device->dev, map)) {
> > > +		dev_err(chan->device->dev, "chan%u: failed to map %zx@%pap",
> > > +				rchan->index, size, &addr);
> > > +		return 0;
> > > +	}
> > > +
> > > +	return map;
> > > +}
> > > +
> > >=20
> > >  static int rcar_dmac_device_config(struct dma_chan *chan,
> > > =20
> > >  				   struct dma_slave_config *cfg)
> > > =20
> > >  {
> > >=20
> > > @@ -1110,10 +1129,47 @@ static int rcar_dmac_device_config(struct
> > > dma_chan
> > > *chan, * We could lock this, but you shouldn't be configuring the
> > >=20
> > >  	 * channel, while using it...
> > >  	 */
> > >=20
> > > -	rchan->src_slave_addr =3D cfg->src_addr;
> > > -	rchan->dst_slave_addr =3D cfg->dst_addr;
> > > -	rchan->src_xfer_size =3D cfg->src_addr_width;
> > > -	rchan->dst_xfer_size =3D cfg->dst_addr_width;
> > > +
> > > +	/* If we don't have a iommu domain no idea to trying to use it */
> > > +	if (!iommu_get_domain_for_dev(chan->device->dev)) {
> > > +		rchan->src_slave_addr =3D cfg->src_addr;
> > > +		rchan->dst_slave_addr =3D cfg->dst_addr;
> > > +		rchan->src_xfer_size =3D cfg->src_addr_width;
> > > +		rchan->dst_xfer_size =3D cfg->dst_addr_width;
> > > +		return 0;
> > > +	}
> >=20
> > Driver are not supposed to deal with the IOMMU API directly. Would it be
> > an issue dropping this check ? The dma_map_page() call should work fine
> > without an IOMMU and return a DMA address identical to the physical
> > address. Unless the memory is not DMA-ble, in which case bounce buffers
> > would be used, and possible a few other corner cases. I'm not sure if we
> > need to care about them.
>
> You are correct, this check can be removed. It was needed in a earlier
> version. I will wait a few days and see if it becomes clearer if the
> mapping should happen in the dmaengine or in the client. And depending
> on that outcome I will send out an updated version.
>=20
> > > +	/* unmap old */
> > > +	if (rchan->src_slave_addr) {
> > > +		dma_unmap_page(chan->device->dev, rchan->src_slave_addr,
> > > +				rchan->src_xfer_size, DMA_FROM_DEVICE);
> > > +		rchan->src_slave_addr =3D 0;
> > > +		rchan->src_xfer_size =3D 0;
> > > +	}
> > > +
> > > +	if (rchan->dst_slave_addr) {
> > > +		dma_unmap_page(chan->device->dev, rchan->dst_slave_addr,
> > > +				rchan->dst_xfer_size, DMA_TO_DEVICE);
> > > +		rchan->dst_slave_addr =3D 0;
> > > +		rchan->dst_xfer_size =3D 0;
> > > +	}
> > > +
> > > +	/* map new */
> > > +	if (cfg->src_addr) {
> > > +		rchan->src_slave_addr =3D __rcar_dmac_dma_map(chan, cfg->src_addr,
> > > +				cfg->src_addr_width, DMA_FROM_DEVICE);
> > > +		if (!rchan->src_slave_addr)
> > > +			return -EIO;
> > > +		rchan->src_xfer_size =3D cfg->src_addr_width;
> > > +	}
> > > +
> > > +	if (cfg->dst_addr) {
> > > +		rchan->dst_slave_addr =3D __rcar_dmac_dma_map(chan, cfg->dst_addr,
> > > +				cfg->dst_addr_width, DMA_TO_DEVICE);
> > > +		if (!rchan->dst_slave_addr)
> > > +			return -EIO;
> > > +		rchan->dst_xfer_size =3D cfg->dst_addr_width;
> > > +	}
> > >=20
> > >  	return 0;
> > >  }

--=20
Regards,

Laurent Pinchart

