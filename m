From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 18 Mar 2015 18:41:06 +0000
Subject: [PATCH 0/3] gpio: rcar: Fix wake up using gpio-keys with PM domain
Message-Id: <1426704069-26389-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi,

This patch series contains a few cleanups and updates for the Renesas
R-Car GPIO driver, and fixes wake-up from s2ram using gpio-keys when
using a PM Domain to manage the module clock.

It was tested on r8a7791/koelsch.

Thanks!

Geert Uytterhoeven (3):
  gpio: rcar: Use local variable gpio_chip in gpio_rcar_probe()
  gpio: rcar: Add more register documentation
  gpio: rcar: Prevent module clock disable when wake-up is enabled

 drivers/gpio/gpio-rcar.c | 63 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 17 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
