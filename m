From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Sep 2014 11:20:34 +0000
Subject: [PATCH 03/03] ARM: shmobile: lager-reference: IOMMUSY1 and USB tests
Message-Id: <20140916112034.14889.85988.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add some prototype code to allow testing of IPMMUSY1
and USB 2.0 Host controllers on the r8a7790 Lager board.

The USB 2.0 Host controllers are described via DT while
the IPMMU device is handled as platform device for now.

Not for upstream merge.

Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-lager-reference.c |   30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

--- 0001/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-09-16 17:04:43.000000000 +0900
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
+ * IPMMUSY1
+ */
+static struct resource ipmmu_resources[] = {
+	DEFINE_RES_MEM(0xe6290800, 0x800),
+	DEFINE_RES_IRQ(gic_spi(225)),
+};
+
+static const struct ipmmu_vmsa_master ipmmu_masters[] = {
+	{ "ee090000.pci", 6, },
+	{ "ee0b0000.pci", 8, },
+	{ "ee0d0000.pci", 9, },
+};
+
+static struct ipmmu_vmsa_platform_data ipmmu_platform_data = {
+	.masters = ipmmu_masters,
+	.num_masters = ARRAY_SIZE(ipmmu_masters),
+};
+
+static void __init lager_add_ipmmu_devices(void)
+{
+	platform_device_register_resndata(NULL, "ipmmu-vmsa", -1,
+					  ipmmu_resources,
+					  ARRAY_SIZE(ipmmu_resources),
+					  &ipmmu_platform_data,
+					  sizeof(ipmmu_platform_data));
+}
+
+/*
  * This is a really crude hack to provide clkdev support to platform
  * devices until they get moved to DT.
  */
@@ -105,6 +134,7 @@ static void __init lager_add_standard_de
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	lager_add_du_device();
+	lager_add_ipmmu_devices();
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
