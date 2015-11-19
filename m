From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 19 Nov 2015 18:30:25 +0000
Subject: [PATCH 0/2] pinctrl: sh-pfc: r8a7791/r8a7795: Add SCIF_CLK support
Message-Id: <1447957827-32637-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Linus, Laurent,

This patch series add pins, groups, and a function for SCIF_CLK on R-Car
M2 and R-Car H3. SCIF_CLK is the external clock source for the Baud Rate
Generator for External Clock (BRG) on (H)SCIF.

Geert Uytterhoeven (2):
  pinctrl: sh-pfc: r8a7791: Add SCIF_CLK support
  pinctrl: sh-pfc: r8a7795: Add SCIF_CLK support

 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 25 +++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 24 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
