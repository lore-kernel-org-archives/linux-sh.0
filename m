From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Nov 2014 12:05:24 +0000
Subject: Re: [PATCH] gpio-rcar: .irq_set_wake() support to work with suspend_device_irqs()
Message-Id: <CAMuHMdUFPVBDbvaMNdPNGG-a9i1d8dAEK5WsREX40iSGVJk8+w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415352165-26597-1-git-send-email-ykaneko0929@gmail.com>
	<CACRpkdaUxtB1zrvH3B=P6+Vis-KEts50h8U=nOgTpDwp5wNKQQ@mail.gmail.com>
	<CANqRtoTKKuKnfFN4VYhnt1M8jb-2o+PTaivQvu3ELR32c9DhHQ@mail.gmail.com>
In-Reply-To: <CANqRtoTKKuKnfFN4VYhnt1M8jb-2o+PTaivQvu3ELR32c9DhHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

Hi Magnus, Kaneko-san,

On Mon, Nov 17, 2014 at 2:06 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Fri, Nov 14, 2014 at 6:53 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Fri, Nov 7, 2014 at 10:22 AM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>>> From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>>>
>>> All IRQs in the kernel get disabled by PM core prior to .suspend_noirq()
>>> step through kernel/irq/pm.c::suspend_device_irqs().
>>>
>>> The SYSC hardware block in the R-Car SoCs, on the other hand, uses any
>>> interrupt as wake-up source(es) and requires them to be unmasked during
>>> the system is suspended.
>>>
>>> This patch implements .irq_set_wake() which makes __disable_irq() call
>>> a NOP when a GPIO port is claimed as a wake-up source.
>>>
>>> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>>> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>>
>> Patch tentatively applied unless Magnus or Laurent starts complaining...
>
> I'll bite. =)
>
> Thanks for the efforts, but I doubt that this patch is needed. Unless
> I'm mistaken this feature is implemented already in the following
> commits:
>
> 4039611 gpio: rcar: Enable mask on suspend
> fba968a gpio: rcar: Use lazy disable

Good to see you (as the author of the driver and those two fixes) have some
reservations. I also had my doubts about this patch, but I didn't get to
testing it earlier...

I can confirm resume from s2ram works without and with this patch.
So unless this patch is meant to fix something else (is it?), I think it can be
dropped.

>> This driver should be simple to convert to GPIOLIB_IRQCHIP and get
>> rid of some code overhead.
>
> Perhaps Geert [CC:ed] can have a look at this in the not so distant future?

Sure. Will do.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
