From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 23 Apr 2013 04:18:23 +0000
Subject: Re: [PATCH 2/2 v7] sudmac: add support for SUDMAC
Message-Id: <51760B8F.4020509@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5174FDF3.8060809@renesas.com>
In-Reply-To: <5174FDF3.8060809@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the comment.

(2013/04/23 9:41), Kuninori Morimoto wrote:
< snip >
>> diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
>> index 54ae957..16f9225 100644
>> --- a/drivers/dma/sh/Makefile
>> +++ b/drivers/dma/sh/Makefile
>> @@ -1,2 +1,3 @@
>>  obj-$(CONFIG_SH_DMAE) += shdma-base.o
>>  obj-$(CONFIG_SH_DMAE) += shdma.o
>> +obj-$(CONFIG_SUDMAC) += shdma-base.o sudmac.o
> 
> I'm not sure detail of it, but, I thought we can do like this.
> Is it possible ? 

It is possible, I think.
But,

> --- Kconfig ---
> config SH_DMAE_BASE
> 	xxx
> 
> config SH_DMAE
> 	xxx
> 	depends on SH_DMAE_BASE
> 
> config SH_SUDMAC
> 	xxx
> 	depends on SH_DMAE_BASE

it can choose the SH_DMAE_BASE only, but we will use
"SH_DMAE_BASE && SH_DMAE" or "SH_DMAE_BASE && SH_SUDMAC".
So, I intend to modify the Kconfig like the "config DMA_ENGINE":

--- Kconfig ---
config SH_DMAE
	xxx
	select SH_DMAE_BASE

config SUDMAC
	xxx
	select SH_DMAE_BASE
---------------

What do you think about this?

> --- Makefile ---
> 
> obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o
> obj-$(CONFIG_SH_DMAE) += shdma.o
> obj-$(CONFIG_SUDMAC) += sudmac.o

I think it is nice.

Best regards,
Yoshihiro Shimoda

> Best regards
> ---
> Kuninori Morimoto
> 
