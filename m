From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 02 Aug 2014 00:05:54 +0000
Subject: [PATCH v2 2/2] ARM: shmobile: henninger: add VIN0/ADV7180 DT support
Message-Id: <201408020405.54978.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201408020402.14560.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201408020402.14560.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the Henninger board dependent part of the VIN0 device node. Add the
device node for Analog Devices ADV7180 video decoder to I2C2  bus. Add the
necessary subnodes to interconnect VIN0 and ADV7180 devices.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- refreshed the patch.

 arch/arm/boot/dts/r8a7791-henninger.dts |   35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -135,6 +135,11 @@
 		renesas,groups = "usb1";
 		renesas,function = "usb1";
 	};
+
+	vin0_pins: vin0 {
+		renesas,groups = "vin0_data8", "vin0_clk";
+		renesas,function = "vin0";
+	};
 };
 
 &scif0 {
@@ -191,6 +196,19 @@
 
 	status = "okay";
 	clock-frequency = <400000>;
+
+	composite-in@20 {
+		compatible = "adi,adv7180";
+		reg = <0x20>;
+		remote = <&vin0>;
+
+		port {
+			adv7180: endpoint {
+				bus-width = <8>;
+				remote-endpoint = <&vin0ep>;
+			};
+		};
+	};
 };
 
 &qspi {
@@ -260,3 +278,20 @@
 &pciec {
 	status = "okay";
 };
+
+/* composite video input */
+&vin0 {
+	status = "ok";
+	pinctrl-0 = <&vin0_pins>;
+	pinctrl-names = "default";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vin0ep: endpoint {
+			remote-endpoint = <&adv7180>;
+			bus-width = <8>;
+		};
+	};
+};
