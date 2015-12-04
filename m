From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 04 Dec 2015 15:33:51 +0000
Subject: [PATCH v2 0/2] gpio: rcar: Miscellaneous updates
Message-Id: <1449243233-11089-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Linus, Alex,

Here are two updates for the Renesas R-Car GPIO driver.
I combined them in one series, as the second patch depends on the first.

Thanks for applying!

Geert Uytterhoeven (2):
  gpio: rcar: Remove obsolete platform data support
  gpio: rcar: Improve clock error handling and reporting

 drivers/gpio/gpio-rcar.c                | 88 ++++++++++++++-------------------
 include/linux/platform_data/gpio-rcar.h | 29 -----------
 2 files changed, 36 insertions(+), 81 deletions(-)
 delete mode 100644 include/linux/platform_data/gpio-rcar.h

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
