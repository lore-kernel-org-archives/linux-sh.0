From: William Towle <william.towle@codethink.co.uk>
Date: Thu, 13 Aug 2015 11:36:49 +0000
Subject: [PATCH 1/3] ARM: shmobile: lager dts: Add entries for VIN HDMI input support
Message-Id: <1439465811-936-2-git-send-email-william.towle@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1439465811-936-1-git-send-email-william.towle@codethink.co.uk>
In-Reply-To: <1439465811-936-1-git-send-email-william.towle@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org, linux-kernel@lists.codethink.co.uk
Cc: linux-sh@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>

Add DT entries for vin0, vin0_pins, and adv7612.

Signed-off-by: William Towle <william.towle@codethink.co.uk>
Signed-off-by: Rob Taylor <rob.taylor@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790-lager.dts |   37 ++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index e02b523..31854bc 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -378,7 +378,12 @@
 		renesas,function = "usb2";
 	};
 
-	vin1_pins: vin {
+	vin0_pins: vin0 {
+		renesas,groups = "vin0_data24", "vin0_sync", "vin0_clkenb", "vin0_clk";
+		renesas,function = "vin0";
+	};
+
+	vin1_pins: vin1 {
 		renesas,groups = "vin1_data8", "vin1_clk";
 		renesas,function = "vin1";
 	};
@@ -539,6 +544,17 @@
 		reg = <0x12>;
 	};
 
+	hdmi-in@4c {
+		compatible = "adi,adv7612";
+		reg = <0x4c>;
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
@@ -654,6 +670,25 @@
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

