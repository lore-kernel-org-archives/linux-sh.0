From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 17 Sep 2014 14:11:13 +0000
Subject: [PATCH 8/8] ARM: shmobile: koelsch: Enable DU device in DT
Message-Id: <1410963073-3176-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Specify the DU output topology, enable the DU device and configure the
related pins.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 43 ++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 178431d..19d7b36 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -209,6 +209,46 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	panel {
+		compatible = "mitsubishi,aa104xd12", "panel-dpi";
+
+		width-mm = <210>;
+		height-mm = <158>;
+
+		panel-timing {
+			/* 1024x768 @65Hz */
+			clock-frequency = <65000000>;
+			hactive = <1024>;
+			vactive = <768>;
+			hsync-len = <136>;
+			hfront-porch = <20>;
+			hback-porch = <160>;
+			vfront-porch = <3>;
+			vback-porch = <29>;
+			vsync-len = <6>;
+		};
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&du_out_lvds0>;
+			};
+		};
+	};
+};
+
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	ports {
+		port@1 {
+			endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
 };
 
 &extal_clk {
@@ -216,9 +256,6 @@
 };
 
 &pfc {
-	pinctrl-0 = <&du_pins>;
-	pinctrl-names = "default";
-
 	i2c2_pins: i2c2 {
 		renesas,groups = "i2c2";
 		renesas,function = "i2c2";
-- 
1.8.5.5

