From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 10 Jun 2014 23:03:45 +0000
Subject: [PATCH 04/07] ARM: shmobile: Lager SYS-DMAC and MMCIF prototype
Message-Id: <20140610230345.13594.68069.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up SYS-DMAC prototype support for MMCIF1 on Lager.

Local platform device version of SYS-DMAC and local slave IDs
are used together with AUXDATA.

Only the DT reference case is covered. Not for upstream merge.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-lager-reference.c |   26 +++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

--- 0006/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-06-10 22:29:39.000000000 +0900
@@ -72,10 +72,16 @@ static const struct resource du_resource
 
 #include <linux/sh_dma.h>
 #include <mach/dma-register.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
 
 /* Local DMA slave IDs */
 enum {
 	RCAR_DMA_SLAVE_LAGER_INVALID = 0,
+	SYS_DMAC_SLAVE_MMCIF0_TX = 64,
+	SYS_DMAC_SLAVE_MMCIF0_RX,
+	SYS_DMAC_SLAVE_MMCIF1_TX,
+	SYS_DMAC_SLAVE_MMCIF1_RX,
 };
 
 #define DMAE_CHANNEL(a, b)			\
@@ -101,6 +107,8 @@ enum {
 }
 
 static const struct sh_dmae_slave_config r8a7790_sys_dmac_slaves[] = {
+	SYS_DMAC_SLAVE(MMCIF0, 32, 0xee200000, 0x34, 0x34, 0xd1, 0xd2),
+	SYS_DMAC_SLAVE(MMCIF1, 32, 0xee220000, 0x34, 0x34, 0xe1, 0xe2),
 };
 
 static const struct sh_dmae_channel r8a7790_sys_dmac_channels[] = {
@@ -161,6 +169,21 @@ static void __init lager_add_dmac_protot
 	r8a7790_register_sys_dmac(0);
 }
 
+static struct sh_mmcif_plat_data mmcif1_pdata = {
+	.caps		= MMC_CAP_4_BIT_DATA |
+			  MMC_CAP_8_BIT_DATA |
+			  MMC_CAP_NONREMOVABLE,
+	.ccs_unsupported = true,
+	.slave_id_tx	= SYS_DMAC_SLAVE_MMCIF1_TX,
+	.slave_id_rx	= SYS_DMAC_SLAVE_MMCIF1_RX,
+};
+
+static struct of_dev_auxdata lager_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("renesas,mmcif-r8a7790", 0xee220000, "sh_mmcif",
+			&mmcif1_pdata),
+	{},
+};
+
 static void __init lager_add_du_device(void)
 {
 	struct platform_device_info info = {
@@ -194,7 +217,8 @@ static void __init lager_add_standard_de
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
 	r8a7790_add_dt_devices();
 	lager_add_dmac_prototype();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     lager_auxdata_lookup, NULL);
 
 	lager_add_du_device();
 }
