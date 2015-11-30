From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 30 Nov 2015 13:59:53 +0000
Subject: [PATCH 0/3] pinctrl: sh-pfc: Correct pin range comments
Message-Id: <1448891996-5263-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Laurent, Linus,

This patch series corrects a few pin range comments in the Renesas
pinctrl data. No functional changes.

Thanks!

Geert Uytterhoeven (3):
  pinctrl: sh-pfc: emev2: Correct comment for CFI data pins
  pinctrl: sh-pfc: r8a7740: Correct comment for LCD1 data pins
  pinctrl: sh-pfc: sh73a0: Correct comment for LCD2 data pins

 drivers/pinctrl/sh-pfc/pfc-emev2.c   | 2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
