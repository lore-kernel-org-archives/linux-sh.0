From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jun 2016 10:05:00 +0000
Subject: [PATCH 0/3] pinctrl: sh-pfc: Cleanups
Message-Id: <1465553103-6345-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Laxman Dewangan <ldewangan@nvidia.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi,

This series contains various cleanups for the Renesas Pin Function
Controller driver subsystem.

This has been tested on r8a7791/koelsch, and compile-tested for other
ARM and SH platforms.

I plan to queue this in sh-pfc-for-v4.8.

Thanks for your comments!

Geert Uytterhoeven (3):
  pinctrl: sh-pfc: Move SoC-specific forward declarations to sh_pfc.h
  pinctrl: sh-pfc: Improve core and user separation
  pinctrl: sh-pfc: Convert to devm_gpiochip_add_data()

 drivers/pinctrl/sh-pfc/core.c        | 10 -------
 drivers/pinctrl/sh-pfc/core.h        | 58 ------------------------------------
 drivers/pinctrl/sh-pfc/gpio.c        | 13 +-------
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |  2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  1 -
 drivers/pinctrl/sh-pfc/sh_pfc.h      | 51 ++++++++++++++++++++++++++++++-
 9 files changed, 52 insertions(+), 86 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
