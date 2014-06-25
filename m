From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 25 Jun 2014 00:40:53 +0000
Subject: [PATCH 03/05] ARM: shmobile: Lager SYS-DMAC and MSIOF prototype
Message-Id: <20140625004053.18295.46160.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Enable DMA for MSIOF on r8a7790 Lager.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/r8a7790.dtsi                 |    8 ++++----
 arch/arm/mach-shmobile/board-lager-reference.c |   22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+), 4 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2014-06-25 09:09:56.000000000 +0900
@@ -892,7 +892,7 @@
 
 	msiof0: spi@e6e20000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6e20000 0 0x0064>;
+		reg = <0 0xe6e20000 0 0x0064>, <0 0xe7e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7790_CLK_MSIOF0>;
 		#address-cells = <1>;
@@ -902,7 +902,7 @@
 
 	msiof1: spi@e6e10000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6e10000 0 0x0064>;
+		reg = <0 0xe6e10000 0 0x0064>, <0 0xe7e10000 0 0x0064>;
 		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF1>;
 		#address-cells = <1>;
@@ -912,7 +912,7 @@
 
 	msiof2: spi@e6e00000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6e00000 0 0x0064>;
+		reg = <0 0xe6e00000 0 0x0064>, <0 0xe7e00000 0 0x0064>;
 		interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF2>;
 		#address-cells = <1>;
@@ -922,7 +922,7 @@
 
 	msiof3: spi@e6c90000 {
 		compatible = "renesas,msiof-r8a7790";
-		reg = <0 0xe6c90000 0 0x0064>;
+		reg = <0 0xe6c90000 0 0x0064>, <0 0xe7c90000 0 0x0064>;
 		interrupts = <0 159 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_MSIOF3>;
 		#address-cells = <1>;
--- 0014/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-06-25 09:17:07.000000000 +0900
@@ -77,6 +77,7 @@ static const struct resource du_resource
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/serial_sci.h>
+#include <linux/spi/sh_msiof.h>
 
 /* Local DMA slave IDs */
 enum {
@@ -109,6 +110,14 @@ enum {
 	SYS_DMAC_SLAVE_HSCIF0_RX,
 	SYS_DMAC_SLAVE_HSCIF1_TX,
 	SYS_DMAC_SLAVE_HSCIF1_RX,
+	SYS_DMAC_SLAVE_MSIOF0_TX,
+	SYS_DMAC_SLAVE_MSIOF0_RX,
+	SYS_DMAC_SLAVE_MSIOF1_TX,
+	SYS_DMAC_SLAVE_MSIOF1_RX,
+	SYS_DMAC_SLAVE_MSIOF2_TX,
+	SYS_DMAC_SLAVE_MSIOF2_RX,
+	SYS_DMAC_SLAVE_MSIOF3_TX,
+	SYS_DMAC_SLAVE_MSIOF3_RX,
 };
 
 #define DMAE_CHANNEL(a, b)			\
@@ -156,6 +165,10 @@ static const struct sh_dmae_slave_config
 	SYS_DMAC_SLAVE_TX(SCIFB2, 8, 0xe6ce0000, 0x40, 0x60, 0x1d, 0x1e),
 	SYS_DMAC_SLAVE_TX(HSCIF0, 8, 0xe62c0000, 0xc, 0x14, 0x39, 0x3a),
 	SYS_DMAC_SLAVE_TX(HSCIF1, 8, 0xe62c8000, 0xc, 0x14, 0x4d, 0x4e),
+	SYS_DMAC_SLAVE(MSIOF0, 32, 0xe7e20000, 0x50, 0x60, 0x51, 0x52),
+	SYS_DMAC_SLAVE(MSIOF1, 32, 0xe7e10000, 0x50, 0x60, 0x55, 0x56),
+	SYS_DMAC_SLAVE(MSIOF2, 32, 0xe7e00000, 0x50, 0x60, 0x41, 0x42),
+	SYS_DMAC_SLAVE(MSIOF3, 32, 0xec900000, 0x50, 0x60, 0x45, 0x46),
 };
 
 static const struct sh_dmae_channel r8a7790_sys_dmac_channels[] = {
@@ -284,6 +297,13 @@ PDATA_HSCIF(9, 0xe62c8000, gic_spi(155),
 #define AUXDATA_SCIFB(index, baseaddr, irq) SCIF_AD("scifb", index, baseaddr)
 #define AUXDATA_HSCIF(index, baseaddr, irq) SCIF_AD("hscif", index, baseaddr)
 
+static struct sh_msiof_spi_info msiof1_info = {
+	.rx_fifo_override       = 256,
+	.num_chipselect         = 1,
+	.dma_tx_id              = SYS_DMAC_SLAVE_MSIOF1_TX,
+	.dma_rx_id              = SYS_DMAC_SLAVE_MSIOF1_RX,
+};
+
 static struct of_dev_auxdata lager_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("renesas,mmcif-r8a7790", 0xee220000, "sh_mmcif",
 			&mmcif1_pdata),
@@ -301,6 +321,8 @@ static struct of_dev_auxdata lager_auxda
 	AUXDATA_SCIF(7,  0xe6e68000, gic_spi(153)), /* SCIF1 */
 	AUXDATA_HSCIF(8, 0xe62c0000, gic_spi(154)), /* HSCIF0 */
 	AUXDATA_HSCIF(9, 0xe62c8000, gic_spi(155)), /* HSCIF1 */
+	OF_DEV_AUXDATA("renesas,msiof-r8a7790", 0xe6e10000,
+		       "spi_r8a7790_msiof.0", &msiof1_info),
 	{},
 };
 
