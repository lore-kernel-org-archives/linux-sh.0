From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Dec 2014 23:42:14 +0000
Subject: [PATCH 14/15] ARM: shmobile: lager: Add DU external pixel clocks to DT
Message-Id: <1418254935-13536-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/boot/dts/r8a7790-lager.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 749fe841aa09..67eda547e15d 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -233,6 +233,18 @@
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
@@ -240,6 +252,15 @@
 	pinctrl-names = "default";
 	status = "okay";
 
+	clocks = <&mstp7_clks R8A7790_CLK_DU0>,
+		 <&mstp7_clks R8A7790_CLK_DU1>,
+		 <&mstp7_clks R8A7790_CLK_DU2>,
+		 <&mstp7_clks R8A7790_CLK_LVDS0>,
+		 <&mstp7_clks R8A7790_CLK_LVDS1>,
+		 <&x13_clk>, <&x2_clk>;
+	clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1",
+		      "dclkin.0", "dclkin.1";
+
 	ports {
 		port@0 {
 			endpoint {
-- 
2.0.4

