From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 15 Oct 2015 00:34:16 +0000
Subject: [PATCH 5/7] ARM: shmobile: porter: add QSPI DT support
Message-Id: <2685a2cefe6bcd17e6b407799f41369c7dad422d.1444868963.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1444868963.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1444868963.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Define the Porter board dependent part of the QSPI device node.
Add device nodes  for Spansion  S25FL512S SPI flash and the MTD partitions
on it.

This patch is  mostly analogous  to the commit f59838d44835 ("ARM:
shmobile: henninger: add QSPI DT support")  as there are no differences
between the boards in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index b7fa8261e02f..4eebc67773d2 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -110,6 +110,11 @@
 		renesas,function = "sdhi2";
 	};
 
+	qspi_pins: spi0 {
+		renesas,groups = "qspi_ctrl", "qspi_data4";
+		renesas,function = "qspi";
+	};
+
 	i2c2_pins: i2c2 {
 		renesas,groups = "i2c2";
 		renesas,function = "i2c2";
@@ -165,6 +170,39 @@
 	status = "okay";
 };
 
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
+		m25p,fast-read;
+
+		partition@0 {
+			label = "loader_prg";
+			reg = <0x00000000 0x00040000>;
+			read-only;
+		};
+		partition@40000 {
+			label = "user_prg";
+			reg = <0x00040000 0x00400000>;
+			read-only;
+		};
+		partition@440000 {
+			label = "flash_fs";
+			reg = <0x00440000 0x03bc0000>;
+		};
+	};
+};
+
 &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";
-- 
2.1.4

