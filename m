From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 13 Jan 2016 23:13:20 +0000
Subject: Re: [PATCH 1/2] dmaengine: rcar-dmac: add iommu support for slave transfers
Message-Id: <1480445.VKLr4KL8lS@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Vinod,

(CC'ing Linus as he's mentioned)

On Wednesday 13 January 2016 14:55:50 Niklas S=F6derlund wrote:
> * Vinod Koul <vinod.koul@intel.com> [2016-01-13 19:06:01 +0530]:
> > On Mon, Jan 11, 2016 at 03:17:46AM +0100, Niklas S=F6derlund wrote:
> >> Enable slave transfers to devices behind IPMMU:s by mapping the slave
> >> addresses using the dma-mapping API.
> >>=20
> >> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> >> ---
> >>=20
> >>  drivers/dma/sh/rcar-dmac.c | 64 +++++++++++++++++++++++++++++++++++++=
---
> >>  1 file changed, 60 insertions(+), 4 deletions(-)
> >>=20
> >> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> >> index 7820d07..da94809 100644
> >> --- a/drivers/dma/sh/rcar-dmac.c
> >> +++ b/drivers/dma/sh/rcar-dmac.c
> >> @@ -13,6 +13,7 @@
> >>  #include <linux/dma-mapping.h>
> >>  #include <linux/dmaengine.h>
> >>  #include <linux/interrupt.h>
> >> +#include <linux/iommu.h>
> >>  #include <linux/list.h>
> >>  #include <linux/module.h>
> >>  #include <linux/mutex.h>
> >> @@ -1101,6 +1102,24 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan,
> >> dma_addr_t buf_addr,
> >>  	return desc;
> >>  }
> >>=20
> >> +static dma_addr_t __rcar_dmac_dma_map(struct dma_chan *chan,
> >> phys_addr_t addr,
> >> +		size_t size, enum dma_data_direction dir)
> >> +{
> >> +	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
> >> +	struct page *page =3D phys_to_page(addr);
> >> +	size_t offset =3D addr - page_to_phys(page);
> >> +	dma_addr_t map =3D dma_map_page(chan->device->dev, page, offset, siz=
e,
> >> +			dir);
> >=20
> > Hmmmm, dmaengine APIs for slave cases expect that client has already
> > ammped and provided an address which the dmaengine understands. So doing
> > this in driver here does not sound good to me
>=20
> It was my understanding that clients do not do this mapping and in fact
> are expected not to. Is this not what Linus Walleij is trying to address
> in '[PATCH] dmaengine: use phys_addr_t for slave configuration'?

There's a problem somewhere and we need to fix it. Clients currently pass=20
physical addresses and the DMA engine API expects a DMA address. There's on=
ly=20
two ways to fix that, either modify the API to expect a phys_addr_t, or mod=
ify=20
the clients to provide a dma_addr_t.

The struct device used to map buffer through the DMA mapping API needs to b=
e=20
the DMA engine struct device, not the client struct device. As the client i=
s=20
not expected to have access to the DMA engine device I would argue that DMA=
=20
engines should perform the mapping and the API should take a phys_addr_t.

Vinod, unless you have reasons to do it otherwise, can we get your ack on t=
his=20
approach and start hammering at the code ? The problem has remained known a=
nd=20
unfixed for too long, we need to move on.

> >> On Fri, Apr 26, 2013 at 11:06 AM, Linus Walleij wrote:
> >>> The documentation already says these are physical addresses, and
> >>> we have concluded that any translation into the DMA address space
> >>> needs to reside in the dmaengine driver, so change the type of
> >>> the passed arguments

--=20
Regards,

Laurent Pinchart

