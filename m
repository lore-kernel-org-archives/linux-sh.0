From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 19 Aug 2015 22:05:02 +0000
Subject: [PATCH 2/2] ARM: shmobile: silk: add I2C1 DT support
Message-Id: <1624715.8TpWL8Dlnf@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2390854.nqPs17CVpc@wasted.cogentembedded.com>
In-Reply-To: <2390854.nqPs17CVpc@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the SILK board dependent part of the I2C1 device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794-silk.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
@@ -85,6 +85,11 @@
 		renesas,function = "intc";
 	};
 
+	i2c1_pins: i2c1 {
+		renesas,groups = "i2c1";
+		renesas,function = "i2c1";
+	};
+
 	mmcif0_pins: mmcif0 {
 		renesas,groups = "mmc_data8", "mmc_ctrl";
 		renesas,function = "mmc";
@@ -124,6 +129,14 @@
 	};
 };
 
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+};
+
 &mmcif0 {
 	pinctrl-0 = <&mmcif0_pins>;
 	pinctrl-names = "default";

