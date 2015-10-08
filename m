From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 08 Oct 2015 21:45:49 +0000
Subject: [PATCH] ARM: shmobile: porter: add VIN0/ADV7180 DT support
Message-Id: <2169211.txWv7mmrno@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1750082.WpWf34HsI6@wasted.cogentembedded.com>
In-Reply-To: <1750082.WpWf34HsI6@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the  Porter board dependent part of the VIN0 device node.
Add the device node for Analog Devices  ADV7180 video decoder to I2C2 bus.
Add the necessary subnodes to interconnect VIN0 and ADV7180 devices.

This patch is  analogous to the commit 8d62f4f75320 ("ARM: shmobile:
henninger: add VIN0/ADV7180 DT support") as there are no differences
between the boards in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20151008-v4.3-rc4' tag of Simon Horman's
'renesas.git' repo plus the Porter I2C2 support patch just posted.

 arch/arm/boot/dts/r8a7791-porter.dts |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791-porter.dts
+++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
@@ -114,6 +114,11 @@
 		renesas,groups = "i2c2";
 		renesas,function = "i2c2";
 	};
+
+	vin0_pins: vin0 {
+		renesas,groups = "vin0_data8", "vin0_clk";
+		renesas,function = "vin0";
+	};
 };
 
 &scif0 {
@@ -166,8 +171,38 @@
 
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
 
 &sata0 {
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

