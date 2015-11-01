From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 01 Nov 2015 19:19:35 +0000
Subject: [RFC v3 1/5] ARM: shmobile: r8a7790: add mstp4 and rwdt clock
Message-Id: <1446405579-5367-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Just for testing, not for upstream!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 9 ++++++---
 include/dt-bindings/clock/r8a7790-clock.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0612502b4a6d67..e39beeefdf594b 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1284,10 +1284,13 @@
 		mstp4_clks: mstp4_clks@e6150140 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
-			clocks = <&cp_clk>;
+			clocks = <&cp_clk>, <&rclk_clk>;
 			#clock-cells = <1>;
-			clock-indices = <R8A7790_CLK_IRQC>;
-			clock-output-names = "irqc";
+			clock-indices = <
+				R8A7790_CLK_IRQC
+				R8A7790_CLK_RWDT
+			>;
+			clock-output-names = "irqc", "rwdt";
 		};
 		mstp5_clks: mstp5_clks@e6150144 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 7b1ad8922eecdc..35ee24486ff124 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -80,6 +80,7 @@
 #define R8A7790_CLK_USBDMAC1		31
 
 /* MSTP4 */
+#define R8A7790_CLK_RWDT		2
 #define R8A7790_CLK_IRQC		7
 
 /* MSTP5 */
-- 
2.1.4

