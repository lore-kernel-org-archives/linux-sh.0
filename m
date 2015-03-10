From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 10 Mar 2015 11:06:19 +0000
Subject: [PATCH v2 0/4] pinctrl: sh-pfc: cleanups
Message-Id: <1425985583-26279-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Linus, Laurent,

This patch series does some code (type) cleanups.

  - Patch 1 changes the types used for storing register and field widths
    in the pinctrl data tables, shrinking them by an average of ca. 4
    KiB per SoC,
  - Patches 3, 4, and 5 do some more cleanups w.r.t. the choice of types.

The first two patches have been sent before as part of the series
"[PATCH 0/4] pinctrl: sh-pfc: Fix pin bias and cleanups", and received
some rework according to review comments. The last two are new.

This series is against pinctrl/for-next.

Boot-tested on r8a73a4/ape6evm, r8a7740/armadillo, r8a7791/koelsch, and
sh73a0/kzm9g.

Geert Uytterhoeven (4):
  pinctrl: sh-pfc: Store register/field widths in u8 instead of unsigned
    long
  pinctrl: sh-pfc: Use unsigned int for register/field widths and
    offsets
  pinctrl: sh-pfc: Use reg_width instead of reg as sentinel
  pinctrl: sh-pfc: Use u32 to store register addresses

 drivers/pinctrl/sh-pfc/core.c   | 65 ++++++++++++++++++++---------------------
 drivers/pinctrl/sh-pfc/core.h   |  4 +--
 drivers/pinctrl/sh-pfc/gpio.c   | 18 +++++++-----
 drivers/pinctrl/sh-pfc/sh_pfc.h | 12 ++++----
 4 files changed, 52 insertions(+), 47 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
