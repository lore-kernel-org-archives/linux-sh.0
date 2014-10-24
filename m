From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 24 Oct 2014 12:03:57 +0000
Subject: [PATCH v4 5/9] ARM: shmobile: marzen: Enable DU device in DT
Message-Id: <1414152241-5390-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Specify the DU output topology, enable the DU device and configure the
related pins.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 81 ++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 9e1b859190ca..64a5d634edc1 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -69,6 +69,76 @@
 			gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	vga-encoder {
+		compatible = "adi,adv7123";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				vga_enc_in: endpoint {
+					remote-endpoint = <&du_out_rgb0>;
+				};
+			};
+			port@1 {
+				reg = <1>;
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
+				lvds_connector: endpoint {
+				};
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
@@ -84,6 +154,17 @@
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
2.0.4

