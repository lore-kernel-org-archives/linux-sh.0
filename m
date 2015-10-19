From: Hamza Farooq <hamzahfrq.sub@gmail.com>
Date: Mon, 19 Oct 2015 21:16:40 +0000
Subject: Re: [PATCH v3 2/6] dma: rcar-dma: Added dma_pause operation to rcar_dma driver
Message-Id: <CAJ--Jmw87w2D=AN7i+Sgd6+PxPMNFeXSZ4YHR7U2oOCMKTCpYg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443559488-2416-3-git-send-email-hamzahfrq.sub@gmail.com>
In-Reply-To: <1443559488-2416-3-git-send-email-hamzahfrq.sub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent, Vinod,


On Thu, Oct 15, 2015 at 5:18 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Muhammad,
>
> Thank you for the patch.
>
> On Tuesday 29 September 2015 22:44:44 hamzahfrq.sub@gmail.com wrote:
>> From: Muhammad Hamza Farooq <mfarooq@visteon.com>
>>
>> Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
>> ---
>>  drivers/dma/sh/rcar-dmac.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
>> index 2b28291..c7cd4ed 100644
>> --- a/drivers/dma/sh/rcar-dmac.c
>> +++ b/drivers/dma/sh/rcar-dmac.c
>> @@ -774,6 +774,26 @@ static void rcar_dmac_chan_reinit(struct rcar_dmac_chan
>> *chan) }
>>  }
>>
>> +static int rcar_dmac_chan_pause(struct dma_chan *chan)
>> +{
>> +     u32 chcr;
>> +     int ret;
>> +     unsigned long flags;
>> +     struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
>> +
>> +     spin_lock_irqsave(&rchan->lock, flags);
>> +
>> +     chcr = rcar_dmac_chan_read(rchan, RCAR_DMACHCR);
>> +     chcr &= ~RCAR_DMACHCR_DE;
>> +     rcar_dmac_chan_write(rchan, RCAR_DMACHCR, chcr);
>> +     ret = rcar_dmac_wait_stop(rchan);
>
> The DMA engine API documents the pause operation as stopping DMA transfers in
> a resumable way without data loss. Doesn't stopping the transfer forcefully
> like this result in incomplete transfers and thus data loss ? Shouldn't we
> instead signal the pause request to the interrupt handler to avoid starting
> the next transfer and wait for the end of the current transfer ?

This fix is invalid if pausing the DMA engine midway through a
transfer is not allowed. If it is allowed, I'm not sure if it would
cause data loss. Additionally, if we signal the interrupt to pause the
DMA transfer, we cannot return true status of dma_pause operation
through this function call as it is a non-blocking function.

I think more research is needed in this direction. Perhaps Vinod can help

>
>> +
>> +     spin_unlock_irqrestore(&rchan->lock, flags);
>> +
>> +     WARN_ON(ret < 0);
>> +     return ret;
>> +}
>> +
>>  static void rcar_dmac_stop(struct rcar_dmac *dmac)
>>  {
>>       rcar_dmac_write(dmac, RCAR_DMAOR, 0);
>> @@ -1740,6 +1760,7 @@ static int rcar_dmac_probe(struct platform_device
>> *pdev) engine->device_prep_slave_sg = rcar_dmac_prep_slave_sg;
>>       engine->device_prep_dma_cyclic = rcar_dmac_prep_dma_cyclic;
>>       engine->device_config = rcar_dmac_device_config;
>> +     engine->device_pause = rcar_dmac_chan_pause;
>>       engine->device_terminate_all = rcar_dmac_chan_terminate_all;
>>       engine->device_tx_status = rcar_dmac_tx_status;
>>       engine->device_issue_pending = rcar_dmac_issue_pending;
>
> --
> Regards,
>
> Laurent Pinchart
>
