From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 20 Sep 2012 11:23:06 +0000
Subject: Re: [PATCH v2] dma: sudmac: add support for SUDMAC
Message-Id: <505AFC9A.6040903@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <505AA372.4050303@renesas.com>
In-Reply-To: <505AA372.4050303@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi-san,

2012/09/20 19:29, Guennadi Liakhovetski wrote:
> Hi Shimoda-san
> 
> Thanks for an update. This version is moving in the right direction, but I 
> think, it has to be further improved. The point of device-managed function 
> versions is that resources, allocated with their help (memory, IRQs, 
> IO-regions, etc.) do not have to be explicitly freed on error paths or 
> device unloading. They are managed automatically and will be released once 
> the driver is unbound from the device or if the probing fails. So, all 
> calls to devm_kfree(), devm_ioremap_release() shall be removed. In my 
> original review I also suggested to use devm_request_and_ioremap(), which 
> also does request_mem_region() internally. Is there any specific reason 
> why you didn't use it?

Thank you very much for the review. I understood about device-managed function.
(I should have read the Documentation/driver-model/devres.txt before I submitted
 this patch.)
And, I didn't have any reason to use devm_ioremap(). So, I will fix it.

> Also, see below.
> 
> On Thu, 20 Sep 2012, Shimoda, Yoshihiro wrote:
< snip >
>> +#define DEN		0x0001 /* b0: DMA Transfer Enable */
> 
> Personally, I would hard-code "1" instead of the DEN macro and put 
> everything from this header directly into the .c file, but that's just my 
> personal preference, it's up to you to decide.

I think so. I will fix it.

< snip >
>> +struct sudmac_channel {
>> +	unsigned long	offset;
>> +	unsigned long	config;
>> +	unsigned long	dint_end_bit;
>> +};
< snip >
>> +/* Definitions for the SUDMAC */
>> +#define SUDMAC_SENDBUFM	0x1000 /* b12: Transmit Buffer Mode */
>> +#define SUDMAC_RCVENDM	0x0100 /* b8: Receive Data Transfer End Mode */
>> +#define SUDMAC_LBA_WAIT	0x0030 /* b5-4: Local Bus Access Wait */
>> +#define SUDMAC_CH1ENDE	0x0002 /* b1: Ch1 DMA Transfer End Int Enable */
>> +#define SUDMAC_CH0ENDE	0x0001 /* b0: Ch0 DMA Transfer End Int Enable */
> 
> What are these macros needed for? I didn't find any of them in the driver.

The "struct sudmac_channel" needs these macros.
I will add some comments.

Best regards,
Yoshihiro Shimoda

>> +
>> +#endif
>> -- 
>> 1.7.1
>>
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 

