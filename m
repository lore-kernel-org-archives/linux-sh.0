From: Hamza Farooq <hamzahfrq.sub@gmail.com>
Date: Mon, 14 Sep 2015 12:39:23 +0000
Subject: Re: Issues with rcar-dmac and sh-sci
Message-Id: <CAJ--JmyBrgC7BWQZENgd3GBu59Cp-+WXa6SzyKE0rXJS9-H_+w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.10.1507162026200.821@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.10.1507162026200.821@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

While using this patch from Geert's scif-dma-v3 branch, I see that it makes the
rcar_dmac_chan_get_residue method very noisy, because of the WARN_ON in the
method.

I am using sh-sci driver, which inquires the status of a completed
cookie on time-out.
The current transaction status is updated in the IRQ thread, which not
necessarily
schedules right after the interrupt. Time-out occurs frequently,
hence, printing out this
warning on the console. It was so noisy that I had to disable the
WARN_ON in your
patch.

If you want a warning message here, I'd recommend a dev_dbg instead

Best,
Hamza

On Sat, Aug 15, 2015 at 1:42 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Geert,
>
> On Thursday 16 July 2015 20:36:49 Geert Uytterhoeven wrote:
>>       Hi Laurent,
>>
>> While working on DMA for R-Car Gen2 using the sh-sci serial driver with
>> rcar-dmac, I ran into two issues:
>>
>>   1. Unlike the old shdmac DMA engine driver, the new rcar-dmac DMA
>>      engine driver does not support resubmitting a DMA descriptor.
>>      I first tried the patch below, until I ran into the race condition,
>>      after which I changed sh-sci to not reuse DMA descriptors.
>
> Is reusing descriptors something that the DMA engine API explicitly allows ?
>
>>   2. rcar_dmac_chan_get_residue() has:
>>
>> static unsigned int rcar_dmac_chan_get_residue(struct rcar_dmac_chan *chan,
>>                                                dma_cookie_t cookie)
>> {
>>         struct rcar_dmac_desc *desc = chan->desc.running;
>>         ...
>>
>>         /*
>>          * If the cookie doesn't correspond to the currently running
>> transfer * then the descriptor hasn't been processed yet, and the residue
>> is       * equal to the full descriptor size.
>>          */
>>         if (cookie != desc->async_tx.cookie)
>>                 return desc->size;
>>
>>      If the cookie doesn't correspond to the currently running transfer,
>>      it returns the full descriptor size of the _currently running
>>      transfer_, not the transfer the cookie corresponds to.
>
> How about the following (untested) patch ?
>
> From 131968befd5de3400631b879b1574beea27b8239 Mon Sep 17 00:00:00 2001
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Date: Sat, 15 Aug 2015 01:28:28 +0300
> Subject: [PATCH] dmaengine: rcar-dmac: Fix residue reporting for pending
>  descriptors
>
> Cookies corresponding to pending transfers have a residue value equal to
> the full size of the corresponding descriptor. The driver miscomputes
> that and uses the size of the active descriptor instead. Fix it.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/dma/sh/rcar-dmac.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 7820d07e7bee..a98596a1f12f 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1143,19 +1143,43 @@ static unsigned int rcar_dmac_chan_get_residue(struct
> rcar_dmac_chan *chan,
>         struct rcar_dmac_desc *desc = chan->desc.running;
>         struct rcar_dmac_xfer_chunk *running = NULL;
>         struct rcar_dmac_xfer_chunk *chunk;
> +       enum dma_status status;
>         unsigned int residue = 0;
>         unsigned int dptr = 0;
>
>         if (!desc)
>                 return 0;
>
> +
> +       /*
> +        * If the cookie corresponds to a descriptor that has been completed
> +        * there is no residue. The same check has already been performed by the
> +        * caller but without holding the channel lock, so the descriptor could
> +        * now be complete.
> +        */
> +       status = dma_cookie_status(&chan->chan, cookie, NULL);
> +       if (status = DMA_COMPLETE)
> +               return 0;
> +
>         /*
>          * If the cookie doesn't correspond to the currently running transfer
>          * then the descriptor hasn't been processed yet, and the residue is
>          * equal to the full descriptor size.
>          */
> -       if (cookie != desc->async_tx.cookie)
> -               return desc->size;
> +       if (cookie != desc->async_tx.cookie) {
> +               list_for_each_entry(desc, &chan->desc.pending, node) {
> +                       if (cookie = desc->async_tx.cookie)
> +                               return desc->size;
> +               }
> +
> +               /*
> +                * No descriptor found for the cookie, there's thus no residue.
> +                * This shouldn't happen if the calling driver passes a correct
> +                * cookie value.
> +                */
> +               WARN(1, "No descriptor for cookie!");
> +               return 0;
> +       }
>
>         /*
>          * In descriptor mode the descriptor running pointer is not maintained
>
>>      I believe this the reason why the sh-sci driver once thought DMA
>>      transfered 4294967265 (= -31) bytes (for SCIF, descriptor lengths
>>      are either 1 or 32 bytes, and (length) 1 - (residue) 32 >>      (transfered) -31).
>>
>> Thanks for your comments!
>>
>> From 589dbd908a59dba6efc2a78fca24645962235ec2 Mon Sep 17 00:00:00 2001
>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>> Date: Tue, 14 Jul 2015 11:27:14 +0200
>> Subject: [PATCH] [RFC] dmaengine: rcar-dmac: Allow resubmission of DMA
>>  descriptors
>>
>> Unlike the old shdmac DMA engine driver, the new rcar-dmac DMA engine
>> driver does not support resubmitting a DMA descriptor.  If a DMA slave
>> resubmits a descriptor, the descriptor will be added to the "pending
>> list", while it wasn't removed from the "wait" list. This will cause
>> list corruption, leading to an infinite loop in
>> rcar_dmac_chan_reinit().
>>
>> Find out if the descriptor is reused by looking at the current cookie
>> valie, and remove it from the other list if needed:
>>   - cookie is initialized to -EBUSY (by rcar-dma) for fresh and properly
>>     recycled descriptors,
>>   - cookie is set to a strict-positive value by dma_cookie_assign() (in
>>     core dmaengine code) on submission,
>>   - cookie is reset to zero by dma_cookie_complete() (in core dmaengine
>>     code) on completion,
>>
>> Fix this by removing it from a list if the cookie is not -EBUSY.
>>
>> FIXME Unfortunately this is racy: the recycled descriptors are not part
>>       of a list while the DMA descriptor callback is running.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/dma/sh/rcar-dmac.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
>> index 11e5003a6cc27b40..92a8fddb025e6729 100644
>> --- a/drivers/dma/sh/rcar-dmac.c
>> +++ b/drivers/dma/sh/rcar-dmac.c
>> @@ -437,8 +437,20 @@ static dma_cookie_t rcar_dmac_tx_submit(struct
>> dma_async_tx_descriptor *tx) unsigned long flags;
>>       dma_cookie_t cookie;
>>
>> +
>>       spin_lock_irqsave(&chan->lock, flags);
>>
>> +     if (desc->async_tx.cookie != -EBUSY) {
>> +             /*
>> +              * If the descriptor is reused, it's currently part of a list.
>> +              * Hence it must be removed from that list first, before it can
>> +              * be added to the list of pending requests.
>> +              */
>> +             dev_dbg(chan->chan.device->dev, "chan%u: resubmit active desc %p\n",
>> +                     chan->index, desc);
>> +             list_del(&desc->node);
>> +     }
>> +
>>       cookie = dma_cookie_assign(tx);
>>
>>       dev_dbg(chan->chan.device->dev, "chan%u: submit #%d@%p\n",
>
> --
> Regards,
>
> Laurent Pinchart
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
