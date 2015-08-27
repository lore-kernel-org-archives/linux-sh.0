From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 27 Aug 2015 09:24:05 +0000
Subject: [PATCH/RFC 05/10] arm64: dts: r8a7795: add clock for EthernetAVB
Message-Id: <1440667450-3513-6-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
[horms: updated p_clk to s3d4_clk; moved to clock node; updated changelog;
        use R8A7795 as prefix for clock defines]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 11 +++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a608eb92a172..0b435d8274e4 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -227,6 +227,16 @@
 					clock-output-names = "hsusb", "ehci0", "ehci1", "ehci2";
 				};
 
+				mstp8_clks: mstp8_clks@e6150990 {
+					compatible = "renesas,r8a7795-mstp-clocks",
+						     "renesas,cpg-mstp-clocks";
+					reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
+					clocks =  <&s3d4_clk>;
+					#clock-cells = <1>;
+					renesas,clock-indices = <R8A7795_CLK_AVB>;
+					clock-output-names = "avb";
+				};
+
 				mstp9_clks: mstp9_clks@e6150994 {
 					compatible = "renesas,r8a7795-mstp-clocks",
 						     "renesas,cpg-mstp-clocks";
@@ -352,4 +362,5 @@
 			status = "disabled";
 		};
 	};
+
 };
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 5ca06876902f..8c00b635de2d 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -35,6 +35,7 @@
 #define R8A7795_CLK_EHCI2		1
 
 /* MSTP8 */
+#define R8A7795_CLK_AVB			12
 
 /* MSTP9 */
 #define R8A7795_CLK_GPIO0		12
-- 
2.1.4

