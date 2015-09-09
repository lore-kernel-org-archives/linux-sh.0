From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Wed, 09 Sep 2015 08:43:06 +0000
Subject: Re: [PATCH 1/2] irqchip: renesas-intc-irqpin: Propagate wake-up settings to parent
Message-Id: <55EFF11A.1050400@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441731636-17610-1-git-send-email-geert+renesas@glider.be>
 <1441731636-17610-2-git-send-email-geert+renesas@glider.be>
 <alpine.DEB.2.11.1509082104330.3854@nanos>
 <CAMuHMdVU+ghBGxEw0qrZ611PwO1n808vcBXPEUxemGyJXS1Mjg@mail.gmail.com>
 <alpine.DEB.2.11.1509082149250.3854@nanos>
In-Reply-To: <alpine.DEB.2.11.1509082149250.3854@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Jason Cooper <jason@lakedaemon.net>, Sudeep Holla <sudeep.holla@arm.com>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On 09/08/2015 11:03 PM, Thomas Gleixner wrote:
> On Tue, 8 Sep 2015, Geert Uytterhoeven wrote:
>>>> --- a/drivers/irqchip/irq-renesas-intc-irqpin.c
>>>> +++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
>>>> @@ -283,6 +283,9 @@ static int intc_irqpin_irq_set_type(struct irq_data *d, unsigned int type)
>>>>   static int intc_irqpin_irq_set_wake(struct irq_data *d, unsigned int on)
>>>>   {
>>>>        struct intc_irqpin_priv *p = irq_data_get_irq_chip_data(d);
>>>> +     int hw_irq = irqd_to_hwirq(d);
>>>> +
>>>> +     irq_set_irq_wake(p->irq[hw_irq].requested_irq, on);
>>>
>>> Are you sure that this does not make lockdep unhappy due to lock
>>> nesting?
>>
>> Actually I did see one lockdep warning, so I'm aware we're probably gonna
>> need a similar solution like commit a0a8bcf4670c2c69 ("gpiolib: irqchip:
>> use different lockdep class for each gpio irqchip")?
>>
>> To be honest, these lockdep warnings aren't helping much here: on embedded
>> we typical have several stacked interrupt controllers, so wake-up settings
>> have to propagate from the bottom to the top of the stack.
> 
> But ignoring them does not help much either, right?
>   
>> E.g. on sh73a0/kzm9g gpio-keys wake-up goes through 3 interrupt controllers:
>> pcf875x -> renesas-intc-irqpin -> gic.
> 
> So, yes a seperate locking class for that intc trainwreck is probably
> required.
> 

Just as an option, May be we can proceed with patch:
[PATCH v2 2/6] genirq: fix irqchip_set_wake_parent if IRQCHIP_SKIP_SET_WAKE
http://www.spinics.net/lists/linux-omap/msg121262.html

As result, irq_chip_set_wake_parent() can be used here and no lockdep issues.

Marc, what do you think? renesas-intc-irqpin has own .irq_set_wake()
implementation and IRQCHIP_SKIP_SET_WAKE can't be used here as W/A.


-- 
regards,
-grygorii
