From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 10 Jan 2012 06:19:21 +0000
Subject: Re: [PATCH v2 1/3] dmaengine: shdma: modify the DMAC Address Error
Message-Id: <4F0BD869.80302@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0BCA90.3050508@renesas.com>
In-Reply-To: <4F0BCA90.3050508@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2012/01/10 15:01, Paul Mundt wrote:
> On Tue, Jan 10, 2012 at 02:56:33PM +0900, Shimoda, Yoshihiro wrote:
>> 2012/01/10 14:33, Paul Mundt wrote:
>>> On Tue, Jan 10, 2012 at 02:20:16PM +0900, Shimoda, Yoshihiro wrote:
>>>> +		if (chanirq_res = errirq_res ||
>>>> +		    (errirq_res->flags & IORESOURCE_BITS) =
>>>> +		    IORESOURCE_IRQ_SHAREABLE)
>>>> +			irqflags = IRQF_SHARED;
>>>> +
>>> While not your fault, it seems that there are a few of these cases in
>>> which the irqflags are clobbered rather than added to. Is there some
>>> particular reason why we aren't doing |= IRQF_SHARED on top of the
>>> default IRQF_DISABLED case?
>>>
>>
>> I guess that old kernel (before the commit of 6932bf37 "genirq: Remove IRQF_DISABLED from
>> core code") output some warning in request_irq() when irqflags is set to
>> "IRQF_DISABLED | IRQF_SHARED".
>>
>> By the way, according to the "feature-removal-schedule.txt", the IRQF_DISABLED will remove.
>> So, we can remove the IRQF_DISABLED in the shdma driver, I think.
>>
> Yes, it's deprecated now, so there's no need to keep it around. The
> non-shared case can just be 0.
> 
OK, I will modify the patch and submit it again.

Best regards,
Yoshihiro Shimoda
