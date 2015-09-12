From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 12 Sep 2015 22:50:52 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7794: add USB PHY DT support
Message-Id: <1590842.9hQm6l1zli@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442100737.hcefR9HyDq@wasted.cogentembedded.com>
In-Reply-To: <1442100737.hcefR9HyDq@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the R8A7794 generic part of the USB PHY device node. It is up to the
board file to enable the device.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794.dtsi |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
=================================--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -690,6 +690,25 @@
 				 0x1000 0 0 2 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	usbphy: usb-phy@e6590100 {
+		compatible = "renesas,usb-phy-r8a7794";
+		reg = <0 0xe6590100 0 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&mstp7_clks R8A7794_CLK_HSUSB>;
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
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;

