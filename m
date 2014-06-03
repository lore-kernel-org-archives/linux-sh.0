From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 03 Jun 2014 22:33:23 +0000
Subject: [PATCH 03/03] ARM: shmobile: Lager DT reference MMCIF DMAC prototype
Message-Id: <20140603223323.2193.96325.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Use AUXDATA to tie in the SYS-DMAC for MMCIF1 on Lager.
Only the DT reference case is covered. Not for upstream merge.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-v3.15-rc7-20140530 and
 [PATCH 01/03] ARM: shmobile: r8a7790: SYS-DMAC prototype
 [PATCH 02/03] ARM: shmobile: r8a7790: SYS-DMAC and MMCIF prototype

 arch/arm/mach-shmobile/board-lager-reference.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-06-03 22:06:43.000000000 +0900
@@ -20,6 +20,8 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
 #include <mach/clock.h>
@@ -98,11 +100,27 @@ static const struct clk_name clk_names[]
 	{ "lvds1", "lvds.1", "rcar-du-r8a7790" },
 };
 
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
 static void __init lager_add_standard_devices(void)
 {
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
 	r8a7790_add_dt_devices();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     lager_auxdata_lookup, NULL);
 
 	lager_add_du_device();
 }
