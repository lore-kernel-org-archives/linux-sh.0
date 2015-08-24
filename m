From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 24 Aug 2015 16:12:12 +0000
Subject: [PATCH 0/3] arm64: renesas: r8a7795 clock updates
Message-Id: <1440432735-9906-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series adds the CPG/MSTP clock domain, and all clocks
generated from PLL1 by the CPG common divider block.

Geert Uytterhoeven (3):
  clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support
  arm64: renesas: r8a7795 dtsi: Add CPG/MSTP Clock Domain
  arm64: renesas: r8a7795 dtsi: Add all common divider clocks

 .../clock/renesas,rcar-gen3-cpg-clocks.txt         |  26 +++-
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 162 ++++++++++++++++++++-
 drivers/clk/shmobile/clk-rcar-gen3.c               |   2 +
 4 files changed, 188 insertions(+), 3 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
