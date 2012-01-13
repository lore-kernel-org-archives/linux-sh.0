From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 13 Jan 2012 08:03:29 +0000
Subject: Re: [PATCH v4 6/6] dmaengine: shdma: add support for SUDMAC
Message-Id: <4F0FE551.8070209@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0D3A10.7000708@renesas.com>
In-Reply-To: <4F0D3A10.7000708@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Guennadi-san,

Thank you very much for your comment!

2012/01/13 1:29, Guennadi Liakhovetski wrote:
> Hello Shimoda-san
> 
> On Wed, 11 Jan 2012, Shimoda, Yoshihiro wrote:
> 
>> The SH7757's USB module has SUDMAC. The SUDMAC's registers are imcompatible
>> with SH DMAC. However, since the SUDMAC is a very simple module, we can
>> reuse the shdma driver for SUDMAC by a few modification.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> I'm quite happy with patches 1-5 of this series! So, if you wanted, you 
> could add my ack for them, but Paul prefers v3. Well, I agree, that having 
> strings in the header is not crucial. As long as we make sure to update 
> platforms before the driver - nothing will break. That said, I would find 
> it nicer to see those patches in this series - just for completeness.
> 
> As for either converting both error and channel IRQs to named resources in 
> one or separate patches - I don't have a strong preference there either, 
> so, I can live with v3 too:-) Actually, there's a slight problem with 
> using named IRQs for channels: since we can have several resources with 
> channel IRQ ranges or with single IRQs per device, we cannot use 
> platform_get_resource_byname() for all of them - only for the first one, 
> which kind of makes this effort of converting all channel IRQ resources to 
> named ones - pointless...

I think so. The v4 patches use platform_get_resource_byname() for the channels,
but it also use platform_get_resource() later...

> Now, what concerns this patch. It is hard for me to judge, since I don't 
> have an sh7757 datasheet, but from the patch and from your comment "The 
> SUDMAC's registers are imcompatible with SH DMAC" I really begin to doubt, 
> whether it makes sense to combine them in one driver. AFAICS, the hardware 
> handling is indeed completely different. The only things, that you reuse 
> in the driver, are the dmaengine API implementation, which is pretty 
> standard, and the transfer descriptor list management, which is indeed a 
> bit tricky. My suggestion would be to split the current shdma.c driver 
> into two parts - hardware specific and the logic, and reuse the latter for 
> your new sudmac driver, which would then become a separate file. I'd have 
> to think a bit, what's the best way to do this: either
> 
> 1. keep the main part of the driver with the logic as now, extracting 
> hardware-specific parts in a separate file and linking respective 
> functions to the main module via function pointers in an operations 
> struct, or
> 
> 2. extract only the most essential and complicated logic functions into a 
> helper library and use it for both shdma and sudmac drivers.
> 
> What do you think? I'd need some time to think about this and come up with 
> a patch.

Umm, at the moment, I cannot judge which is good. I also need more time...

Best regards,
Yoshihiro Shimoda

> Thanks
> Guennadi
