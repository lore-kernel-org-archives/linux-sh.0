From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Feb 2014 08:04:48 +0000
Subject: [PATCH 3/3] ARM: shmobile: koelsch dts: Add QSPI nodes
Message-Id: <e02ee513eed4bb780848a5cedbd4b39afb395d3e.1392275963.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1392275963.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1392275963.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add pinctrl and SPI devices for QSPI on Koelsch.
Add Spansion s25fl512s SPI FLASH and MTD partitions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 74f0985..d4b9bba 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -121,8 +121,44 @@
 		renesas,groups = "scif1_data_d";
 		renesas,function = "scif1";
 	};
+
+	qspi_pins: spi {
+		renesas,groups = "qspi_ctrl", "qspi_data4";
+		renesas,function = "qspi";
+	};
 };
 
 &sata0 {
 	status = "okay";
 };
+
+&spi {
+	pinctrl-0 = <&qspi_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	flash: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl512s";
+		reg = <0>;
+		spi-max-frequency = <30000000>;
+		m25p,fast-read;
+
+		partition@0 {
+			label = "loader";
+			reg = <0x00000000 0x00080000>;
+			read-only;
+		};
+		partition@80000 {
+			label = "bootenv";
+			reg = <0x00080000 0x00080000>;
+			read-only;
+		};
+		partition@100000 {
+			label = "data";
+			reg = <0x00100000 0x03f00000>;
+		};
+	};
+};
-- 
1.8.5.2

