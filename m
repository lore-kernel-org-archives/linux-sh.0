From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 06 Aug 2015 13:33:07 +0000
Subject: [PATCH/RFC 0/2] arm64: renesas: r8a7795: Add CPG/MSTP Clock Domain
Message-Id: <1438867989-4942-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi all,

This RFC patch series adds Clock Domain support to the Clock Pulse
Generator (CPG) Module Stop (MSTP) Clocks driver using the generic PM
Domain on R-Car Gen3 (r8a7795), cfr. 32-bit shmobile ARM SoCs.

It is based on "[PATCH 00/13 v4][RFC] arm64: Renesas Gen3 initial
patch".

Compile-tested only.

Geert Uytterhoeven (2):
  clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support
  ARM: shmobile: r8a7795 dtsi: Add CPG/MSTP Clock Domain

 .../clock/renesas,rcar-gen3-cpg-clocks.txt         | 26 ++++++++++++++++++++--
 arch/arm64/Kconfig.platforms                       |  1 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  2 ++
 drivers/clk/shmobile/clk-rcar-gen3.c               |  2 ++
 4 files changed, 29 insertions(+), 2 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
