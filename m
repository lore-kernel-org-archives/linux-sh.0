From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Nov 2014 14:01:59 +0000
Subject: Re: [PATCH] gpio-rcar: .irq_set_wake() support to work with suspend_device_irqs()
Message-Id: <CACRpkdZAmrKkWNOyeV+7h+NshQzbBacwi_ticGdLB6Lj12i4ng@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415352165-26597-1-git-send-email-ykaneko0929@gmail.com>
	<CACRpkdaUxtB1zrvH3B=P6+Vis-KEts50h8U=nOgTpDwp5wNKQQ@mail.gmail.com>
	<CANqRtoTKKuKnfFN4VYhnt1M8jb-2o+PTaivQvu3ELR32c9DhHQ@mail.gmail.com>
	<CAMuHMdUFPVBDbvaMNdPNGG-a9i1d8dAEK5WsREX40iSGVJk8+w@mail.gmail.com>
In-Reply-To: <CAMuHMdUFPVBDbvaMNdPNGG-a9i1d8dAEK5WsREX40iSGVJk8+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On Mon, Nov 17, 2014 at 1:05 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> I can confirm resume from s2ram works without and with this patch.
> So unless this patch is meant to fix something else (is it?), I think it can be
> dropped.

OK patch is dropped from my queue.

>>> This driver should be simple to convert to GPIOLIB_IRQCHIP and get
>>> rid of some code overhead.
>>
>> Perhaps Geert [CC:ed] can have a look at this in the not so distant future?
>
> Sure. Will do.

THANKS!

Yours,
Linus Walleij
