From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 18 Dec 2015 13:48:31 +0000
Subject: [git pull] pinctrl: sh-pfc: Updates for v4.5 (take two)
Message-Id: <1450446511-7649-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1443774347-383-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1443774347-383-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Linus,

The following changes since commit f27200f9dce59ce5063bf722ef6ccedd34e4357b:

  pinctrl: sh-pfc: r8a7795: Add SCIF_CLK support (2015-12-08 14:18:45 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git sh-pfc-for-v4.5

for you to fetch changes up to 1a4ca6dd3dc8551fc0288ec76d046700366d7683:

  MAINTAINERS: Add co-maintainer for Renesas Pin Controllers (2015-12-17 10:41:23 +0100)

Summary:
  - r8a7779/r8a7790/r8a7794: Add support for SCIF_CLK,
  - r8a7791: Add support for EtherAVB,
  - r8a7795: Add support for SATA and SDHI,
  - Add myself as co-maintainer for Renesas Pin Controllers.

Thanks for pulling!

----------------------------------------------------------------
Geert Uytterhoeven (4):
      pinctrl: sh-pfc: r8a7779: Add SCIF_CLK support
      pinctrl: sh-pfc: r8a7790: Add SCIF_CLK support
      pinctrl: sh-pfc: r8a7794: Add SCIF_CLK support
      MAINTAINERS: Add co-maintainer for Renesas Pin Controllers

Sergei Shtylyov (1):
      pinctrl: sh-pfc: r8a7791: add EtherAVB pin groups

Takeshi Kihara (2):
      pinctrl: sh-pfc: r8a7795: Add SDHI support
      pinctrl: sh-pfc: r8a7795: Add SATA support

 MAINTAINERS                          |   1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |  41 +++++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  23 +++
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  93 +++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c |  23 +++
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 298 +++++++++++++++++++++++++++++++++++
 6 files changed, 479 insertions(+)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
