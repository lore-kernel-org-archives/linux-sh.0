From: Niklas =?iso-8859-1?Q?S=F6derlund?=  <niklas.soderlund+renesas@ragnatech.se>
Date: Mon, 11 Jan 2016 18:59:01 +0000
Subject: Re: [PATCH 1/2] dmaengine: rcar-dmac: add iommu support for slave transfers
Message-Id: <20160111185901.GA12337@bigcity.dyn.berto.se>
List-Id: <linux-sh.vger.kernel.org>
References: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

* Geert Uytterhoeven <geert@linux-m68k.org> [2016-01-11 08:55:48 +0100]:

> Hi Niklas,
>
> On Mon, Jan 11, 2016 at 3:17 AM, Niklas S=F6derlund
> <niklas.soderlund+renesas@ragnatech.se> wrote:
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
> >         return desc;
> >  }
> >
> > +static dma_addr_t __rcar_dmac_dma_map(struct dma_chan *chan, phys_addr=
_t addr,
> > +               size_t size, enum dma_data_direction dir)
> > +{
> > +       struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
> > +       struct page *page =3D phys_to_page(addr);
> > +       size_t offset =3D addr - page_to_phys(page);
> > +       dma_addr_t map =3D dma_map_page(chan->device->dev, page, offset=
, size,
> > +                       dir);
> > +
> > +       if (dma_mapping_error(chan->device->dev, map)) {
> > +               dev_err(chan->device->dev, "chan%u: failed to map %zx@%=
pap",
> > +                               rchan->index, size, &addr);
> > +               return 0;
>
> Zero may be a valid DMA address. Please use DMA_ERROR_CODE instead.

Thanks will fix together with the issue kbuild test robot found.

>
> > +       }
> > +
> > +       return map;
> > +}
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
