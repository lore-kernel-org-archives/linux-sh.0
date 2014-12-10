From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Dec 2014 23:42:15 +0000
Subject: [PATCH 15/15] ARM: shmobile: koelsch: Add DU external pixel clocks to DT
Message-Id: <1418254935-13536-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Declare the fixed 148.5MHz pixel clocks connected to the DU clock
inputs.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 926a2ded55bc..04a518409a30 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -269,6 +269,18 @@
 			};
 		};
 	};
+
+	x2_clk: x2-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <148500000>;
+	};
+
+	x13_clk: x13-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <148500000>;
+	};
 };
 
 &du {
@@ -276,6 +288,13 @@
 	pinctrl-names = "default";
 	status = "okay";
 
+	clocks = <&mstp7_clks R8A7791_CLK_DU0>,
+		 <&mstp7_clks R8A7791_CLK_DU1>,
+		 <&mstp7_clks R8A7791_CLK_LVDS0>,
+		 <&x13_clk>, <&x2_clk>;
+	clock-names = "du.0", "du.1", "lvds.0",
+		      "dclkin.0", "dclkin.1";
+
 	ports {
 		port@0 {
 			endpoint {
-- 
2.0.4

