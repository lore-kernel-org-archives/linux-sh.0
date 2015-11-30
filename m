From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 30 Nov 2015 13:41:01 +0000
Subject: [PATCH 0/4] pinctrl: sh-pfc: More PINMUX_SINGLE() conversions
Message-Id: <1448890865-1856-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Laurent, Linus,

This patch series converts pin control data for a few more Renesas SoCs
to the recently-introduced PINMUX_SINGLE() macro.
As such this series depends on "[PATCH/RFC 0/4] pinctrl: sh-pfc: Add
PINMUX_SINGLE()".

Thanks!

Geert Uytterhoeven (4):
  pinctrl: sh-pfc: emev2: Use PINMUX_SINGLE() instead of raw
    PINMUX_DATA()
  pinctrl: sh-pfc: r8a7778: Use PINMUX_SINGLE() instead of raw
    PINMUX_DATA()
  pinctrl: sh-pfc: r8a7779: Use PINMUX_SINGLE() instead of raw
    PINMUX_DATA()
  pinctrl: sh-pfc: sh7734: Use PINMUX_SINGLE() instead of raw
    PINMUX_DATA()

 drivers/pinctrl/sh-pfc/pfc-emev2.c   | 134 +++++++++++++++++------------------
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |  22 +++---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |  16 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7734.c  |  21 +++---
 4 files changed, 98 insertions(+), 95 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
