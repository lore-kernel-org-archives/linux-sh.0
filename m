From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 25 Jun 2014 00:40:44 +0000
Subject: [PATCH 02/05] ARM: shmobile: Lager SYS-DMAC and SCIF prototype
Message-Id: <20140625004044.18295.6047.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Enable TX DMA for r8a7790 / Lager SCIF devices.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-lager-reference.c |   83 ++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

--- 0012/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-06-25 08:09:53.000000000 +0900
@@ -76,6 +76,7 @@ static const struct resource du_resource
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
+#include <linux/serial_sci.h>
 
 /* Local DMA slave IDs */
 enum {
@@ -88,6 +89,26 @@ enum {
 	SYS_DMAC_SLAVE_SDHI0_RX,
 	SYS_DMAC_SLAVE_SDHI2_TX,
 	SYS_DMAC_SLAVE_SDHI2_RX,
+	SYS_DMAC_SLAVE_SCIF0_TX,
+	SYS_DMAC_SLAVE_SCIF0_RX,
+	SYS_DMAC_SLAVE_SCIF1_TX,
+	SYS_DMAC_SLAVE_SCIF1_RX,
+	SYS_DMAC_SLAVE_SCIFA0_TX,
+	SYS_DMAC_SLAVE_SCIFA0_RX,
+	SYS_DMAC_SLAVE_SCIFA1_TX,
+	SYS_DMAC_SLAVE_SCIFA1_RX,
+	SYS_DMAC_SLAVE_SCIFA2_TX,
+	SYS_DMAC_SLAVE_SCIFA2_RX,
+	SYS_DMAC_SLAVE_SCIFB0_TX,
+	SYS_DMAC_SLAVE_SCIFB0_RX,
+	SYS_DMAC_SLAVE_SCIFB1_TX,
+	SYS_DMAC_SLAVE_SCIFB1_RX,
+	SYS_DMAC_SLAVE_SCIFB2_TX,
+	SYS_DMAC_SLAVE_SCIFB2_RX,
+	SYS_DMAC_SLAVE_HSCIF0_TX,
+	SYS_DMAC_SLAVE_HSCIF0_RX,
+	SYS_DMAC_SLAVE_HSCIF1_TX,
+	SYS_DMAC_SLAVE_HSCIF1_RX,
 };
 
 #define DMAE_CHANNEL(a, b)			\
@@ -112,11 +133,29 @@ enum {
 	.mid_rid	= r,					\
 }
 
+#define SYS_DMAC_SLAVE_TX(_id, _bit, _addr, toffset, roffset, t, r)	\
+{								\
+	.slave_id	= SYS_DMAC_SLAVE_## _id ##_TX,		\
+	.addr		= _addr + toffset,			\
+	.chcr		= CHCR_TX(XMIT_SZ_## _bit ##BIT),	\
+	.mid_rid	= t,					\
+}
+
 static const struct sh_dmae_slave_config r8a7790_sys_dmac_slaves[] = {
 	SYS_DMAC_SLAVE(MMCIF0, 32, 0xee200000, 0x34, 0x34, 0xd1, 0xd2),
 	SYS_DMAC_SLAVE(MMCIF1, 32, 0xee220000, 0x34, 0x34, 0xe1, 0xe2),
 	SYS_DMAC_SLAVE(SDHI0, 16, 0xee100000, 0x60, 0x2060, 0xcd, 0xce),
 	SYS_DMAC_SLAVE(SDHI2, 16, 0xee140000, 0x30, 0x2030, 0xc1, 0xc2),
+	SYS_DMAC_SLAVE_TX(SCIF0, 8, 0xe6e60000, 0xc, 0x14, 0x29, 0x2a),
+	SYS_DMAC_SLAVE_TX(SCIF1, 8, 0xe6e68000, 0xc, 0x14, 0x2d, 0x2e),
+	SYS_DMAC_SLAVE_TX(SCIFA0, 8, 0xe6c40000, 0x20, 0x24, 0x21, 0x22),
+	SYS_DMAC_SLAVE_TX(SCIFA1, 8, 0xe6c50000, 0x20, 0x24, 0x25, 0x26),
+	SYS_DMAC_SLAVE_TX(SCIFA2, 8, 0xe6c60000, 0x20, 0x24, 0x27, 0x28),
+	SYS_DMAC_SLAVE_TX(SCIFB0, 8, 0xe6c20000, 0x40, 0x60, 0x3d, 0x3e),
+	SYS_DMAC_SLAVE_TX(SCIFB1, 8, 0xe6c30000, 0x40, 0x60, 0x19, 0x1a),
+	SYS_DMAC_SLAVE_TX(SCIFB2, 8, 0xe6ce0000, 0x40, 0x60, 0x1d, 0x1e),
+	SYS_DMAC_SLAVE_TX(HSCIF0, 8, 0xe62c0000, 0xc, 0x14, 0x39, 0x3a),
+	SYS_DMAC_SLAVE_TX(HSCIF1, 8, 0xe62c8000, 0xc, 0x14, 0x4d, 0x4e),
 };
 
 static const struct sh_dmae_channel r8a7790_sys_dmac_channels[] = {
@@ -211,6 +250,40 @@ static struct sh_mobile_sdhi_info sdhi2_
 			  TMIO_MMC_WRPROTECT_DISABLE,
 };
 
+#define SCIF_PD(scif_type, index, scif_index)				\
+static struct plat_sci_port scif##index##_platform_data = {	\
+	.type		= PORT_##scif_type,			\
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,	\
+	.scscr		= SCSCR_RE | SCSCR_TE,			\
+	.dma_slave_tx	= SYS_DMAC_SLAVE_##scif_type##scif_index##_TX,	\
+	.dma_slave_rx	= SYS_DMAC_SLAVE_##scif_type##scif_index##_RX,	\
+}
+
+#define PDATA_SCIF(index, baseaddr, irq, i) SCIF_PD(SCIF, index, i)
+#define PDATA_SCIFA(index, baseaddr, irq, i) SCIF_PD(SCIFA, index, i)
+#define PDATA_SCIFB(index, baseaddr, irq, i) SCIF_PD(SCIFB, index, i)
+#define PDATA_HSCIF(index, baseaddr, irq, i) SCIF_PD(HSCIF, index, i)
+
+PDATA_SCIFA(0, 0xe6c40000, gic_spi(144), 0); /* SCIFA0 */
+PDATA_SCIFA(1, 0xe6c50000, gic_spi(145), 1); /* SCIFA1 */
+PDATA_SCIFB(2, 0xe6c20000, gic_spi(148), 0); /* SCIFB0 */
+PDATA_SCIFB(3, 0xe6c30000, gic_spi(149), 1); /* SCIFB1 */
+PDATA_SCIFB(4, 0xe6ce0000, gic_spi(150), 2); /* SCIFB2 */
+PDATA_SCIFA(5, 0xe6c60000, gic_spi(151), 2); /* SCIFA2 */
+PDATA_SCIF(6,  0xe6e60000, gic_spi(152), 0); /* SCIF0 */
+PDATA_SCIF(7,  0xe6e68000, gic_spi(153), 1); /* SCIF1 */
+PDATA_HSCIF(8, 0xe62c0000, gic_spi(154), 0); /* HSCIF0 */
+PDATA_HSCIF(9, 0xe62c8000, gic_spi(155), 1); /* HSCIF1 */
+
+#define SCIF_AD(scif_type, index, baseaddr)		\
+	OF_DEV_AUXDATA("renesas," scif_type "-r8a7790", baseaddr, \
+			"sh-sci." # index, &scif##index##_platform_data)
+
+#define AUXDATA_SCIF(index, baseaddr, irq) SCIF_AD("scif", index, baseaddr)
+#define AUXDATA_SCIFA(index, baseaddr, irq) SCIF_AD("scifa", index, baseaddr)
+#define AUXDATA_SCIFB(index, baseaddr, irq) SCIF_AD("scifb", index, baseaddr)
+#define AUXDATA_HSCIF(index, baseaddr, irq) SCIF_AD("hscif", index, baseaddr)
+
 static struct of_dev_auxdata lager_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("renesas,mmcif-r8a7790", 0xee220000, "sh_mmcif",
 			&mmcif1_pdata),
@@ -218,6 +291,16 @@ static struct of_dev_auxdata lager_auxda
 			&sdhi0_info),
 	OF_DEV_AUXDATA("renesas,sdhi-r8a7790", 0xee140000, "sdhi2",
 			&sdhi2_info),
+	AUXDATA_SCIFA(0, 0xe6c40000, gic_spi(144)), /* SCIFA0 */
+	AUXDATA_SCIFA(1, 0xe6c50000, gic_spi(145)), /* SCIFA1 */
+	AUXDATA_SCIFB(2, 0xe6c20000, gic_spi(148)), /* SCIFB0 */
+	AUXDATA_SCIFB(3, 0xe6c30000, gic_spi(149)), /* SCIFB1 */
+	AUXDATA_SCIFB(4, 0xe6ce0000, gic_spi(150)), /* SCIFB2 */
+	AUXDATA_SCIFA(5, 0xe6c60000, gic_spi(151)), /* SCIFA2 */
+	AUXDATA_SCIF(6,  0xe6e60000, gic_spi(152)), /* SCIF0 */
+	AUXDATA_SCIF(7,  0xe6e68000, gic_spi(153)), /* SCIF1 */
+	AUXDATA_HSCIF(8, 0xe62c0000, gic_spi(154)), /* HSCIF0 */
+	AUXDATA_HSCIF(9, 0xe62c8000, gic_spi(155)), /* HSCIF1 */
 	{},
 };
 
