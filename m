From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 15 Sep 2014 13:45:29 +0000
Subject: [PATCH][TEST] ARM: shmobile: lager-reference: Instantiate IPMMU-MX
Message-Id: <20140915134529.21562.28560.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up the IPMMU MX together with the DU on the Lager board.

Based on the very similar r8a7791 Koelsch code written by
Laurent Pinchart, thanks to him for that.

Tested with DU using the VGA connector on the r8a7790 Lager board.

Not-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against renesas-devel-20140911-v3.17-rc4

 arch/arm/mach-shmobile/board-lager-reference.c |   30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- 0001/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-09-15 20:45:37.000000000 +0900
@@ -21,6 +21,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/ipmmu-vmsa.h>
 #include <linux/platform_data/rcar-du.h>
 
 #include <asm/mach/arch.h>
@@ -88,6 +89,34 @@ static void __init lager_add_du_device(v
 }
 
 /*
+ * IPMMUs
+ *
+ * MX: for JPU, 2DDMAC, VSP, DCU, FDP, IMR-LSX2, DU, VCP, VPC and VIN
+ */
+static struct resource ipmmu_mx_resources[] = {
+	DEFINE_RES_MEM(0xfe951800, 0x800),
+	DEFINE_RES_IRQ(gic_spi(222)),
+};
+
+static const struct ipmmu_vmsa_master ipmmu_mx_masters[] = {
+	{ "rcar-du-r8a7790", 15, },
+};
+
+static struct ipmmu_vmsa_platform_data ipmmu_mx_platform_data = {
+	.masters = ipmmu_mx_masters,
+	.num_masters = ARRAY_SIZE(ipmmu_mx_masters),
+};
+
+static void __init lager_add_ipmmu_devices(void)
+{
+	platform_device_register_resndata(NULL, "ipmmu-vmsa", -1,
+					  ipmmu_mx_resources,
+					  ARRAY_SIZE(ipmmu_mx_resources),
+					  &ipmmu_mx_platform_data,
+					  sizeof(ipmmu_mx_platform_data));
+}
+
+/*
  * This is a really crude hack to provide clkdev support to platform
  * devices until they get moved to DT.
  */
@@ -104,6 +133,7 @@ static void __init lager_add_standard_de
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
+	lager_add_ipmmu_devices();
 	lager_add_du_device();
 }
 
