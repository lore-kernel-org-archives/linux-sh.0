From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Aug 2014 11:30:18 +0000
Subject: Re: [PATCH v2 5/8] dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver
Message-Id: <CAMuHMdXBxR7XkQGHASLt4tJA2kR3BNqf2Wa3a2ZkRSBqMsHqig@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405727425-6237-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405727425-6237-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent

On Sat, Jul 19, 2014 at 1:50 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The DMAC is a general purpose multi-channel DMA controller that supports
> both slave and memcpy transfers.
>
> The driver currently supports the DMAC found in the r8a7790 and r8a7791
> SoCs. Support for compatible DMA controllers (such as the audio DMAC)
> will be added later.
>
> Feature-wise, automatic hardware handling of descriptors chains isn't
> supported yet. LPAE support is implemented.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, looks nice!

This driver also assumes manual attaching of each DMA slave to a single the
DMAC instance (sys-dmac0 or sys-dmac1) in DT?
Shouldn't we describe the real topology somewhere?

> Changes since v1:
>
> - Don't manage function clock manually

In the context of https://lkml.org/lkml/2014/7/29/669, I find this a bit
strange.
If we want to get rid of the drivers/sh/pm_runtime.c hack without using
common infrastructure, we'll have to add it back.

> --- /dev/null
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -0,0 +1,1525 @@

> +#define RCAR_DMAC_MAX_XFER_LEN         (RCAR_DMATCR_MASK + 1)

If I'm not mistaken, RCAR_DMAC_MAX_XFER_LEN is thus not the maximum
number of transfer bytes, but the maximum number of transfers?

> +/* -----------------------------------------------------------------------------
> + * Descriptors allocation and free
> + */
> +
> +/*
> + * rcar_dmac_desc_alloc - Allocate a page worth of DMA descriptors
> + * @chan: the DMA channel
> + */
> +static int rcar_dmac_desc_alloc(struct rcar_dmac_chan *chan)
> +{
> +       struct rcar_dmac_desc_page *page;
> +       LIST_HEAD(list);
> +       unsigned int i;
> +
> +       page = (void *)get_zeroed_page(GFP_KERNEL);
> +       if (!page)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < RCAR_DMAC_DESCS_PER_PAGE; ++i) {
> +               struct rcar_dmac_desc *desc = &page->descs[i];
> +
> +               dma_async_tx_descriptor_init(&desc->async_tx, &chan->chan);
> +               desc->async_tx.tx_submit = rcar_dmac_tx_submit;
> +               INIT_LIST_HEAD(&desc->hwdescs);
> +
> +               list_add_tail(&desc->node, &list);
> +       }
> +
> +       spin_lock_irq(&chan->lock);
> +       list_splice_tail(&list, &chan->desc.free);
> +       list_add_tail(&page->node, &chan->desc.pages);
> +       spin_unlock_irq(&chan->lock);
> +
> +       return 0;
> +}

Perhaps add a helper to allocate the page and add it to chan->desc.pages,
as the same is done in rcar_dmac_hw_desc_alloc()?
That would have made it more obvious to me why there were two calls to
get_zeroed_page(), but only one to free_page() ;-)

> +/*
> + * rcar_dmac_chan_prep_sg - prepare transfer descriptors from an SG list
> + *
> + * Common routine for public (MEMCPY) and slave DMA. The MEMCPY case is also
> + * converted to scatter-gather to guarantee consistent locking and a correct
> + * list manipulation. For slave DMA direction carries the usual meaning, and,
> + * logically, the SG list is RAM and the addr variable contains slave address,
> + * e.g., the FIFO I/O register. For MEMCPY direction equals DMA_MEM_TO_MEM
> + * and the SG list contains only one element and points at the source buffer.
> + */
> +static struct dma_async_tx_descriptor *
> +rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
> +                      unsigned int sg_len, dma_addr_t dev_addr,
> +                      enum dma_transfer_direction dir, unsigned long dma_flags,
> +                      bool cyclic)
> +{
> +       struct rcar_dmac_hw_desc *hwdesc;
> +       struct rcar_dmac_desc *desc;
> +       struct scatterlist *sg = sgl;

Unneeded initialization of sg.

> +       size_t full_size = 0;
> +       unsigned int i;

[...]

> +       /*
> +        * Allocate and fill the hardware descriptors. We own the only reference
> +        * to the DMA descriptor, there's no need for locking.
> +        */
> +       for_each_sg(sgl, sg, sg_len, i) {
> +               dma_addr_t mem_addr = sg_dma_address(sg);
> +               size_t len = sg_dma_len(sg);

sg_dma_len() returns unsigned int...

> +               full_size += len;
> +
> +               while (len) {
> +                       size_t size = min_t(size_t, len, RCAR_DMAC_MAX_XFER_LEN);

... so this can be unsigned int too, and the min_t() can become a plain min().

As RCAR_DMAC_MAX_XFER_LEN is the maximum number of transfers,
this should take into account xfer_shift.

> +static struct dma_async_tx_descriptor *
> +rcar_dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dma_dest,
> +                         dma_addr_t dma_src, size_t len, unsigned long flags)
> +{
> +       struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
> +       struct scatterlist sgl;
> +
> +       if (!len)
> +               return NULL;
> +
> +       sg_init_table(&sgl, 1);
> +       sg_set_page(&sgl, pfn_to_page(PFN_DOWN(dma_src)), len,
> +                   offset_in_page(dma_src));
> +       sg_dma_address(&sgl) = dma_src;
> +       sg_dma_len(&sgl) = len;

Is it safe to use the sg_dma_*() to _set_ the information?

include/asm-generic/scatterlist.h only talks about _getting_ information?

/*
 * These macros should be used after a dma_map_sg call has been done
 * to get bus addresses of each of the SG entries and their lengths.
 * You should only work with the number of sg entries pci_map_sg
 * returns, or alternatively stop on the first sg_dma_len(sg) which
 * is 0.
 */
#define sg_dma_address(sg)      ((sg)->dma_address)

#ifdef CONFIG_NEED_SG_DMA_LENGTH
#define sg_dma_len(sg)          ((sg)->dma_length)
#else
#define sg_dma_len(sg)          ((sg)->length)
#endif

Furthermore, as this length is unsigned int, it's degraded from size_t to
unsigned int (which is not a problem as long as this driver is not used on
64-bit).

> +
> +       return rcar_dmac_chan_prep_sg(rchan, &sgl, 1, dma_dest,
> +                                     DMA_MEM_TO_MEM, flags, false);
> +}

> +static struct dma_async_tx_descriptor *
> +rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
> +                         size_t buf_len, size_t period_len,
> +                         enum dma_transfer_direction dir, unsigned long flags,
> +                         void *context)
> +{

> +       /*
> +        * Allocate the sg list dynamically as it would consumer too much stack

consume

> +        * space.
> +        */
> +       sgl = kcalloc(sg_len, sizeof(*sgl), GFP_KERNEL);
> +       if (!sgl)
> +               return NULL;
> +
> +       sg_init_table(sgl, sg_len);
> +
> +       for (i = 0; i < sg_len; ++i) {
> +               dma_addr_t src = buf_addr + (period_len * i);
> +
> +               sg_set_page(&sgl[i], pfn_to_page(PFN_DOWN(src)), period_len,
> +                           offset_in_page(src));
> +               sg_dma_address(&sgl[i]) = src;
> +               sg_dma_len(&sgl[i]) = period_len;

Ditto: assignment using sg_dma_*().

> +       }
> +
> +       desc = rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, rchan->slave_addr,
> +                                     dir, flags, true);
> +
> +       kfree(sgl);
> +       return desc;
> +}

> +static irqreturn_t rcar_dmac_isr_transfer_end(struct rcar_dmac_chan *chan)
> +{
> +       struct rcar_dmac_desc *desc = chan->desc.running;
> +       struct rcar_dmac_hw_desc *hwdesc;
> +       irqreturn_t ret = IRQ_WAKE_THREAD;
> +
> +       if (WARN_ON(!desc)) {

WARN_ON_ONCE()?

> +               /*
> +                * This should never happen, there should always be
> +                * a running descriptor when a transfer ends. Warn and
> +                * return.
> +                */
> +               return IRQ_NONE;
> +       }

> +static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
> +                               struct rcar_dmac_chan *rchan,
> +                               unsigned int index)
> +{
> +       struct platform_device *pdev = to_platform_device(dmac->dev);
> +       struct dma_chan *chan = &rchan->chan;
> +       char irqname[5];

This is limited to DMACs with less than 100 channels, right?
Do we have to consider DT attack vectors inducing buffer overflows?

[...]

> +       rchan->irqname = devm_kmalloc(dmac->dev,
> +                                     strlen(dev_name(dmac->dev)) + 4,

Ditto, max. 100 channels.

> +                                     GFP_KERNEL);
> +       if (!rchan->irqname)
> +               return -ENOMEM;
> +       sprintf(rchan->irqname, "%s:%u", dev_name(dmac->dev), index);

We really need devm_kasprintf() (coding it up)...

> +static int rcar_dmac_probe(struct platform_device *pdev)
> +{

> +       dmac->irqname = devm_kmalloc(dmac->dev, strlen(dev_name(dmac->dev)) + 7,
> +                                    GFP_KERNEL);
> +       if (!dmac->irqname)
> +               return -ENOMEM;
> +       sprintf(dmac->irqname, "%s:error", dev_name(&pdev->dev));

We really need devm_kasprintf()...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
