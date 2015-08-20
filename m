From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 20 Aug 2015 06:29:09 +0000
Subject: [PATCH 2/7][RFC] arm64: dts: r8a7795: add EHCI[012] clocks
Message-Id: <1440052154-3768-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 10 +++++++---
 include/dt-bindings/clock/r8a7795-clock.h |  3 +++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 4744f1c..6930048 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -105,10 +105,14 @@
 					compatible = "renesas,r8a7795-mstp-clocks",
 						     "renesas,cpg-mstp-clocks";
 					reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
-					clocks =  <&p_clk>;
+					clocks =  <&p_clk>, <&p_clk>, <&p_clk>,
+						  <&p_clk>;
 					#clock-cells = <1>;
-					renesas,clock-indices = <R8A7795_CLK_HSUSB>;
-					clock-output-names = "hsusb";
+					renesas,clock-indices = <R8A7795_CLK_HSUSB
+								 R8A7795_CLK_EHCI0
+								 R8A7795_CLK_EHCI1
+								 R8A7795_CLK_EHCI2>;
+					clock-output-names = "hsusb", "ehci0", "ehci1", "ehci2";
 				};
 			};
 		};
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index ffb0b5b..2bd9d93 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -30,6 +30,9 @@
 
 /* MSTP7 */
 #define R8A7795_CLK_HSUSB		4
+#define R8A7795_CLK_EHCI0		3
+#define R8A7795_CLK_EHCI1		2
+#define R8A7795_CLK_EHCI2		1
 
 /* MSTP8 */
 
-- 
1.9.1

