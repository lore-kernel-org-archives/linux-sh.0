From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 09 Feb 2011 07:44:27 +0000
Subject: Re: [PATCH] dma: shdma: add checking the DMAOR_AE in sh_dmae_err
Message-Id: <4D5245DB.4060206@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D523980.2080309@renesas.com>
In-Reply-To: <4D523980.2080309@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

2011/02/09 16:19, Paul Mundt wrote:
> On Wed, Feb 09, 2011 at 03:51:44PM +0900, Yoshihiro Shimoda wrote:
>> The irq numbers of tranfer end and address error are assigned same number
>> on some CPU. So the sh_dmae_err() should check the AE flag in DMAOR.
>>
> Looks ok, but..
> 
>>  static irqreturn_t sh_dmae_err(int irq, void *data)
>>  {
>> -	return IRQ_RETVAL(sh_dmae_reset(data));
>> +	struct sh_dmae_device *shdev = (struct sh_dmae_device *)data;
>> +
> Please do not ever cast void pointers, it's completely pointless and just
> means someone else has to go and tidy up the patch manually.
Thank you very much for your prompt review.
I understood it. I will send the modified patch soon.

Thanks,
Yoshihiro Shimoda
