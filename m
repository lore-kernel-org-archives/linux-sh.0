From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 23 May 2014 22:28:09 +0000
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7790: add USB PHY DT support
Message-Id: <201405240228.10824.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201405240226.27820.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201405240226.27820.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the R8A7790 generic part of the USB PHY device node. It is up to the
board file to enable the device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- added subnodes to the USB PHY node;
- refreshed the patch.

 arch/arm/boot/dts/r8a7790.dtsi |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
=================================--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -462,6 +462,32 @@
 		status = "disabled";
 	};
 
+	usbphy: usb-phy@e6590100 {
+		compatible = "renesas,usb-phy-r8a7790";
+		reg = <0 0xe6590100 0 0x100>;
+		#phy-cells = <2>;
+		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+		clock-names = "usbhs";
+		status = "disabled";
+
+		usb-phy@0,0 {
+			renesas,phy-select = <0 0>;
+			renesas,ugctrl2-masks = <0x00000030 0x00000010>;
+		};
+		usb-phy@0,1 {
+			renesas,phy-select = <0 1>;
+			renesas,ugctrl2-masks = <0x00000030 0x00000030>;
+		};
+		usb-phy@1,0 {
+			renesas,phy-select = <1 0>;
+			renesas,ugctrl2-masks = <0x80000000 0x00000000>;
+		};
+		usb-phy@1,1 {
+			renesas,phy-select = <1 1>;
+			renesas,ugctrl2-masks = <0x80000000 0x80000000>;
+		};
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
