From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 17 Sep 2014 14:11:12 +0000
Subject: [PATCH 7/8] ARM: shmobile: lager: Enable DU device in DT
Message-Id: <1410963073-3176-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Specify the DU output topology, enable the DU device and configure the
related pins.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 78 +++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index b28e6a2..90d1d6c 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -144,6 +144,81 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	adv7123 {
+		compatible = "adi,adv7123";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ports {
+			port@0 {
+				adv7123_in: endpoint {
+					remote-endpoint = <&du_out_rgb>;
+				};
+			};
+			port@1 {
+				adv7123_out: endpoint {
+					remote-endpoint = <&vga_in>;
+				};
+			};
+		};
+	};
+
+	vga {
+		compatible = "vga-connector";
+
+		port {
+			vga_in: endpoint {
+				remote-endpoint = <&adv7123_out>;
+			};
+		};
+	};
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
+				remote-endpoint = <&du_out_lvds1>;
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
+		port@0 {
+			endpoint {
+				remote-endpoint = <&adv7123_in>;
+			};
+		};
+		port@2 {
+			endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
 };
 
 &extal_clk {
@@ -151,9 +226,6 @@
 };
 
 &pfc {
-	pinctrl-0 = <&du_pins>;
-	pinctrl-names = "default";
-
 	du_pins: du {
 		renesas,groups = "du_rgb666", "du_sync_1", "du_clk_out_0";
 		renesas,function = "du";
-- 
1.8.5.5

