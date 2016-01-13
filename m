From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 13 Jan 2016 23:37:37 +0000
Subject: Re: [PATCH 1/2] dmaengine: rcar-dmac: add iommu support for slave transfers
Message-Id: <1980027.UZjJqBrmjy@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Niklas,

Thank you for the patch, and welcome to the hairy details of the DMA mappin=
g=20
API :-)

On Monday 11 January 2016 03:17:46 Niklas S=F6derlund wrote:
> Enable slave transfers to devices behind IPMMU:s by mapping the slave
> addresses using the dma-mapping API.
>=20
> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  drivers/dma/sh/rcar-dmac.c | 64 ++++++++++++++++++++++++++++++++++++++++=
---
>  1 file changed, 60 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 7820d07..da94809 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -13,6 +13,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/interrupt.h>
> +#include <linux/iommu.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -1101,6 +1102,24 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan,
> dma_addr_t buf_addr, return desc;
>  }
>=20
> +static dma_addr_t __rcar_dmac_dma_map(struct dma_chan *chan, phys_addr_t
> addr,
> +		size_t size, enum dma_data_direction dir)
> +{
> +	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
> +	struct page *page =3D phys_to_page(addr);

I wonder if that's really safe given that the physical address, not being p=
art=20
of RAM, is (unless I'm mistaken) not backed by a struct page.

> +	size_t offset =3D addr - page_to_phys(page);
> +	dma_addr_t map =3D dma_map_page(chan->device->dev, page, offset, size,
> +			dir);

You might want to use an _attrs() version of the call to pass the=20
DMA_ATTR_NO_KERNEL_MAPPING and DMA_ATTR_SKIP_CPU_SYNC flags. Unfortunately =

there's no dma_map_page_attrs(), maybe it should be added.

> +
> +	if (dma_mapping_error(chan->device->dev, map)) {
> +		dev_err(chan->device->dev, "chan%u: failed to map %zx@%pap",
> +				rchan->index, size, &addr);
> +		return 0;
> +	}
> +
> +	return map;
> +}
> +
>  static int rcar_dmac_device_config(struct dma_chan *chan,
>  				   struct dma_slave_config *cfg)
>  {
> @@ -1110,10 +1129,47 @@ static int rcar_dmac_device_config(struct dma_chan
> *chan, * We could lock this, but you shouldn't be configuring the
>  	 * channel, while using it...
>  	 */
> -	rchan->src_slave_addr =3D cfg->src_addr;
> -	rchan->dst_slave_addr =3D cfg->dst_addr;
> -	rchan->src_xfer_size =3D cfg->src_addr_width;
> -	rchan->dst_xfer_size =3D cfg->dst_addr_width;
> +
> +	/* If we don't have a iommu domain no idea to trying to use it */
> +	if (!iommu_get_domain_for_dev(chan->device->dev)) {
> +		rchan->src_slave_addr =3D cfg->src_addr;
> +		rchan->dst_slave_addr =3D cfg->dst_addr;
> +		rchan->src_xfer_size =3D cfg->src_addr_width;
> +		rchan->dst_xfer_size =3D cfg->dst_addr_width;
> +		return 0;
> +	}

Driver are not supposed to deal with the IOMMU API directly. Would it be an=
=20
issue dropping this check ? The dma_map_page() call should work fine withou=
t=20
an IOMMU and return a DMA address identical to the physical address. Unless=
=20
the memory is not DMA-ble, in which case bounce buffers would be used, and =

possible a few other corner cases. I'm not sure if we need to care about th=
em.

> +	/* unmap old */
> +	if (rchan->src_slave_addr) {
> +		dma_unmap_page(chan->device->dev, rchan->src_slave_addr,
> +				rchan->src_xfer_size, DMA_FROM_DEVICE);
> +		rchan->src_slave_addr =3D 0;
> +		rchan->src_xfer_size =3D 0;
> +	}
> +
> +	if (rchan->dst_slave_addr) {
> +		dma_unmap_page(chan->device->dev, rchan->dst_slave_addr,
> +				rchan->dst_xfer_size, DMA_TO_DEVICE);
> +		rchan->dst_slave_addr =3D 0;
> +		rchan->dst_xfer_size =3D 0;
> +	}
> +
> +	/* map new */
> +	if (cfg->src_addr) {
> +		rchan->src_slave_addr =3D __rcar_dmac_dma_map(chan, cfg->src_addr,
> +				cfg->src_addr_width, DMA_FROM_DEVICE);
> +		if (!rchan->src_slave_addr)
> +			return -EIO;
> +		rchan->src_xfer_size =3D cfg->src_addr_width;
> +	}
> +
> +	if (cfg->dst_addr) {
> +		rchan->dst_slave_addr =3D __rcar_dmac_dma_map(chan, cfg->dst_addr,
> +				cfg->dst_addr_width, DMA_TO_DEVICE);
> +		if (!rchan->dst_slave_addr)
> +			return -EIO;
> +		rchan->dst_xfer_size =3D cfg->dst_addr_width;
> +	}
>=20
>  	return 0;
>  }

--=20
Regards,

Laurent Pinchart

