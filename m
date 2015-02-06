From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 06 Feb 2015 01:33:09 +0000
Subject: [PATCH 2/2] ARM: shmobile: Add support SOC_BUS to R-Car Gen2
Message-Id: <1423186389-12861-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This provides information through SOC_BUS to sysfs.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig           |  1 +
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 42 +++++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0ebe727..bf33915 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -18,6 +18,7 @@ config ARCH_RCAR_GEN2
 	bool
 	select PM_RCAR if PM || SMP
 	select RENESAS_IRQC
+	select SOC_BUS
 	select SYS_SUPPORTS_SH_CMT
 	select PCI_DOMAINS if PCI
 
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 2230948..0fa3ef8 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -26,6 +26,8 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
 #include <asm/system_info.h>
 #include <asm/mach/arch.h>
 #include "common.h"
@@ -204,19 +206,53 @@ void __init rcar_gen2_reserve(void)
 }
 
 #define PRR 0xFF000044
-static unsigned int __init rcar_gen2_get_revision(void)
+static unsigned int __init rcar_gen2_get_prr(void)
 {
 	void __iomem *addr = ioremap_nocache(PRR, 4);
 	u32 data = ioread32(addr);
 
 	iounmap(addr);
 
-	return ((data & 0xF0) >> 4) + 1;
+	return data;
+}
+
+static unsigned int __init rcar_gen2_get_revision(void)
+{
+	return ((rcar_gen2_get_prr() & 0xF0) >> 4) + 1;
+}
+
+static u32 __init rcar_gen2_get_cpuid(void)
+{
+	return (rcar_gen2_get_prr() & 0x7F00) >> 8;
 }
 
 void __init rcar_gen2_init_machine(void)
 {
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	struct device *parent = NULL;
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		goto out;
+
 	system_rev = rcar_gen2_get_revision();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	soc_dev_attr->family = kasprintf(GFP_KERNEL, "Renesas R-Car Gen2");
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%d", system_rev);
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%04x",
+					 rcar_gen2_get_cpuid());
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->family);
+		kfree(soc_dev_attr->revision);
+		kfree(soc_dev_attr->soc_id);
+		kfree(soc_dev_attr);
+		goto out;
+	}
+
+	parent = soc_device_to_device(soc_dev);
+out:
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, parent);
 }
-- 
2.1.3

