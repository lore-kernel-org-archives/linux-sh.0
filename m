From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Feb 2015 10:41:03 +0000
Subject: Re: [PATCH 0/2] gpio: pcf857x: Use gpiolib irqchip helpers and fix wake-up
Message-Id: <CAMuHMdVsFqB-yyvDA_XZUScdPD7MbdzfPyFG5xgsH2y0csszqw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423151349-10579-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1423151349-10579-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, George Cherian <george.cherian@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Feb 5, 2015 at 4:49 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This patch series switches the PCF857x GPIO driver to use the gpiolib
> irqchip helpers, as requested by Linus Walleij, and fixes wake-up by
> propagating the wake-up setting to the parent irq controller.
>
> Note that the conversion to gpiolib irqchip helpers removes the checks
> added in commit 21fd3cd1874a2ac8 ("gpio: pcf857x: call the gpio user
> handler iff gpio_to_irq is done"), as the interrupt mappings are no
> longer created on-demand by the driver, but by gpiochip_irqchip_add()
> during initialization.  I marked the first patch "RFC" because of
> this.  Does the removal of the checks cause problems for anyone?
>
> The second patch was sent before, and rebased on top of the
> conversion to gpiolib irqchip helpers.
>
> This was tested on sh73a0/kzm9g, where I don't see the issue addressed
> by commit 21fd3cd1874a2ac8 ("gpio: pcf857x: call the gpio user handler
> iff gpio_to_irq is done").
>
> Thanks for your comments!

No comments?

> Geert Uytterhoeven (2):
>   [RFC] gpio: pcf857x: Switch to use gpiolib irqchip helpers
>   gpio: pcf857x: Propagate wake-up setting to parent irq controller
>
>  drivers/gpio/Kconfig        |   1 +
>  drivers/gpio/gpio-pcf857x.c | 134 ++++++++++++++++----------------------------
>  2 files changed, 50 insertions(+), 85 deletions(-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
