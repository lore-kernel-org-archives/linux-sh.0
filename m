From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 26 Feb 2015 09:21:21 +0000
Subject: [PATCH 1/3] ARM: shmobile: marzen: Add DU external pixel clock to DT
Message-Id: <1424942483-10910-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Declare the fixed 65MHz pixel clock connected to the DU clock input.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index e83d40e24bcd..540756cdf391 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -122,6 +122,12 @@
 			};
 		};
 	};
+
+	x3_clk: x3-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <65000000>;
+	};
 };
 
 &du {
@@ -129,6 +135,9 @@
 	pinctrl-names = "default";
 	status = "okay";
 
+	clocks = <&mstp1_clks R8A7779_CLK_DU>, <&x3_clk>;
+	clock-names = "du", "dclkin.0";
+
 	ports {
 		port@0 {
 			endpoint {
-- 
2.0.5

