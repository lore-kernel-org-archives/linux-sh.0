From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 26 Aug 2015 18:02:19 +0000
Subject: [PATCH 0/5] pinctrl: sh-pfc: r8a7795: (H)SCIF Updates
Message-Id: <1440612144-16877-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takeshi Kihara <takeshi.kihara.df@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi,

This series contains (H)SCIF-related updates for the R-Car H3 (r8a7795)
pin function controller driver:
  - Fixes and updates for SCIF pindata (incl. a DTS update),
  - Addition of HSCIF support.

This is against "[PATCH] pinctrl: sh-pfc: Add R8A7795 PFC support" and
the current state (sic) of the Salvator-X DTS.

Geert Uytterhoeven (5):
  pinctrl: sh-pfc: r8a7795: Fix and extend SCIF0 pin data
  pinctrl: sh-pfc: r8a7795: Extend SCIF2 pin data
  pinctrl: sh-pfc: r8a7795: Fix SCIF5 pin data
  pinctrl: sh-pfc: r8a7795: Add HSCIF pins, groups, and functions
  arm64: renesas: salvator-x: Update SCIF2 pin group

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c               | 296 ++++++++++++++++++++-
 2 files changed, 285 insertions(+), 13 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
