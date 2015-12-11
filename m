From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 11 Dec 2015 13:48:55 +0000
Subject: [PATCH 0/3] pinctrl: sh-pfc: r8a7779/r8a7790/r8a7794: Add SCIF_CLK support
Message-Id: <1449841738-17490-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Linus, Laurent,

This patch series add pins, groups, and a function for SCIF_CLK on R-Car
SoCs that don't have that support yet (H1, H2, and E2). SCIF_CLK is the
external clock source for the Baud Rate Generator for External Clock
(BRG) on (H)SCIF.

Geert Uytterhoeven (3):
  pinctrl: sh-pfc: r8a7779: Add SCIF_CLK support
  pinctrl: sh-pfc: r8a7790: Add SCIF_CLK support
  pinctrl: sh-pfc: r8a7794: Add SCIF_CLK support

 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 41 ++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 23 ++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 23 ++++++++++++++++++++
 3 files changed, 87 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
