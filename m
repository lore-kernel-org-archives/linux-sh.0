From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 15 Apr 2014 09:54:51 +0000
Subject: Re: [PATCH v2 8/9] DMA: shdma: initial of common code
Message-Id: <534D01EB.3080702@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1397511312-4845-1-git-send-email-ben.dooks@codethink.co.uk> <1397511312-4845-9-git-send-email-ben.dooks@codethink.co.uk> <4431489.B0PGdfS6ct@wuerfel>
In-Reply-To: <4431489.B0PGdfS6ct@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org, vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org

On 14/04/14 23:06, Arnd Bergmann wrote:
> On Monday 14 April 2014 22:35:11 Ben Dooks wrote:
>> Add support for building shdma internal data from the device tree to allow
>> converting the driver to be device tree enabled.
>>
>> It includes a helper for the of case to build the internal data used to
>> select and filter out the DMA channels from the ID information in the
>> device tree. Also updates the documentation for the DT case.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>
> I think you should try to explain better here why you need all the logic
> that other drivers don't for the DT case.
>
> I've tried to understand what you are doing with shdma_of_client and
> couldn't quite figure it out. The driver is already different from
> all the others, because it still uses the 'slave_id' field in
> dma_slave_config (only for the non-DT case) that all other drivers
> don't use at all.
>
> My guess is that if you manage to clean that up first, all of this
> wouldn't be necessary.

Does anyone else have comments on this from a Renesas perspective? We
can uniquely identify a channel on a single DMAC using the MID/RID mux
control value.

If we can unify the slave-id and the MID/RID values then the driver is
simpler and we can drop part of the update and make the entire SHDMA
system simpler.

>>   static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
>>   				       struct of_dma *ofdma)
>>   {
>> +	struct platform_device *pdev = ofdma->of_dma_data;
>>   	u32 id = dma_spec->args[0];
>>   	dma_cap_mask_t mask;
>>   	struct dma_chan *chan;
>>
>> -	if (dma_spec->args_count != 1)
>> +	if (dma_spec->args_count = 2) {
>> +		struct shdma_of_state *state = platform_get_drvdata(pdev);
>> +		struct shdma_of_client *client;
>> +
>> +		client = shdma_of_find_client(state, id);
>> +		if (!client) {
>> +			client = devm_kzalloc(&pdev->dev, sizeof(*client),
>> +					      GFP_KERNEL);
>> +			if (!client)
>> +				return NULL;
>> +
>> +			client->index = atomic_inc_return(&of_slave_index);
>> +			client->cfg.slave_id = id;
>> +			client->cfg.mid_rid = id;
>> +			client->cfg.chcr = dma_spec->args[1];
>
> Can you explain the purpose of setting the chcr in DT? For all I can
> tell, this should come from the device driver when that calls the
> dma_slave_config function, unlike the mid_rid value.

See previous note about transfer-widths and register-sizes not always
matching. I also do not have any idea about other SoCs in the series
if there are any differences between channel settings.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
