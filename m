From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 10 Aug 2015 22:00:35 +0000
Subject: [PATCH v2 2/2] ARM: shmobile: silk: add QSPI DT support
Message-Id: <7036752.0LCvRcbC9K@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4187771.Fb49GBKgyg@wasted.cogentembedded.com>
In-Reply-To: <4187771.Fb49GBKgyg@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the SILK board dependent part of the QSPI device node.
Add device nodes  for Spansion  S25FL512S SPI flash and MTD partitions on it.

Based on the original patch by Vladimir Barinov
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- added fallback value to the SPI flash's "compatible" property;
- grouped all SPI-related properties together in the SPI flash node.

 arch/arm/boot/dts/r8a7794-silk.dts |   40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
@@ -65,6 +65,11 @@
 		renesas,groups = "mmc_data8", "mmc_ctrl";
 		renesas,function = "mmc";
 	};
+
+	qspi_pins: spi0 {
+		renesas,groups = "qspi_ctrl", "qspi_data4";
+		renesas,function = "qspi";
+	};
 };
 
 &scif2 {
@@ -100,3 +105,38 @@
 	non-removable;
 	status = "okay";
 };
+
+&qspi {
+	pinctrl-0 = <&qspi_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl512s", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <30000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		spi-cpol;
+		spi-cpha;
+		m25p,fast-read;
+
+		partition@0 {
+			label = "loader";
+			reg = <0x00000000 0x00040000>;
+			read-only;
+		};
+		partition@40000 {
+			label = "user";
+			reg = <0x00040000 0x00400000>;
+			read-only;
+		};
+		partition@440000 {
+			label = "flash";
+			reg = <0x00440000 0x03bc0000>;
+		};
+	};
+};

