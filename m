From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 10 Jan 2012 00:47:55 +0000
Subject: Re: [RFC][PATCH 1/3] dmaengine: shdma: add .no_error_irq flag
Message-Id: <4F0B8ABB.9060009@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0537F2.4080306@renesas.com>
In-Reply-To: <4F0537F2.4080306@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2012/01/09 11:00, Paul Mundt wrote:
> On Fri, Jan 06, 2012 at 01:00:25PM +0900, Shimoda, Yoshihiro wrote:
>> -------
>> Subject: [PATCH] dmaengine: shdma: modify the DMAC Address Error registration
>>
>> The USB-DMAC/SUDMAC don't have the interrupt of DMAC Address Error.
>> So, only when the resource has a name and it is "error_irq", the driver
>> calls request_irq() for DMAC Address Error.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> If we're going to do this it would be nice to adopt the same behaviour
> for the generic DMAE IRQ, too (then we can finally get rid of those silly
> CPU_SH4 || ARCH_SHMOBILE ifdefs).
> 
> This approach looks like an improvement to me at least.
> 

Thank you very much for your comment.
I will get rid of the "CPU_SH4 || ARCH_SHMOBILE" ifdefs.

Best regards,
Yoshihiro Shimoda
