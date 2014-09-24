From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 24 Sep 2014 12:27:54 +0000
Subject: [PATCH v2 7/9] ARM: shmobile: lager: Enable DU device in DT
Message-Id: <1411561676-9556-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397511312-4845-8-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397511312-4845-8-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Specify the DU output topology, enable the DU device and configure the
related pins.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 51 ++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 84dcafa..a036d88 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -144,6 +144,54 @@
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
+			lvds_connector: endpoint {
+			};
+		};
+	};
 };
 
 &extal_clk {
@@ -151,9 +199,6 @@
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

