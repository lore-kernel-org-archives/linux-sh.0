From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 May 2015 08:07:54 +0000
Subject: Re: [PATCH] gpio: rcar: Check for irq_set_irq_wake() failures
Message-Id: <CAMuHMdX2zaRhZh20e-TMkMeES6Ftaez1vcdcnAimVczW6L7gsQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430748592-6394-1-git-send-email-geert+renesas@glider.be>
	<CACRpkdaDEr7Lw8u5tAC-som5W-WM4-Wfqena4Ftd4KFdEA2-Yg@mail.gmail.com>
In-Reply-To: <CACRpkdaDEr7Lw8u5tAC-som5W-WM4-Wfqena4Ftd4KFdEA2-Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Valentine <valentine.barshak@cogentembedded.com>, Magnus Damm <magnus.damm@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, Axel Haslam <ahaslam@baylibre.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, May 12, 2015 at 9:55 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, May 4, 2015 at 4:09 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> If an interrupt controller doesn't support wake-up configuration, trying
>> to deconfigure wake-up will cause a warning:
>>
>>     WARNING: CPU: 1 PID: 1341 at kernel/irq/manage.c:540 irq_set_irq_wake+0x9c/0xf8()
>>     Unbalanced IRQ 26 wake disable
>>
>> To fix this, refrain from any further parent interrupt controller
>> (de)configuration if irq_set_irq_wake() failed.
>>
>> Fixes: ab82fa7da4dce5c7 ("gpio: rcar: Prevent module clock disable when wake-up is enabled")
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> This is an alternative for:
>>   - calling "gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE)" from the
>>     platform code, OR

Which is hacky, considering the below.

>>   - setting "gic_chip.flags = IRQCHIP_SKIP_SET_WAKE" in the GIC driver
>>     code.

Which was rejected by Marc, as the hardware doesn't support it.

> This should be moved to the commit message I think.

So that's why I put it below the "---".

>> -       irq_set_irq_wake(p->irq_parent, on);
>> +       int error;
>> +
>> +       if (p->irq_parent) {
>> +               error = irq_set_irq_wake(p->irq_parent, on);
>> +               if (error) {
>> +                       dev_dbg(&p->pdev->dev,
>> +                               "irq %u doesn't support irq_set_wake\n",
>> +                               p->irq_parent);
>> +                       p->irq_parent = 0;
>> +               }
>> +       }
>
> Does the SH maintainers really like this... Warning
> appear once and is squelched.
>
> Isn't it better to make sure it doesn't happen or something.
>
> It looks hacky. Any other suggestions?

The first call to irq_set_irq_wake() (on = true) doesn't print a warning.
It returns an error code, to indicate that the operation is not supported.

Calling irq_set_irq_wake() again (on = false, during resume) would print
a warning, as it wouldn't match internal state ("Unbalanced IRQ 26 wake
disable"). That one is gone now.

> Also, please convert this driver to use GPIOLIB_IRQCHIP
> like everyone else.

What old branch are you looking at, that it doesn't have commit
c7f3c5d3ac2d6831 ("gpio: rcar: Switch to use gpiolib irqchip helpers")
yet ;-)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
