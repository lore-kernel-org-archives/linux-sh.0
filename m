From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 16 Feb 2015 23:00:34 +0000
Subject: [PATCH 2/2] ARM: shmobile: silk: add eMMC DT support
Message-Id: <3003389.IFU7VXDVjL@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <29687119.ELU9MoH02q@wasted.cogentembedded.com>
In-Reply-To: <29687119.ELU9MoH02q@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the SILK board dependent part of the MMCIF device node (the board has
eMMC chip) along with the  necessary voltage regulator (note that the Vcc/Vccq
regulator is dummy -- it's required by the MMCIF driver but doesn't actually
exist on the board).

Based on the original patch by Vladimir Barinov
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794-silk.dts |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
@@ -30,6 +30,15 @@
 		device_type = "memory";
 		reg = <0 0x40000000 0 0x40000000>;
 	};
+
+	d3_3v: regulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "D3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &extal_clk {
@@ -51,6 +60,11 @@
 		renesas,groups = "intc_irq8";
 		renesas,function = "intc";
 	};
+
+	mmcif0_pins: mmcif0 {
+		renesas,groups = "mmc_data8", "mmc_ctrl";
+		renesas,function = "mmc";
+	};
 };
 
 &scif2 {
@@ -75,3 +89,14 @@
 		micrel,led-mode = <1>;
 	};
 };
+
+&mmcif0 {
+	pinctrl-0 = <&mmcif0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&d3_3v>;
+	vqmmc-supply = <&d3_3v>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};

