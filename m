From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 21 Mar 2008 09:44:04 +0000
Subject: [PATCH 06/06] sh: MigoR NAND flash support using gen_flash
Message-Id: <20080321094404.10532.10909.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add NAND flash support to the MigoR board by giving board specific data
to the gen_nand platform driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/migor/setup.c |   73 ++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

--- 0007/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-03-21 13:07:48.000000000 +0900
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/mtd/physmap.h>
+#include <linux/mtd/nand.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
 #include <asm/sh_keysc.h>
@@ -101,9 +102,76 @@ static struct platform_device migor_nor_
 	},
 };
 
+static struct mtd_partition migor_nand_flash_partitions[] = {
+	{
+		.name		= "nanddata1",
+		.offset		= 0x0,
+		.size		= 512 * 1024 * 1024,
+	},
+	{
+		.name		= "nanddata2",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 512 * 1024 * 1024,
+	},
+};
+
+static void migor_nand_flash_cmd_ctl(struct mtd_info *mtd, int cmd,
+				     unsigned int ctrl)
+{
+	struct nand_chip *chip = mtd->priv;
+
+	if (cmd = NAND_CMD_NONE)
+		return;
+
+	if (ctrl & NAND_CLE)
+		writeb(cmd, chip->IO_ADDR_W + 0x00400000);
+	else if (ctrl & NAND_ALE)
+		writeb(cmd, chip->IO_ADDR_W + 0x00800000);
+	else
+		writeb(cmd, chip->IO_ADDR_W);
+}
+
+static int migor_nand_flash_ready(struct mtd_info *mtd)
+{
+	return ctrl_inb(PORT_PADR) & 0x02; /* PTA1 */
+}
+
+struct platform_nand_data migor_nand_flash_data = {
+	.chip = {
+		.nr_chips = 1,
+		.partitions = migor_nand_flash_partitions,
+		.nr_partitions = ARRAY_SIZE(migor_nand_flash_partitions),
+		.chip_delay = 20,
+		.part_probe_types = (const char *[]) { "cmdlinepart", NULL },
+	},
+	.ctrl = {
+		.dev_ready = migor_nand_flash_ready,
+		.cmd_ctrl = migor_nand_flash_cmd_ctl,
+	},
+};
+
+static struct resource migor_nand_flash_resources[] = {
+	[0] = {
+		.name		= "NAND Flash",
+		.start		= 0x18000000,
+		.end		= 0x18ffffff,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device migor_nand_flash_device = {
+	.name		= "gen_nand",
+	.resource	= migor_nand_flash_resources,
+	.num_resources	= ARRAY_SIZE(migor_nand_flash_resources),
+	.dev		= {
+		.platform_data = &migor_nand_flash_data,
+	}
+};
+
 static struct platform_device *migor_devices[] __initdata = {
 	&smc91x_eth_device,
 	&migor_nor_flash_device,
+	&migor_nand_flash_device,
 };
 
 static int __init migor_devices_setup(void)
@@ -124,6 +192,11 @@ static void __init migor_setup(char **cm
 	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x4000, PORT_HIZCRA);
 	ctrl_outw(ctrl_inw(PORT_HIZCRC) & ~0xc000, PORT_HIZCRC);
 	ctrl_outl(ctrl_inl(MSTPCR2) & ~0x00004000, MSTPCR2);
+
+	/* NAND Flash */
+	ctrl_outw(ctrl_inw(PORT_PXCR) & 0x0fff, PORT_PXCR);
+	ctrl_outl((ctrl_inl(BSC_CS6ABCR) & ~0x00000600) | 0x00000200,
+		  BSC_CS6ABCR);
 }
 
 static struct sh_machine_vector mv_migor __initmv = {
