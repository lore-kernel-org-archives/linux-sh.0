From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 08 Apr 2014 08:53:13 +0000
Subject: Re: [PATCH 8/9] DMA: shdma: initial of common code
Message-Id: <5343B8F9.2050800@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk>	 <1396901229-29117-9-git-send-email-ben.dooks@codethink.co.uk> <1396944263.11914.80.camel@smile.fi.intel.com>
In-Reply-To: <1396944263.11914.80.camel@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Cc: "linux-kernel@lists.codethink.co.uk" <linux-kernel@lists.codethink.co.uk>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "Koul, Vinod" <vinod.koul@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "magnus.damm@opensource.se" <magnus.damm@opensource.se>, "horms@verge.net.au" <horms@verge.net.au>, "g.liakhovetski@gmx.d" <g.liakhovetski@gmx.d>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 08/04/14 09:04, Shevchenko, Andriy wrote:
> On Mon, 2014-04-07 at 21:07 +0100, Ben Dooks wrote:
>> Add support for building shdma internal data from the device tree to allow
>> converting the driver to be device tree enabled.
>>
>> It includes a helper for the of case to build the internal data used to
>> select and filter out the DMA channels from the ID information in the
>> device tree. Also updates the documentation for the DT case.
>
>
> Few minor comments below.
>
>> --- a/drivers/dma/sh/shdma-of.c
>> +++ b/drivers/dma/sh/shdma-of.c
>
>
>> @@ -40,6 +71,109 @@ static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
>>   	return chan;
>>   }
>>
>> +const struct sh_dmae_pdata *
>> +sh_dma_probe_of(struct platform_device *pdev, const struct of_device_id *ofmatch)
>> +{
>> +	const struct device_node *np = pdev->dev.of_node;
>> +	const struct sh_dmae_of_info *ofinf;
>> +	struct device *dev = &pdev->dev;
>> +	struct sh_dmae_pdata *pdata;
>> +	struct sh_dmae_channel *chan;
>> +	struct property *prop;
>> +	u32 nr_chan;
>> +	unsigned ch;
>> +	int ret;
>> +	int len;
>> +
>> +	if (!ofmatch)
>> +		return NULL;
>> +
>> +	ofinf = ofmatch->data;
>> +
>> +	pdata = devm_kzalloc(dev, sizeof(struct sh_dmae_pdata), GFP_KERNEL);
>
> sizeof(*pdata) ?

I will think on this one.

>> +	if (!pdata) {
>> +		dev_err(dev, "failed to make platform data\n");
>> +		return NULL;
>> +	}
>> +
>> +	*pdata = *ofinf->pdata_template;	/* copy in template first */
>> +
>> +	ret = of_property_read_u32(np, "dma-channels", &nr_chan);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to get number of channels\n");
>> +		return NULL;
>> +	}
>> +
>> +	chan = devm_kzalloc(dev, nr_chan * sizeof(struct sh_dmae_channel),
>> +			    GFP_KERNEL);
>
> devm_kcalloc()


Thanks.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
