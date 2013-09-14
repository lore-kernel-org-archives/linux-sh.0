From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 14 Sep 2013 19:04:26 +0000
Subject: Re: [PATCH v3] dma: add driver for R-Car HPB-DMAC
Message-Id: <5234B33A.8040409@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201308250033.24936.sergei.shtylyov@cogentembedded.com> <Pine.LNX.4.64.1309142017040.28905@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309142017040.28905@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: djbw@fb.com, vinod.koul@intel.com, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, max.filippov@cogentembedded.com

Hello.

On 09/14/2013 10:33 PM, Guennadi Liakhovetski wrote:

>> From: Max Filippov <max.filippov@cogentembedded.com>

>> Add support for HPB-DMAC found in Renesas R-Car SoCs, using 'shdma-base' DMA
>> driver framework.

>> Based on the original patch by Phil Edworthy <phil.edworthy@renesas.com>.

>> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
>> [Sergei: removed useless #include, sorted #include's, fixed HPB_DMA_TCR_MAX,
>> fixed formats and removed line breaks in the dev_dbg() calls, rephrased and
>> added IRQ # to the shdma_request_irq() failure message, added MODULE_AUTHOR(),
>> removed '__init'/'__exit' annotations from the probe()/remove() methods, removed
>> '__initdata' annotation from 'hpb_dmae_driver', fixed guard macro name in the
>> header file, fixed #define ASYNCRSTR_ASRST20, added #define ASYNCRSTR_ASRST24,
>> added the necessary runtime PM calls to the probe() and remove() methods,
>> handled errors returned by dma_async_device_register(), beautified comments
>> and #define's.]
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---

> [snip]

>> Index: slave-dma/drivers/dma/sh/rcar-hpbdma.c
>> =================================>> --- /dev/null
>> +++ slave-dma/drivers/dma/sh/rcar-hpbdma.c
>> @@ -0,0 +1,655 @@

> [snip]

>> +static int hpb_dmae_chan_probe(struct hpb_dmae_device *hpbdev, int id)
>> +{
>> +	struct shdma_dev *sdev = &hpbdev->shdma_dev;
>> +	struct platform_device *pdev >> +		to_platform_device(hpbdev->shdma_dev.dma_dev.dev);
>> +	struct hpb_dmae_chan *new_hpb_chan;
>> +	struct shdma_chan *schan;
>> +
>> +	/* Alloc channel */
>> +	new_hpb_chan = devm_kzalloc(&pdev->dev,
>> +				    sizeof(struct hpb_dmae_chan), GFP_KERNEL);
>> +	if (!new_hpb_chan) {
>> +		dev_err(hpbdev->shdma_dev.dma_dev.dev,
>> +			"No free memory for allocating DMA channels!\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	schan = &new_hpb_chan->shdma_chan;

> A suggestion for an incremental patch - you might want to initialise the
> max_xfer_len field like

> 	schan->max_xfer_len = 64 * 1024 * 1024 - 1;

    IIRC, the HPB-DMAC's maximum transfer length is 16 MiB, without -1. You 
probably mixed it with LBSC-DMAC which is indeed capable of 64 MiB.

> because if it isn't initialised your max transfer length will be 4k,
> which will hurt your performance. I think you should get a better
> throughput after that

    OK, note taken. We'll look into it.

WBR, Sergei

