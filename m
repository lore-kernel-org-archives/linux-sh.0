From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 14 Jul 2011 02:17:41 +0000
Subject: Re: [PATCH 2/2] i2c: i2c-riic: add dmaengine supporting
Message-Id: <4E1E51C5.9050908@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4E0D1C42.2080804@renesas.com>
 <20110713201018.GD3369@freya.fluff.org>
In-Reply-To: <20110713201018.GD3369-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Ben,

2011/07/14 5:10, Ben Dooks wrote:
> On Fri, Jul 01, 2011 at 10:00:50AM +0900, Yoshihiro Shimoda wrote:
>> diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
>> index dcc183b..22dd779 100644
>> --- a/drivers/i2c/busses/i2c-riic.c
>> +++ b/drivers/i2c/busses/i2c-riic.c
>> @@ -30,6 +30,7 @@
>>  #include <linux/timer.h>
>>  #include <linux/delay.h>
>>  #include <linux/slab.h>
>> +#include <linux/dmaengine.h>
>>
>>  #define RIIC_ICCR1	0x00
>>  #define RIIC_ICCR2	0x01
>> @@ -164,6 +165,14 @@ struct riic_data {
>>  	void __iomem *reg;
>>  	struct i2c_adapter adap;
>>  	struct i2c_msg *msg;
>> +	int index;
>> +	unsigned char icsr2;
>> +
>> +	/* for DMAENGINE */
>> +	struct dma_chan *chan_tx;
>> +	struct dma_chan *chan_rx;
>> +	int dma_callbacked;
>> +	wait_queue_head_t wait;
>>  };
> 
> What happens if the driver is compiled into a kernel
> without dma engine support?

I could compile the code without enabling "CONFIG_DMA_ENGINE".
This is because The "struct dma_chan" is always defined in
the "include/linux/dmaengine.h", I think.

>> +static int riic_master_transmit_dma(struct riic_data *pd)
>> +{
>> +	struct scatterlist sg;
>> +	unsigned char *buf = pd->msg->buf;
>> +	struct dma_async_tx_descriptor *desc;
>> +	int ret;
>> +
>> +	sg_init_table(&sg, 1);
>> +	sg_set_buf(&sg, buf, pd->msg->len);
>> +	sg_dma_len(&sg) = pd->msg->len;
>> +	dma_map_sg(pd->chan_tx->device->dev, &sg, 1, DMA_TO_DEVICE);
>> +
>> +	desc = pd->chan_tx->device->device_prep_slave_sg(pd->chan_tx,
>> +				&sg, 1, DMA_TO_DEVICE,
>> +				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> 
> surely there's a better way of calling this?

Umm, I checked other drivers in the "drivers/", but I didn't find
a better way. Also other drivers was similar code...

>> +	dmaengine_submit(desc);
>> +	dma_async_issue_pending(pd->chan_rx);
>> +
>> +	ret = wait_event_timeout(pd->wait, pd->dma_callbacked, HZ);
>> +	if (!pd->dma_callbacked && !ret) {
> 
> hmm, if you did not time out, then you should be able to
> infer the pd->dma_callbacked?

If this did not time out, the pd->dma_callbacked is always set.
So, I will fix the code to "if (!ret && !pd->dma_callbacked) {".

>> +static void riic_request_dma(struct riic_data *pd,
>> +			     struct riic_platform_data *riic_data)
>> +{
>> +	dma_cap_mask_t mask;
>> +
>> +	if (riic_data->dma_tx.slave_id) {
>> +		dma_cap_zero(mask);
>> +		dma_cap_set(DMA_SLAVE, mask);
>> +		pd->chan_tx = dma_request_channel(mask, riic_filter,
>> +						  &riic_data->dma_tx);
>> +	}
>> +	if (riic_data->dma_rx.slave_id) {
>> +		dma_cap_zero(mask);
>> +		dma_cap_set(DMA_SLAVE, mask);
>> +		pd->chan_rx = dma_request_channel(mask, riic_filter,
>> +						  &riic_data->dma_rx);
>> +	}
>> +}
> 
> should there be a warning if the slave_id is valid and
> the dma channel cannot be requested?

I will add a warning message.
However, even if the driver doesn't use dma, it can use PIO mode.

Best regards,
Yoshihiro Shimoda
