From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 17 Sep 2014 14:11:11 +0000
Subject: [PATCH 6/8] ARM: shmobile: marzen: Enable DU device in DT
Message-Id: <1410963073-3176-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Specify the DU output topology, enable the DU device and configure the
related pins.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 106 +++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index c160404..da2d0aa 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -68,6 +68,101 @@
 			gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	vga-enc {
+		compatible = "adi,adv7123";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ports {
+			port@0 {
+				vga_enc_in: endpoint {
+					remote-endpoint = <&du_out_rgb0>;
+				};
+			};
+			port@1 {
+				vga_enc_out: endpoint {
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
+				remote-endpoint = <&vga_enc_out>;
+			};
+		};
+	};
+
+	lvds-enc {
+		compatible = "thine,thc63lvdm83d";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ports {
+			port@0 {
+				lvds_enc_in: endpoint {
+					remote-endpoint = <&du_out_rgb1>;
+				};
+			};
+			port@1 {
+				lvds_enc_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
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
+				remote-endpoint = <&lvds_enc_out>;
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
+				remote-endpoint = <&vga_enc_in>;
+			};
+		};
+		port@1 {
+			endpoint {
+				remote-endpoint = <&lvds_enc_in>;
+			};
+		};
+	};
 };
 
 &irqpin0 {
@@ -83,6 +178,17 @@
 };
 
 &pfc {
+	du_pins: du {
+		du0 {
+			renesas,groups = "du0_rgb888", "du0_sync_1", "du0_clk_out_0";
+			renesas,function = "du0";
+		};
+		du1 {
+			renesas,groups = "du1_rgb666", "du1_sync_1", "du1_clk_out";
+			renesas,function = "du1";
+		};
+	};
+
 	lan0_pins: lan0 {
 		intc {
 			renesas,groups = "intc_irq1_b";
-- 
1.8.5.5

