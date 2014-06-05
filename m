From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 05 Jun 2014 09:57:29 +0000
Subject: Re: [PATCH 5/8] shdmac: fdt: wire r8a7790 for device tree usage.
Message-Id: <53903F09.7020001@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1401898455-31064-6-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1401898455-31064-6-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 05/06/14 09:16, Kuninori Morimoto wrote:
> 
> Hi Ben
> 
>> Add support for R8A7790 with new device tree code
>>
>> Note, not yet converted the only other user to dt yet
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
> (snip)
>>  static const struct of_device_id sh_dmae_of_match[] = {
>> -	{.compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid,},
>> +	{ .compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid },
>> +	{ .compatible = "renesas,dma-r8a7790", .data = &shdma_arm_info },
>>  	{}
>>  };
> 
> renesas,shdma-r8a7790 ?
> renesas,dma-r8a7790 ?
> 
> Is this typo ? or on  purpose ?

Thanks for the feedback.

I thought dma was a pretty good description. Do we need to call this
shdma-r8a7790?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
