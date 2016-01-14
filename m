From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Jan 2016 13:59:40 +0000
Subject: Re: [PATCH 1/2] dmaengine: rcar-dmac: add iommu support for slave transfers
Message-Id: <1576023.p09580yWMt@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Vinod,

(CC'ing Maxime, I know he misses working on the DMA engine core ;-))

On Thursday 14 January 2016 09:22:25 Vinod Koul wrote:
> On Thu, Jan 14, 2016 at 01:13:20AM +0200, Laurent Pinchart wrote:
> > On Wednesday 13 January 2016 14:55:50 Niklas S=F6derlund wrote:
> >> * Vinod Koul <vinod.koul@intel.com> [2016-01-13 19:06:01 +0530]:
> >>> On Mon, Jan 11, 2016 at 03:17:46AM +0100, Niklas S=F6derlund wrote:
> >>>> Enable slave transfers to devices behind IPMMU:s by mapping the slave
> >>>> addresses using the dma-mapping API.
> >>>>=20
> >>>> Signed-off-by: Niklas S=F6derlund
> >>>> <niklas.soderlund+renesas@ragnatech.se>
> >>>> ---
> >>>>=20
> >>>>  drivers/dma/sh/rcar-dmac.c | 64 ++++++++++++++++++++++++++++++++++-=
--
> >>>>  1 file changed, 60 insertions(+), 4 deletions(-)
> >>>>=20
> >>>> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> >>>> index 7820d07..da94809 100644
> >>>> --- a/drivers/dma/sh/rcar-dmac.c
> >>>> +++ b/drivers/dma/sh/rcar-dmac.c
> >>>> @@ -13,6 +13,7 @@
> >>>>  #include <linux/dma-mapping.h>
> >>>>  #include <linux/dmaengine.h>
> >>>>  #include <linux/interrupt.h>
> >>>> +#include <linux/iommu.h>
> >>>>  #include <linux/list.h>
> >>>>  #include <linux/module.h>
> >>>>  #include <linux/mutex.h>
> >>>> @@ -1101,6 +1102,24 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan
> >>>> *chan, dma_addr_t buf_addr,
> >>>>  	return desc;
> >>>>  }
> >>>>=20
> >>>> +static dma_addr_t __rcar_dmac_dma_map(struct dma_chan *chan,
> >>>> phys_addr_t addr,
> >>>> +		size_t size, enum dma_data_direction dir)
> >>>> +{
> >>>> +	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
> >>>> +	struct page *page =3D phys_to_page(addr);
> >>>> +	size_t offset =3D addr - page_to_phys(page);
> >>>> +	dma_addr_t map =3D dma_map_page(chan->device->dev, page, offset,
> >>>> size,
> >>>> +			dir);
> >>>=20
> >>> Hmmmm, dmaengine APIs for slave cases expect that client has already
> >>> ammped and provided an address which the dmaengine understands. So
> >>> doing this in driver here does not sound good to me
> >>=20
> >> It was my understanding that clients do not do this mapping and in fact
> >> are expected not to. Is this not what Linus Walleij is trying to addre=
ss
> >> in '[PATCH] dmaengine: use phys_addr_t for slave configuration'?
> >=20
> > There's a problem somewhere and we need to fix it. Clients currently pa=
ss
> > physical addresses and the DMA engine API expects a DMA address. There's
> > only two ways to fix that, either modify the API to expect a phys_addr_=
t,
> > or modify the clients to provide a dma_addr_t.
>=20
> Okay I am in two minds for this, doing phys_addr_t seems okay but somehow=
 I
> feel we should rather pass dma_addr_t and dmaengien driver get a right dma
> address to use and thus fix the clients, that maybe the right thing to do
> here, thoughts...?

Given that there should be more clients than DMA engine drivers, and given =

that knowledge of what has to be done to map a physical address to a DMA=20
address accessible by the DMA engine should not be included in client drive=
rs=20
(in most case I assume using the DMA mapping API will be enough, but detail=
s=20
may vary), I believe it makes more sense to pass a phys_addr_t and let the =
DMA=20
engine drivers handle it.

There's another issue I just remembered. Consider the following cases.

1. DMA engine channel that has an optional IOMMU covering both the src and =
dst=20
side. In that case mapping can be performed by the client or DMA engine=20
driver, the DMA mapping API will handle the IOMMU behind the scene.

2. DMA engine channel that has an optional IOMMU on the memory side and no =

support for IOMMU on the slave (in the sense of the register in front of th=
e=20
client's FIFO) side. In that case a client mapping buffers on both the src =
and=20
dst side would set an IOMMU mapped address for the slave side, which wouldn=
't=20
work. If the DMA engine driver were to perform the mapping then it could sk=
ip=20
it on the slave side, knowing that the slave side has no IOMMU.

3. DMA engine channel that has independently optional IOMMUs on both sides.=
=20
This can't be supported today as we have a single struct device per channel=
=20
and thus can't configure the IOMMU independently on the two sides.

It's getting messy :-)

> The assumption from API was always that the client should perform the
> mapping...
>=20
> > The struct device used to map buffer through the DMA mapping API needs =
to
> > be the DMA engine struct device, not the client struct device. As the
> > client is not expected to have access to the DMA engine device I would
> > argue that DMA engines should perform the mapping and the API should ta=
ke
> > a phys_addr_t.
>
> That is not a right assumption. Once the client gets a channel, they have
> access to dmaengine device and should use that to map. Yes the key is to =
map
> using dmaengine device and not client device. You can use chan->device->d=
ev.

Right, that's required by the DMA engine API even when not using slave=20
transfers. Which raises an interesting consistency issue in the API, I agre=
e=20
about that.

> > Vinod, unless you have reasons to do it otherwise, can we get your ack =
on
> > this approach and start hammering at the code ? The problem has remained
> > known and unfixed for too long, we need to move on.

--=20
Regards,

Laurent Pinchart

