From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 17 Mar 2014 11:15:16 +0000
Subject: [RFC 5/6] drivers: move drivers/sh/pm_runtime.c to drivers/base
Message-Id: <1395054917-27390-6-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Move the drivers/sh/pm_runtime.c code to drivers/base as it may be of
use to any systems that need some generic platformbus power management.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/base/Kconfig               |  8 +++++
 drivers/base/Makefile              |  1 +
 drivers/base/pm_runtime_platform.c | 65 ++++++++++++++++++++++++++++++++++++++
 drivers/sh/Makefile                |  2 --
 drivers/sh/pm_runtime.c            | 60 -----------------------------------
 include/linux/platform_device.h    |  2 ++
 6 files changed, 76 insertions(+), 62 deletions(-)
 create mode 100644 drivers/base/pm_runtime_platform.c
 delete mode 100644 drivers/sh/pm_runtime.c

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index ec36e77..6249834 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -188,6 +188,14 @@ config GENERIC_CPU_DEVICES
 config SOC_BUS
 	bool
 
+config PM_RUNTIME_PLATFORM
+	bool "Generic PM runtime support for platform bus"
+	default y if CONFIG_ARCH_SHMOBILE || CONFIG_SUPERH
+	help
+	  This option enables a default pm domain for the platform bus
+	  for controlling device power management without any system
+	  specific code.
+
 source "drivers/base/regmap/Kconfig"
 
 config DMA_SHARED_BUFFER
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 04b314e..0ddd9c1 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
 obj-$(CONFIG_REGMAP)	+= regmap/
 obj-$(CONFIG_SOC_BUS) += soc.o
 obj-$(CONFIG_PINCTRL) += pinctrl.o
+obj-$(CONFIG_PM_RUNTIME_PLATFORM) += pm_runtime_platform.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
 
diff --git a/drivers/base/pm_runtime_platform.c b/drivers/base/pm_runtime_platform.c
new file mode 100644
index 0000000..c55e364
--- /dev/null
+++ b/drivers/base/pm_runtime_platform.c
@@ -0,0 +1,65 @@
+/*
+ * Runtime PM support code
+ *
+ *  Copyright (C) 2009-2010 Magnus Damm
+ *  Copyright (C) 2014 Codethink Limited
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_clock.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/sh_clk.h>
+#include <linux/bitmap.h>
+#include <linux/slab.h>
+
+#ifdef CONFIG_PM_RUNTIME
+static struct dev_pm_domain default_pm_domain = {
+	.ops = {
+		.runtime_suspend = pm_clk_suspend,
+		.runtime_resume = pm_clk_resume,
+		USE_PLATFORM_PM_SLEEP_OPS
+	},
+};
+
+#define DEFAULT_PM_DOMAIN_PTR	(&default_pm_domain)
+
+#else
+
+#define DEFAULT_PM_DOMAIN_PTR	NULL
+
+#endif /* CONFIG_PM_RUNTIME */
+
+static struct pm_clk_notifier_block platform_bus_notifier = {
+	.pm_domain = DEFAULT_PM_DOMAIN_PTR,
+	.con_ids = { NULL, },
+};
+
+static bool platbus_pm_on;
+
+int __init platformbus_pm_runtime_init(void)
+{
+	platbus_pm_on = true;
+	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
+	return 0;
+}
+
+static int __init platformbus_pm_runtime_late_init(void)
+{
+	if (platbus_pm_on)
+		pm_genpd_poweroff_unused();
+	return 0;
+}
+late_initcall(platformbus_pm_runtime_late_init);
+
+#if defined(CONFIG_ARCH_SHMOBILE_LEGACY) || defined(CONFIG_SH)
+core_initcall(platformbus_pm_runtime_init);
+#endif
diff --git a/drivers/sh/Makefile b/drivers/sh/Makefile
index b4d588c..5eec207 100644
--- a/drivers/sh/Makefile
+++ b/drivers/sh/Makefile
@@ -9,5 +9,3 @@ endif
 
 obj-$(CONFIG_MAPLE)		+= maple/
 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
-
-obj-y				+= pm_runtime.o
diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
deleted file mode 100644
index f4f8851..0000000
--- a/drivers/sh/pm_runtime.c
+++ /dev/null
@@ -1,60 +0,0 @@
-/*
- * Runtime PM support code
- *
- *  Copyright (C) 2009-2010 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/pm_runtime.h>
-#include <linux/pm_domain.h>
-#include <linux/pm_clock.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/sh_clk.h>
-#include <linux/bitmap.h>
-#include <linux/slab.h>
-
-#ifdef CONFIG_PM_RUNTIME
-static struct dev_pm_domain default_pm_domain = {
-	.ops = {
-		.runtime_suspend = pm_clk_suspend,
-		.runtime_resume = pm_clk_resume,
-		USE_PLATFORM_PM_SLEEP_OPS
-	},
-};
-
-#define DEFAULT_PM_DOMAIN_PTR	(&default_pm_domain)
-
-#else
-
-#define DEFAULT_PM_DOMAIN_PTR	NULL
-
-#endif /* CONFIG_PM_RUNTIME */
-
-static struct pm_clk_notifier_block platform_bus_notifier = {
-	.pm_domain = DEFAULT_PM_DOMAIN_PTR,
-	.con_ids = { NULL, },
-};
-
-static bool default_pm_on;
-
-int __init sh_pm_runtime_init(void)
-{
-	default_pm_on = true;
-	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
-	return 0;
-}
-
-static int __init sh_pm_runtime_late_init(void)
-{
-	if (default_pm_on)
-		pm_genpd_poweroff_unused();
-	return 0;
-}
-late_initcall(sh_pm_runtime_late_init);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 16f6654..1551ea5 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -326,4 +326,6 @@ extern int platform_pm_restore(struct device *dev);
 #define USE_PLATFORM_PM_SLEEP_OPS
 #endif
 
+extern int platformbus_pm_runtime_init(void);
+
 #endif /* _PLATFORM_DEVICE_H_ */
-- 
1.9.0

