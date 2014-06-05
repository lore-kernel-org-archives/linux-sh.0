From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 05 Jun 2014 16:40:42 +0000
Subject: Re: [PATCH 2/8] shdma: fdt: allocate and use local hwid bitmap for shdma mux
Message-Id: <53909D8A.8060207@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1401898455-31064-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1401898455-31064-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 05/06/14 11:47, Kuninori Morimoto wrote:
> Hi Ben
> 
>> Move the shdma-of.c code to allocating and using a slave bitmap for
>> tracking allocation of the slave channels used by the mid-rid stored
>> in the phandle for the mux.
>>
>> This means that we can have multiple shdma muxes in the system without
>> any issue of slave-ids clashing and all the child dma units will be
>> able to properly protect against the re-use of a mid/rid pair.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
> (snip)
>> +void shdma_of_setup(struct device *dev, struct shdma_dev *shdev)
>> +{
>> +	struct shdma_of_state *ofs = dev_get_platdata(dev->parent);
>> +
>> +	shdev->slave_used = ofs->slave_used;
>> +}
>> +
>>  static int shdma_of_probe(struct platform_device *pdev)
>>  {
>>  	const struct of_dev_auxdata *lookup = dev_get_platdata(&pdev->dev);
>> +	struct shdma_of_state *ofs;
>>  	int ret;
>>  
>> +	ofs = devm_kzalloc(&pdev->dev, sizeof(*ofs), GFP_KERNEL);
>> +	if (!ofs)
>> +		return -ENOMEM;
>> +
>>  	ret = of_dma_controller_register(pdev->dev.of_node,
>>  					 shdma_of_xlate, pdev);
>>  	if (ret < 0)
>> diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
> 
> This ofs is created by devm_kzalloc(), but not used ??
> It is missing to call dev_set_platdata() ?

Thanks for noticing it, I've yet to actually get access to a board
to test this.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
