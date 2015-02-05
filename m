From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 05 Feb 2015 15:49:07 +0000
Subject: [PATCH 0/2] gpio: pcf857x: Use gpiolib irqchip helpers and fix wake-up
Message-Id: <1423151349-10579-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, George Cherian <george.cherian@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi,

This patch series switches the PCF857x GPIO driver to use the gpiolib
irqchip helpers, as requested by Linus Walleij, and fixes wake-up by
propagating the wake-up setting to the parent irq controller.

Note that the conversion to gpiolib irqchip helpers removes the checks
added in commit 21fd3cd1874a2ac8 ("gpio: pcf857x: call the gpio user
handler iff gpio_to_irq is done"), as the interrupt mappings are no
longer created on-demand by the driver, but by gpiochip_irqchip_add()
during initialization.  I marked the first patch "RFC" because of
this.  Does the removal of the checks cause problems for anyone?

The second patch was sent before, and rebased on top of the
conversion to gpiolib irqchip helpers.

This was tested on sh73a0/kzm9g, where I don't see the issue addressed
by commit 21fd3cd1874a2ac8 ("gpio: pcf857x: call the gpio user handler
iff gpio_to_irq is done").

Thanks for your comments!

Geert Uytterhoeven (2):
  [RFC] gpio: pcf857x: Switch to use gpiolib irqchip helpers
  gpio: pcf857x: Propagate wake-up setting to parent irq controller

 drivers/gpio/Kconfig        |   1 +
 drivers/gpio/gpio-pcf857x.c | 134 ++++++++++++++++----------------------------
 2 files changed, 50 insertions(+), 85 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
