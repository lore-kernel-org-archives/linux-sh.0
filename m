From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 17 Nov 2014 01:06:04 +0000
Subject: Re: [PATCH] gpio-rcar: .irq_set_wake() support to work with suspend_device_irqs()
Message-Id: <CANqRtoTKKuKnfFN4VYhnt1M8jb-2o+PTaivQvu3ELR32c9DhHQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415352165-26597-1-git-send-email-ykaneko0929@gmail.com>
	<CACRpkdaUxtB1zrvH3B=P6+Vis-KEts50h8U=nOgTpDwp5wNKQQ@mail.gmail.com>
In-Reply-To: <CACRpkdaUxtB1zrvH3B=P6+Vis-KEts50h8U=nOgTpDwp5wNKQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

Hi Linus, Kaneko-san,

On Fri, Nov 14, 2014 at 6:53 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Nov 7, 2014 at 10:22 AM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
>
>> From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>>
>> All IRQs in the kernel get disabled by PM core prior to .suspend_noirq()
>> step through kernel/irq/pm.c::suspend_device_irqs().
>>
>> The SYSC hardware block in the R-Car SoCs, on the other hand, uses any
>> interrupt as wake-up source(es) and requires them to be unmasked during
>> the system is suspended.
>>
>> This patch implements .irq_set_wake() which makes __disable_irq() call
>> a NOP when a GPIO port is claimed as a wake-up source.
>>
>> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>
> Patch tentatively applied unless Magnus or Laurent starts complaining...

I'll bite. =)

Thanks for the efforts, but I doubt that this patch is needed. Unless
I'm mistaken this feature is implemented already in the following
commits:

4039611 gpio: rcar: Enable mask on suspend
fba968a gpio: rcar: Use lazy disable

> This driver should be simple to convert to GPIOLIB_IRQCHIP and get
> rid of some code overhead.

Perhaps Geert [CC:ed] can have a look at this in the not so distant future?

Thanks,

/ magnus
