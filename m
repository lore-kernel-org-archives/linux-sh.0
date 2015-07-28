From: William Towle <william.towle@codethink.co.uk>
Date: Tue, 28 Jul 2015 16:17:43 +0000
Subject: [PATCH 1/2] ARM: shmobile: lager dts: Add entries for VIN HDMI input support
Message-Id: <1438100264-17280-2-git-send-email-william.towle@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1438100264-17280-1-git-send-email-william.towle@codethink.co.uk>
In-Reply-To: <1438100264-17280-1-git-send-email-william.towle@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org, linux-kernel@lists.codethink.co.uk
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-sh@vger.kernel.org

Add DT entries for vin0, vin0_pins, and adv7612

Signed-off-by: William Towle <william.towle@codethink.co.uk>
Signed-off-by: Rob Taylor <rob.taylor@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790-lager.dts |   41 ++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index e02b523..aec7db6 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -378,7 +378,12 @@
 		renesas,function = "usb2";
 	};
 
-	vin1_pins: vin {
+	vin0_pins: vin0 {
+		renesas,groups = "vin0_data24", "vin0_sync", "vin0_field", "vin0_clkenb", "vin0_clk";
+		renesas,function = "vin0";
+	};
+
+	vin1_pins: vin1 {
 		renesas,groups = "vin1_data8", "vin1_clk";
 		renesas,function = "vin1";
 	};
@@ -539,6 +544,18 @@
 		reg = <0x12>;
 	};
 
+	hdmi-in@4c {
+		compatible = "adi,adv7612";
+		reg = <0x4c>;
+		remote = <&vin0>;
+
+		port {
+			hdmi_in_ep: endpoint {
+				remote-endpoint = <&vin0ep0>;
+			};
+		};
+	};
+
 	composite-in@20 {
 		compatible = "adi,adv7180";
 		reg = <0x20>;
@@ -654,6 +671,28 @@
 	status = "okay";
 };
 
+/* HDMI video input */
+&vin0 {
+	pinctrl-0 = <&vin0_pins>;
+	pinctrl-names = "default";
+
+	status = "ok";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vin0ep0: endpoint {
+			remote-endpoint = <&hdmi_in_ep>;
+			bus-width = <24>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			pclk-sample = <1>;
+			data-active = <1>;
+		};
+	};
+};
+
 /* composite video input */
 &vin1 {
 	pinctrl-0 = <&vin1_pins>;
-- 
1.7.10.4

