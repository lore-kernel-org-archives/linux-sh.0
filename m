From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 24 Aug 2015 16:09:37 +0000
Subject: [PATCH 3/3] arm64: renesas: salvator-x: Add missing extal clock override
Message-Id: <1440432577-9767-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Override the "extal" clock with the frequency and accuracy of the
crystal oscillator on the Salvator-X board.

Without this, all clocks have a clock rate of zero.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
FIXME

Even taking into account some of the PLL clock rates are "PLLx = VCO/2",
the rates for pll0, pll1 (and its children), and pll2 are still off by
another factor of two:

$ cat /sys/kernel/debug/clk/clk_summary
   clock         enable_cnt  prepare_cnt        rate   accuracy   phase
------------------------------------------------------------------------
 extal_clk                1            1    16666600      50000 0
    main                  1            1     8333300      50000 0
       pll4               0            0  1199995200      50000 0
       pll3               0            0  1599993600      50000 0
       pll2               0            0   599997600      50000 0
       pll1               1            1   799996800      50000 0
          s3d4            1            4    33333200      50000 0
             scif2        2            2    33333200      50000 0
       pll0               0            0   749997000      50000 0
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 88cc34819e6af58a..7bb80a937d760195 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -31,6 +31,11 @@
 	};
 };
 
+&extal_clk {
+	clock-frequency = <16666600>;
+	clock-accuracy = <50000>;
+};
+
 &pfc {
 	scif2_pins: scif2 {
 		renesas,groups = "scif2_data";
-- 
1.9.1

