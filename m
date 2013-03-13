From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Mar 2013 17:20:32 +0000
Subject: Re: [PATCH] gpio: Renesas R-Car GPIO driver
Message-Id: <CACRpkdbTXoB_zf1axVaM89Uoxa-vXWwgEHv9nWU-jbo_P1pioA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130305003219.14792.13300.sendpatchset@w520>
In-Reply-To: <20130305003219.14792.13300.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, horms@verge.net.au, linux-sh@vger.kernel.org

On Tue, Mar 5, 2013 at 1:32 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> +static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +       struct gpio_rcar_priv *p = irq_data_get_irq_chip_data(d);
> +       unsigned int hwirq = irqd_to_hwirq(d);
> +
> +       pr_debug("gpio: sense irq = %d, type = %d\n", hwirq, type);
> +
> +       switch (type & IRQ_TYPE_SENSE_MASK) {
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               gpio_rcar_config_interrupt_input_mode(p, hwirq, true, true);
> +               break;
> +       case IRQ_TYPE_LEVEL_LOW:
> +               gpio_rcar_config_interrupt_input_mode(p, hwirq, false, true);
> +               break;
> +       case IRQ_TYPE_EDGE_RISING:
> +               gpio_rcar_config_interrupt_input_mode(p, hwirq, true, false);
> +               break;
> +       case IRQ_TYPE_EDGE_FALLING:
> +               gpio_rcar_config_interrupt_input_mode(p, hwirq, false, false);
> +               break;

It is quite common to request IRQ on *both* rising and falling edges,
what happens then?

See <linux/irqs.h>
        IRQ_TYPE_EDGE_RISING    = 0x00000001,
        IRQ_TYPE_EDGE_FALLING   = 0x00000002,
        IRQ_TYPE_EDGE_BOTH      = (IRQ_TYPE_EDGE_FALLING |
IRQ_TYPE_EDGE_RISING),

I guess then you get just rising edge...


> +       default:
> +               return -EINVAL;
> +       }
> +       return 0;
> +}

(...)

The rest I think is already covered by Laurent's comments.

Yours,
Linus Walleij
