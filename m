From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 10 Apr 2013 13:09:56 +0000
Subject: Re: [PATCH v4] dma: sudmac: add support for SUDMAC
Message-Id: <516564A4.1020608@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5163E470.7010107@renesas.com>
In-Reply-To: <5163E470.7010107@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

(2013/04/10 10:12), Kuninori Morimoto wrote:
> 
> Hi Shimoda-san
> 
> I have 3 comment

Thank you for the review.

>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 80b6997..8a3627b 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -183,6 +183,14 @@ config SH_DMAE
>>  	help
>>  	  Enable support for the Renesas SuperH DMA controllers.
>>
>> +config SUDMAC
>> +	tristate "Renesas SUDMAC support"
>> +	depends on (SUPERH && SH_DMA) || (ARM && ARCH_SHMOBILE)
>> +	depends on !SH_DMA_API
>> +	select DMA_ENGINE
>> +	help
>> +	  Enable support for the Renesas SUDMAC controllers.
>> +
> (snip)
>>  obj-$(CONFIG_SH_DMAE) += sh/
>> +obj-$(CONFIG_SUDMAC) += sh/
> (snip)
>>  obj-$(CONFIG_SH_DMAE) += shdma-base.o
>>  obj-$(CONFIG_SH_DMAE) += shdma.o
>> +obj-$(CONFIG_SUDMAC) += shdma-base.o sudmac.o
> 
> I guess this is good timing to create driver/dma/sh/Kconfig ?

I think so.
So, I will write a new patch that move the "config SH_DMAE" to the "driver/dma/sh/Kconfig",
and then, I will add the "config SUDMAC" in the Kconfig.

>> --- /dev/null
>> +++ b/drivers/dma/sh/sudmac.h
> 
> This is just my opinion.
> 
> If there is many driver/code which needs/shares common definition,
> creating new header is nice idea.
> But, in this case, sudmac.h user is sudmac.c only.
> It is easy to read code, and reduce file if these definitions exist on sudmac.c IMO

I got it, I will remove the drivers/dma/sh/sudmac.h.

>> diff --git a/include/linux/sudmac.h b/include/linux/sudmac.h
> (snip)
>> +/* Definitions for the sudmac_channel.config */
>> +#define SUDMAC_SENDBUFM	0x1000 /* b12: Transmit Buffer Mode */
>> +#define SUDMAC_RCVENDM	0x0100 /* b8: Receive Data Transfer End Mode */
>> +#define SUDMAC_LBA_WAIT	0x0030 /* b5-4: Local Bus Access Wait */
>> +
>> +/* Definitions for the sudmac_channel.dint_end_bit */
>> +#define SUDMAC_CH1ENDE	0x0002 /* b1: Ch1 DMA Transfer End Int Enable */
>> +#define SUDMAC_CH0ENDE	0x0001 /* b0: Ch0 DMA Transfer End Int Enable */
> 
> I think these are used as register value,
> and it comes from board/platform directly ?
> 
> But it is not good approach for me,
> because it is easy to break driver.
> 
> Can you use like this style ?

I got it. I will modify it.

> --- xxxx.h ----
> #define SUDMAC_TX_BUFFER_MODE	(1 << 0)
> #define SUDMAC_RV_END_MODE	(1 << 1)
> ...

Sergei pointed out this, so I will use the BIT() macro.

Best regards,
Yoshihiro Shimoda

> --- xxx.c ----
> 
> if (priv->flags & SUDMAC_TX_BUFFER_MODE)
>     val |= 0x1000
> if (priv->flags & SUDMAC_RV_END_MODE)
>     val |= 0x0100
> ...
> 
> Best regards
> ---
> Kuninori Morimoto
> 
