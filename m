From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 20 Aug 2015 06:29:08 +0000
Subject: [PATCH 1/7][RFC] arm64: dts: r8a7795: add mstp7 node and enable HSUSB clock
Message-Id: <1440052154-3768-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 9 +++++++++
 include/dt-bindings/clock/r8a7795-clock.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index fd25348..4744f1c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -101,6 +101,15 @@
 					renesas,clock-indices = <R8A7795_CLK_SCIF2>;
 					clock-output-names = "scif2";
 				};
+				mstp7_clks: mstp7_clks@e615014c {
+					compatible = "renesas,r8a7795-mstp-clocks",
+						     "renesas,cpg-mstp-clocks";
+					reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
+					clocks =  <&p_clk>;
+					#clock-cells = <1>;
+					renesas,clock-indices = <R8A7795_CLK_HSUSB>;
+					clock-output-names = "hsusb";
+				};
 			};
 		};
 
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 27b3a29..ffb0b5b 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -29,6 +29,7 @@
 /* MSTP5 */
 
 /* MSTP7 */
+#define R8A7795_CLK_HSUSB		4
 
 /* MSTP8 */
 
-- 
1.9.1

