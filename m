From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 12 May 2015 07:55:47 +0000
Subject: Re: [PATCH] gpio: rcar: Check for irq_set_irq_wake() failures
Message-Id: <CACRpkdaDEr7Lw8u5tAC-som5W-WM4-Wfqena4Ftd4KFdEA2-Yg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430748592-6394-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430748592-6394-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, hisashi.nakamura.ak@renesas.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Valentine <valentine.barshak@cogentembedded.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, Axel Haslam <ahaslam@baylibre.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, May 4, 2015 at 4:09 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> If an interrupt controller doesn't support wake-up configuration, trying
> to deconfigure wake-up will cause a warning:
>
>     WARNING: CPU: 1 PID: 1341 at kernel/irq/manage.c:540 irq_set_irq_wake+0x9c/0xf8()
>     Unbalanced IRQ 26 wake disable
>
> To fix this, refrain from any further parent interrupt controller
> (de)configuration if irq_set_irq_wake() failed.
>
> Fixes: ab82fa7da4dce5c7 ("gpio: rcar: Prevent module clock disable when wake-up is enabled")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is an alternative for:
>   - calling "gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE)" from the
>     platform code, OR
>   - setting "gic_chip.flags = IRQCHIP_SKIP_SET_WAKE" in the GIC driver
>     code.

This should be moved to the commit message I think.

> -       irq_set_irq_wake(p->irq_parent, on);
> +       int error;
> +
> +       if (p->irq_parent) {
> +               error = irq_set_irq_wake(p->irq_parent, on);
> +               if (error) {
> +                       dev_dbg(&p->pdev->dev,
> +                               "irq %u doesn't support irq_set_wake\n",
> +                               p->irq_parent);
> +                       p->irq_parent = 0;
> +               }
> +       }

Does the SH maintainers really like this... Warning
appear once and is squelched.

Isn't it better to make sure it doesn't happen or something.

It looks hacky. Any other suggestions?

Also, please convert this driver to use GPIOLIB_IRQCHIP
like everyone else.

Yours,
Linus Walleij
