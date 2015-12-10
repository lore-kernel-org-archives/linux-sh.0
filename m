From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 10 Dec 2015 13:04:51 +0000
Subject: [git pull] pinctrl: sh-pfc: Updates for v4.5
Message-Id: <1449752691-30438-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1443774347-383-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1443774347-383-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Linus,

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git sh-pfc-for-v4.5

for you to fetch changes up to f27200f9dce59ce5063bf722ef6ccedd34e4357b:

  pinctrl: sh-pfc: r8a7795: Add SCIF_CLK support (2015-12-08 14:18:45 +0100)

Summary:
  - r8a7791: Add support for SCIF_CLK,
  - r8a7795: Add support for HSCIF, MSIOF, and SCIF_CLK,
  - sh73a0: Add support for MSIOF,
  - Assorted fixes, cleanups and consolidatons.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (19):
      pinctrl: sh-pfc: Add PINMUX_SINGLE()
      pinctrl: sh-pfc: r8a7790: Use PINMUX_SINGLE() instead of raw PINMUX_DATA()
      pinctrl: sh-pfc: r8a7791: Use PINMUX_SINGLE() instead of raw PINMUX_DATA()
      pinctrl: sh-pfc: r8a7794: Use PINMUX_SINGLE() instead of raw PINMUX_DATA()
      pinctrl: sh-pfc: r8a7795: Make PORT_GP_x() macros consistent
      pinctrl: sh-pfc: r8a7795: Rename SEL_SCIF to SEL_SATA
      pinctrl: sh-pfc: r8a7795: Add HSCIF pins, groups, and functions
      pinctrl: sh-pfc: emev2: Use PINMUX_SINGLE() instead of raw PINMUX_DATA()
      pinctrl: sh-pfc: r8a7778: Use PINMUX_SINGLE() instead of raw PINMUX_DATA()
      pinctrl: sh-pfc: r8a7779: Use PINMUX_SINGLE() instead of raw PINMUX_DATA()
      pinctrl: sh-pfc: sh7734: Use PINMUX_SINGLE() instead of raw PINMUX_DATA()
      pinctrl: sh-pfc: r8a7795: Add pinmux data for single-function pins
      pinctrl: sh-pfc: r8a7795: Add MSIOF pins, groups, and functions
      pinctrl: sh-pfc: emev2: Correct comment for CFI data pins
      pinctrl: sh-pfc: r8a7740: Correct comment for LCD1 data pins
      pinctrl: sh-pfc: sh73a0: Correct comment for LCD2 data pins
      pinctrl: sh-pfc: sh73a0: Add MSIOF support
      pinctrl: sh-pfc: r8a7791: Add SCIF_CLK support
      pinctrl: sh-pfc: r8a7795: Add SCIF_CLK support

Kuninori Morimoto (1):
      pinctrl: sh-pfc: Share/reuse same PORT_GP_x() macros

 drivers/pinctrl/sh-pfc/pfc-emev2.c   |  136 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |    2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   22 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |   21 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |   35 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |   74 ++-
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c |   63 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 1207 ++++++++++++++++++++++++++++++++--
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |  548 ++++++++++++++-
 drivers/pinctrl/sh-pfc/pfc-sh7734.c  |   29 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h      |   74 ++-
 11 files changed, 1949 insertions(+), 262 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
