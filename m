From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 08 Sep 2015 19:36:21 +0000
Subject: Re: [PATCH 1/2] irqchip: renesas-intc-irqpin: Propagate wake-up settings to parent
Message-Id: <CAMuHMdVU+ghBGxEw0qrZ611PwO1n808vcBXPEUxemGyJXS1Mjg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441731636-17610-1-git-send-email-geert+renesas@glider.be>
	<1441731636-17610-2-git-send-email-geert+renesas@glider.be>
	<alpine.DEB.2.11.1509082104330.3854@nanos>
In-Reply-To: <alpine.DEB.2.11.1509082104330.3854@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>

Hi Thomas,

On Tue, Sep 8, 2015 at 9:05 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 8 Sep 2015, Geert Uytterhoeven wrote:
>> The renesas-intc-irqpin interrupt controller is cascaded to the GIC, but
>> its driver doesn't propagate wake-up settings to the parent interrupt
>> controller.
>>
>> Since commit aec89ef72ba6c944 ("irqchip/gic: Enable SKIP_SET_WAKE and
>> MASK_ON_SUSPEND"), the GIC driver masks interrupts during suspend, and
>> wake-up through gpio-keys now fails on r8a7740/armadillo and
>> sh73a0/kzm9g.
>>
>> Fix this by propagating wake-up settings to the parent interrupt
>> controller. There's no need to handle irq_set_irq_wake() failures, as
>> the renesas-intc-irqpin interrupt controller is always cascaded to a
>> GIC, and the GIC driver always sets SKIP_SET_WAKE since the
>> aforementioned commit.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/irqchip/irq-renesas-intc-irqpin.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
>> index 0670ab4e3897bf61..457d22c09e352d56 100644
>> --- a/drivers/irqchip/irq-renesas-intc-irqpin.c
>> +++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
>> @@ -283,6 +283,9 @@ static int intc_irqpin_irq_set_type(struct irq_data *d, unsigned int type)
>>  static int intc_irqpin_irq_set_wake(struct irq_data *d, unsigned int on)
>>  {
>>       struct intc_irqpin_priv *p = irq_data_get_irq_chip_data(d);
>> +     int hw_irq = irqd_to_hwirq(d);
>> +
>> +     irq_set_irq_wake(p->irq[hw_irq].requested_irq, on);
>
> Are you sure that this does not make lockdep unhappy due to lock
> nesting?

Actually I did see one lockdep warning, so I'm aware we're probably gonna
need a similar solution like commit a0a8bcf4670c2c69 ("gpiolib: irqchip:
use different lockdep class for each gpio irqchip")?

To be honest, these lockdep warnings aren't helping much here: on embedded
we typical have several stacked interrupt controllers, so wake-up settings
have to propagate from the bottom to the top of the stack.

E.g. on sh73a0/kzm9g gpio-keys wake-up goes through 3 interrupt controllers:
pcf875x -> renesas-intc-irqpin -> gic.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
