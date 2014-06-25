From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 25 Jun 2014 00:41:10 +0000
Subject: [PATCH 05/05] ARM: shmobile: Koelsch SYS-DMAC and MSIOF prototype
Message-Id: <20140625004110.18295.98130.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Enable DMA for MSIOF on r8a7791 Koelsch.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/r8a7791.dtsi                   |    6 +++---
 arch/arm/mach-shmobile/board-koelsch-reference.c |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 3 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2014-06-25 09:12:54.000000000 +0900
@@ -933,7 +933,7 @@
 
 	msiof0: spi@e6e20000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e20000 0 0x0064>;
+		reg = <0 0xe6e20000 0 0x0064>, <0 0xe7e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
 		#address-cells = <1>;
@@ -943,7 +943,7 @@
 
 	msiof1: spi@e6e10000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e10000 0 0x0064>;
+		reg = <0 0xe6e10000 0 0x0064>, <0 0xe7e10000 0 0x0064>;
 		interrupts = <0 157 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF1>;
 		#address-cells = <1>;
@@ -953,7 +953,7 @@
 
 	msiof2: spi@e6e00000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e00000 0 0x0064>;
+		reg = <0 0xe6e00000 0 0x0064>, <0 0xe7e00000 0 0x0064>;
 		interrupts = <0 158 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_MSIOF2>;
 		#address-cells = <1>;
--- 0015/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-06-25 09:13:44.000000000 +0900
@@ -72,6 +72,7 @@ static const struct resource du_resource
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/serial_sci.h>
+#include <linux/spi/sh_msiof.h>
 
 /* Local DMA slave IDs */
 enum {
@@ -118,6 +119,12 @@ enum {
 	SYS_DMAC_SLAVE_HSCIF1_RX,
 	SYS_DMAC_SLAVE_HSCIF2_TX,
 	SYS_DMAC_SLAVE_HSCIF2_RX,
+	SYS_DMAC_SLAVE_MSIOF0_TX,
+	SYS_DMAC_SLAVE_MSIOF0_RX,
+	SYS_DMAC_SLAVE_MSIOF1_TX,
+	SYS_DMAC_SLAVE_MSIOF1_RX,
+	SYS_DMAC_SLAVE_MSIOF2_TX,
+	SYS_DMAC_SLAVE_MSIOF2_RX,
 };
 
 #define DMAE_CHANNEL(a, b)			\
@@ -172,6 +179,9 @@ static const struct sh_dmae_slave_config
 	SYS_DMAC_SLAVE_TX(HSCIF0, 8, 0xe62c0000, 0xc, 0x14, 0x39, 0x3a),
 	SYS_DMAC_SLAVE_TX(HSCIF1, 8, 0xe62c8000, 0xc, 0x14, 0x4d, 0x4e),
 	SYS_DMAC_SLAVE_TX(HSCIF2, 8, 0xe62d0000, 0xc, 0x14, 0x3b, 0x3c),
+	SYS_DMAC_SLAVE(MSIOF0, 32, 0xe7e20000, 0x50, 0x60, 0x51, 0x52),
+	SYS_DMAC_SLAVE(MSIOF1, 32, 0xe7e10000, 0x50, 0x60, 0x55, 0x56),
+	SYS_DMAC_SLAVE(MSIOF2, 32, 0xe7e00000, 0x50, 0x60, 0x41, 0x42),
 };
 
 static const struct sh_dmae_channel r8a7791_sys_dmac_channels[] = {
@@ -312,6 +322,13 @@ PDATA_HSCIF(17, 0xe6cd0000, gic_spi(21),
 #define AUXDATA_SCIFB(index, baseaddr, irq) SCIF_AD("scifb", index, baseaddr)
 #define AUXDATA_HSCIF(index, baseaddr, irq) SCIF_AD("hscif", index, baseaddr)
 
+static struct sh_msiof_spi_info msiof0_info = {
+	.rx_fifo_override       = 256,
+	.num_chipselect         = 1,
+	.dma_tx_id              = SYS_DMAC_SLAVE_MSIOF0_TX,
+	.dma_rx_id              = SYS_DMAC_SLAVE_MSIOF0_RX,
+};
+
 static struct of_dev_auxdata koelsch_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("renesas,sdhi-r8a7791", 0xee100000, "sdhi0",
 			&sdhi0_info),
@@ -337,6 +354,8 @@ static struct of_dev_auxdata koelsch_aux
 	AUXDATA_HSCIF(15, 0xe62c0000, gic_spi(154)), /* HSCIF0 */
 	AUXDATA_HSCIF(16, 0xe62c8000, gic_spi(155)), /* HSCIF1 */
 	AUXDATA_HSCIF(17, 0xe6cd0000, gic_spi(21)), /* HSCIF2 */
+	OF_DEV_AUXDATA("renesas,msiof-r8a7791", 0xe6e20000,
+		       "spi_r8a7791_msiof.0", &msiof0_info),
 	{},
 };
 
