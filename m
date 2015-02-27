From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 27 Feb 2015 17:38:01 +0000
Subject: [PATCH 0/4] pinctrl: sh-pfc: Fix pin bias and cleanups
Message-Id: <1425058685-12956-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi,

This patch series fixes bias (pull up/down) for Renesas R-Mobile and
SH-Mobile SoCs, and does some code (type) cleanups.

  - Patch 1 fixes the overwriting of the bias field in the port control
    register when configuring a pin for GPIO,
  - Patch 2 changes the types used for storing register and field widths
    in the pinctrl data tables, shrinking them by an average of ca. 4
    KiB per SoC,
  - Patches 3 and 4 do some more cleanups w.r.t. the choice of types.

Bias pull up/down was tested on r8a73a4/ape6evm, which requires a
pull-up bias for the GPIO switches.

Boot-tested on r8a7740/armadillo, r8a7791/koelsch, and sh73a0/kzm9g.

Thanks for your comments!

Geert Uytterhoeven (4):
  pinctrl: sh-pfc: Do not overwrite bias configuration
  pinctrl: sh-pfc: Store register/field widths in u8 instead of unsigned
    long
  pinctrl: sh-pfc: Use u32 to store register data
  pinctrl: sh-pfc: Use unsigned int for register/field widths and
    offsets

 drivers/pinctrl/sh-pfc/core.c   | 36 ++++++++++++++++++------------------
 drivers/pinctrl/sh-pfc/core.h   |  7 +++----
 drivers/pinctrl/sh-pfc/gpio.c   | 19 ++++++++-----------
 drivers/pinctrl/sh-pfc/sh_pfc.h | 35 +++++++++++++++++++----------------
 4 files changed, 48 insertions(+), 49 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
