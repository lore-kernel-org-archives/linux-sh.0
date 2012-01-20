From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 20 Jan 2012 02:07:01 +0000
Subject: Re: [PATCH v4 6/6] dmaengine: shdma: add support for SUDMAC
Message-Id: <4F18CC45.2070600@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0D3A10.7000708@renesas.com>
In-Reply-To: <4F0D3A10.7000708@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Guennadi-san,

2012/01/20 1:48, Guennadi Liakhovetski wrote:
> Hello Shimoda-san
> 
> On Fri, 13 Jan 2012, Shimoda, Yoshihiro wrote:
> 
>> Hello Guennadi-san,
>>
>> Thank you very much for your comment!
>>
>> 2012/01/13 1:29, Guennadi Liakhovetski wrote:
> 
> [snip]
> 
>>> What do you think? I'd need some time to think about this and come up with 
>>> a patch.
>>
>> Umm, at the moment, I cannot judge which is good. I also need more time...
> 
> You probably have seen my yesterday's patches
> 
> http://thread.gmane.org/gmane.linux.alsa.devel/93681

Thank you very much for the patches!

> What I'd like to ask you in this respect: do you have an idea, when you 
> would have time to try to implement your SUDMAC driver on top of that 
> series? Would be good to know whether any further changes to the "Simple 
> dmaengine driver" are required.

I will study the dma-simple driver, and I will implement the SUDMAC driver
using this.

By the way, when I applied the "dma: shdma: convert to the simple DMA library" patch,
I couldn't apply it. (Many "Hunk #nn FAILED" output...)
So, would you tell me your using kernel commit?
I used today's "torbalds/linux.git" and "slave-dma.git".

Best regards,
Yoshihiro Shimoda

> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 


-- 
Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
EC No.
