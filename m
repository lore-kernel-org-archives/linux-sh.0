From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 04 Mar 2015 12:51:21 +0000
Subject: Re: [PATCH 2/2] gpio: pcf857x: Propagate wake-up setting to parent irq controller
Message-Id: <CACRpkdbv_Z=VBNniS=5oqzQnRg85e7g19AZ3wm5vzyuk=2WqHw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423151349-10579-1-git-send-email-geert+renesas@glider.be>
	<1423151349-10579-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1423151349-10579-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alexandre Courbot <gnurou@gmail.com>, George Cherian <george.cherian@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Feb 5, 2015 at 4:49 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The pcf857x GPIO and interrupt controller uses dummy_irq_chip, which
> does not implement irq_chip.irq_set_wake() and does not set
> IRQCHIP_SKIP_SET_WAKE.
>
> This causes two s2ram issues if wake-up is enabled for the pcf857x GPIO
> pins:
>   1. During resume from s2ram, the following warning is printed:
>
>      WARNING: CPU: 0 PID: 1046 at kernel/irq/manage.c:537 irq_set_irq_wake+0x9c/0xf8()
>      Unbalanced IRQ 113 wake disable
>
>   2. Wake-up through the pcf857x GPIO pins may fail, as the parent
>      interrupt controller may be suspended.
>
> Migrate the pcf857x GPIO and interrupt controller from dummy_irq_chip to
> its own irq_chip. This irq chip implements irq_chip.irq_set_wake() to
> propagate its wake-up setting to the parent interrupt controller.
>
> This fixes wake-up through gpio-keys on sh73a0/kzm9g, where the pcf857x
> interrupt is cascaded to irq-renesas-intc-irqpin, and the latter must
> not be suspended when wake-up is enabled.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Rebased on top of "gpio: pcf857x: Switch to use gpiolib irqchip
>     helpers".

Patch applied.

Yours,
Linus Walleij
