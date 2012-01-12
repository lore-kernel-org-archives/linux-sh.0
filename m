From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 12 Jan 2012 01:09:11 +0000
Subject: Re: [PATCH v4 2/6] sh: add a resource name for shdma
Message-Id: <4F0E32B7.7060902@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0D39F5.90208@renesas.com>
In-Reply-To: <4F0D39F5.90208@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2012/01/11 18:05, Guennadi Liakhovetski wrote:
> Unrelated to your patch, just something that caught my eye:
> 
[ snip ]
> 
> The above two platforms seem incorrect. Back then, as I switched sh_dma.c 
> to use resources for interrupts [1], I just reproduced the behaviour of 
> the original driver, but a verification with the header or the datasheet 
> shows, that sh7780 and sh7785 have separate interrupts per channel, so, if 
> anyone cares about those platforms, they might need a fix.

The interrupts of SH7780 DMAC and Sh7785 DMAC are strange.
Would you check the commit bdaa6e8062 "sh: multiple vectors per irq - base"?

 - The SH7780 and SH7785 have separate INTEVT per channel, but the INT2MSKR
   for the DMAC has one bit.
 -- In this case, the commit log says:
    "If multiple vectors shar the same enum then only the
     first vector will be avilable as a linux irq."

 - I think that the DMTE4_IRQ of SH7780 and SH7785 in
   the "arch/sh/include/cpu-sh4/cpu/dma-sh4a.h" is breaking.
   But, the old DMA API driver doesn't use this actually because the get_dmte_irq()
   in dma-sh.c will change the IRQ number...

Best regards,
Yoshihiro Shimoda

> Thanks
> Guennadi
> 
> [1] http://thread.gmane.org/gmane.linux.ports.sh.devel/7269/focusr70
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 


-- 
Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
EC No.
