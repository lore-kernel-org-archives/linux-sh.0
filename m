From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 04 Nov 2014 01:50:34 +0000
Subject: [PATCH 04/34] ARM: shmobile: r8a7791: add USB PHY DT support
Message-Id: <3b7e530d28db276b596251bbd435a058e27810f1.1415059587.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the R8A7791 generic part of the USB PHY device node. It is up to the
board file to enable the device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e4a7170..49f6b99 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -613,6 +613,25 @@
 		status = "disabled";
 	};
 
+	usbphy: usb-phy@e6590100 {
+		compatible = "renesas,usb-phy-r8a7791";
+		reg = <0 0xe6590100 0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
+		clock-names = "usbhs";
+		status = "disabled";
+
+		usb0: usb-channel@0 {
+			reg = <0>;
+			#phy-cells = <1>;
+		};
+		usb2: usb-channel@2 {
+			reg = <2>;
+			#phy-cells = <1>;
+		};
+	};
+
 	vin0: video@e6ef0000 {
 		compatible = "renesas,vin-r8a7791";
 		clocks = <&mstp8_clks R8A7791_CLK_VIN0>;
-- 
2.1.1

