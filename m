From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 01 Sep 2015 15:12:35 +0000
Subject: [PATCH 0/6] arm64: renesas: Obtain MD pin values using syscon/regmap
Message-Id: <1441120361-1232-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Magnus, Simon,

This patch series converts the R-Car Gen3 Clock Pulse Generator (CPG)
driver from obtaining the mode pin values using mapping of the hardcoded
MODEMR register to using syscon and regmap.

It follows the same spirit as "[PATCH/RFC 00/11] ARM: shmobile: Let CPG
use syscon for MD pin values"[*], but this time I did write DT binding
documentation.

Feel free to fold some patches into the r8a7795 cpg, dtsi, and Kconfig
baseline.

Thanks!

[*] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/354675.html

Geert Uytterhoeven (6):
  reset: Add renesas,rst DT bindings.
  clk: shmobile: rcar-gen3: Document renesas,modemr
  clk: shmobile: rcar-gen3: Obtain MD pin values using syscon/regmap
  arm64: renesas: r8a7795 dtsi: Add device node for RST module
  arm64: renesas: r8a7795 dtsi: Link CPG to RST using "renesas,modemr"
  arm64: renesas: select MFD_SYSCON

 .../clock/renesas,rcar-gen3-cpg-clocks.txt         |  4 +++
 .../devicetree/bindings/reset/renesas,rst.txt      | 28 +++++++++++++++++
 arch/arm64/Kconfig.platforms                       |  1 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  6 ++++
 drivers/clk/shmobile/clk-rcar-gen3.c               | 35 +++++++---------------
 5 files changed, 50 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/renesas,rst.txt

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
