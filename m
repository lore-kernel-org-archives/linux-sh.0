From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 12 Jan 2015 10:07:57 +0000
Subject: [PATCH 0/2] gpio: rcar: Convert to use gpiolib irqchip
Message-Id: <1421057279-16081-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Linus, Alexandre,

This patch series converts the Renesas R-Car Gen2 GPIO driver to use the
gpiolib irqchip helpers.

It was tested on r8a7791/koelsch.

Thanks!

Geert Uytterhoeven (2):
  gpio: rcar: Fix error path for devm_kzalloc() failure
  gpio: rcar: Switch to use gpiolib irqchip helpers

 drivers/gpio/Kconfig     |  1 +
 drivers/gpio/gpio-rcar.c | 75 ++++++++++++++++--------------------------------
 2 files changed, 26 insertions(+), 50 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
