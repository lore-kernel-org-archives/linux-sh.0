From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 09 Apr 2013 11:31:43 +0000
Subject: Re: [PATCH v4] dma: sudmac: add support for SUDMAC
Message-Id: <5163FC1F.8040909@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5163E470.7010107@renesas.com>
In-Reply-To: <5163E470.7010107@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

(2013/04/09 19:16), Paul Mundt wrote:
> On Tue, Apr 09, 2013 at 06:50:40PM +0900, Shimoda, Yoshihiro wrote:
>> Some Renesas USB modules have SUDMAC. This patch supports it using
>> the shdma-base driver.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> ...
> 
>> +#define SUDMAC_MAX_CHANNELS 2
>> +
> ...
> 
>> +struct sudmac_device {
>> +	struct shdma_dev shdma_dev;
>> +	struct sudmac_chan *chan[SUDMAC_MAX_CHANNELS];
>> +	struct sudmac_pdata *pdata;
>> +	void __iomem *chan_reg;
>> +};
>> +
> ...
> 
>> +struct sudmac_pdata {
>> +	const struct sudmac_slave_config *slave;
>> +	int slave_num;
>> +	const struct sudmac_channel *channel;
>> +	int channel_num;
>> +};
>> +
> I'm a bit perplexed as to why you have a hardcoded max channel count when
> it can all be derived from the platform data in the first place?
> 

Thank you for the point.
The current driver didn't use the "sudmac_device.chan" actually.
So, I should remove the "sudmac_device.chan" and SUDMAC_MAX_CHANNELS.
I will submit a new patch soon.

Best regards,
Yoshihiro Shimoda
