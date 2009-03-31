From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2009 16:01:33 +0000
Subject: Re: [PATCH v3] dmaengine: sh: Add Support SuperH DMA Engine driver
Message-Id: <49D23E5D.2020209@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49C9D558.7030002@renesas.com>
In-Reply-To: <49C9D558.7030002@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Wed, Mar 25, 2009 at 03:55:20PM +0900, Nobuhiro Iwamatsu wrote:
>> This supported all DMA channels, and it was tested in SH7722,
>> SH7780 and SH7763.
>> This can not use with SH DMA API.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
>> Reviewed-by: Matt Fleming <matt@console-pimps.org>
> 
> I don't know why you dropped Dan from the CC, but you need his Acked-by
> or Reviewed-by before this can be merged.

Thanks Paul.

This version still has the problem of up leveling the descriptor lock to 
  spin_lock_irqsave from spin_lock_bh.  This poses a problem for 
completion callback support where callbacks assume that interrupts are 
enabled, like a timer callback.  I have also spotted a new problem below:

> 
>> ---
>>
>>  V3: Reflect Maciej's comments.
>>
>>  arch/sh/drivers/dma/Kconfig  |   12 +-
>>  arch/sh/drivers/dma/Makefile |    3 +-
>>  arch/sh/include/asm/dma-sh.h |   13 +
>>  drivers/dma/Kconfig          |    8 +
>>  drivers/dma/Makefile         |    2 +
>>  drivers/dma/shdma.c          |  756 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/dma/shdma.h          |   64 ++++
>>  7 files changed, 853 insertions(+), 5 deletions(-)
>>  create mode 100644 drivers/dma/shdma.c
>>  create mode 100644 drivers/dma/shdma.h
[..]
>> +static struct sh_desc *sh_dmae_alloc_descriptor(struct sh_dmae_chan *sh_chan)
>> +{
>> +     struct sh_desc *desc_sw;
>> +     desc_sw = kzalloc(sizeof(struct sh_desc), GFP_KERNEL);
>> +     if (desc_sw) {
>> +             dma_async_tx_descriptor_init(&desc_sw->async_tx,
>> +                                             &sh_chan->common);
>> +             desc_sw->async_tx.tx_submit = sh_dmae_tx_submit;
>> +             INIT_LIST_HEAD(&desc_sw->async_tx.tx_list);
>> +     }
>> +
>> +     return desc_sw;
>> +}
>> +
>> +static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
>> +{
>> +     return 1;
>> +}

The point of this routine is to preallocate descriptors because...

>> +
>> +/*
>> + * sh_dma_free_chan_resources - Free all resources of the channel.
>> + */
[..]
>> +
>> +static struct dma_async_tx_descriptor *sh_dmae_prep_memcpy(
>> +     struct dma_chan *chan, dma_addr_t dma_dest, dma_addr_t dma_src,
>> +     size_t len, unsigned long flags)
>> +{
>> +     struct sh_dmae_chan *sh_chan;
>> +     struct sh_desc *first = NULL, *prev = NULL, *new;
>> +     size_t copy_size;
>> +     int cnt = 0;
>> +     LIST_HEAD(link_chain);
>> +
>> +     if (!chan)
>> +             return NULL;
>> +
>> +     if (!len)
>> +             return NULL;
>> +
>> +     sh_chan = to_sh_chan(chan);
>> +
>> +     do {
>> +             /* Allocate the link descriptor from DMA pool */
>> +             new = sh_dmae_alloc_descriptor(sh_chan);

...we may not be able to do a GFP_KERNEL allocation here.

>> +             if (!new) {
>> +                     dev_err(sh_chan->dev,
>> +                                     "No free memory for link descriptor\n");
>> +                     return NULL;
>> +             }

--
Dan
