From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 11 Jan 2012 00:43:58 +0000
Subject: Re: [PATCH v3 1/3] dmaengine: shdma: modify the DMAC Address Error
Message-Id: <4F0CDB4E.30809@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0BDCD5.9020603@renesas.com>
In-Reply-To: <4F0BDCD5.9020603@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Guennadi-san,

Thank you very much for your review!

2012/01/10 18:48, Guennadi Liakhovetski wrote:
> Hello Shimoda-san
> 
> Thanks for your work on this! Nice to see patches improving!
> 
> On Tue, 10 Jan 2012, Shimoda, Yoshihiro wrote:
> 
>> +	errirq_res = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
>> +						  "error_irq");
> 
> Wouldn't this break all platforms, providing error IRQ, because they don't 
> yet have any IRQ resources with that name? Also, I think, it would be good 
> to define macros for DMAC IRQ names, similar to SH_MOBILE_SDHI_IRQ_* 
> macros in include/linux/mmc/sh_mobile_sdhi.h. To avoid breakages you, 
> probably, want to
> 
> 1. add IRQ resource name definition macros to the header
> 2. add IRQ resource names to platforms. This shouldn't break anything, you 
> still can request those IRQs without name.
> 3. convert the driver. Here I would try to think of a scheme, where we 
> wouldn't have to mix named and unnamed IRQ resources. So, maybe use all of 
> them as named. So, how about
> 
> 3.1. Request both "error irq" and "channel irq" IRQ resources
> 3.2. If none is supplied - error out
> 3.3. If an error IRQ is provided - request it
> 3.4. If no separate channel IRQs are provided - request error IRQ 
> additional times, according to the channel count
> 3.5. If separate channel IRQs are provided - request them just like now
> 
> Would this make sense?

I think that it is very nice.
I will write such a code.

Best regards,
Yoshihiro Shimoda

> 
> Thanks
> Guennadi
