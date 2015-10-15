From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 15 Oct 2015 06:59:32 +0000
Subject: [PATCH/RFC 1/6] boot-mode-reg: Add core
Message-Id: <1444892377-10170-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The motivation for this new module is to add a small frame work to allow
kernel subsystems to obtain boot mode information from a centralised
source using a new, and hopefully soon well-known, API.

The new API consists of two function calls and nothing more:

boot_mode_reg_set: Should be called by platform-specific drivers
                   to register the boot mode register value which
		   they obtain from hardware or otherwise.

boot_mode_reg_get: Should be called by consumers; subsystems that
                   wish to know he boot mode register.

The boot mode register is a 32bit unsigned entity,
the meaning of its values are implementation dependent.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 MAINTAINERS                         |  1 +
 drivers/misc/Kconfig                |  1 +
 drivers/misc/Makefile               |  1 +
 drivers/misc/boot-mode-reg/Kconfig  | 11 ++++++
 drivers/misc/boot-mode-reg/Makefile |  6 +++
 drivers/misc/boot-mode-reg/core.c   | 78 +++++++++++++++++++++++++++++++++++++
 include/misc/boot-mode-reg.h        | 24 ++++++++++++
 7 files changed, 122 insertions(+)
 create mode 100644 drivers/misc/boot-mode-reg/Kconfig
 create mode 100644 drivers/misc/boot-mode-reg/Makefile
 create mode 100644 drivers/misc/boot-mode-reg/core.c
 create mode 100644 include/misc/boot-mode-reg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e711675afbf7..3a0de82e617f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1495,6 +1495,7 @@ F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
 F:	drivers/sh/
+F:	drivers/misc/boot-mode-reg/
 
 ARM/SOCFPGA ARCHITECTURE
 M:	Dinh Nguyen <dinguyen@opensource.altera.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index ccccc2943f2f..b6aa60cb8460 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -537,4 +537,5 @@ source "drivers/misc/mic/Kconfig"
 source "drivers/misc/genwqe/Kconfig"
 source "drivers/misc/echo/Kconfig"
 source "drivers/misc/cxl/Kconfig"
+source "drivers/misc/boot-mode-reg/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 537d7f3b78da..0d1e8910c033 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -56,3 +56,4 @@ obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_BOOT_MODE_REG_CORE)	+= boot-mode-reg/
diff --git a/drivers/misc/boot-mode-reg/Kconfig b/drivers/misc/boot-mode-reg/Kconfig
new file mode 100644
index 000000000000..806eba24238f
--- /dev/null
+++ b/drivers/misc/boot-mode-reg/Kconfig
@@ -0,0 +1,11 @@
+#
+# Boot Mode Register Drivers
+#
+
+config BOOT_MODE_REG_CORE
+	tristate "Boot Mode Register Core Driver"
+	default n
+	depends on ARCH_SHMOBILE || COMPILE_TEST
+	help
+	  Say Y here to allow support for drivers to read boot mode
+	  registers and make the value available to other subsystems.
diff --git a/drivers/misc/boot-mode-reg/Makefile b/drivers/misc/boot-mode-reg/Makefile
new file mode 100644
index 000000000000..19134b20a7f1
--- /dev/null
+++ b/drivers/misc/boot-mode-reg/Makefile
@@ -0,0 +1,6 @@
+
+#
+# Makefile for misc devices that really don't fit anywhere else.
+#
+
+obj-$(CONFIG_BOOT_MODE_REG_CORE)	+= core.o
diff --git a/drivers/misc/boot-mode-reg/core.c b/drivers/misc/boot-mode-reg/core.c
new file mode 100644
index 000000000000..9d7d72f52132
--- /dev/null
+++ b/drivers/misc/boot-mode-reg/core.c
@@ -0,0 +1,78 @@
+/*
+ * Boot Mode Register
+ *
+ * Copyright (C) 2015 Simon Horman
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <asm/errno.h>
+
+#include <linux/export.h>
+#include <linux/module.h>
+
+#include <misc/boot-mode-reg.h>
+
+static DEFINE_MUTEX(boot_mode_mutex);
+static bool boot_mode_is_set;
+static u32 boot_mode;
+
+/**
+ * boot_mode_reg_get() - retrieve boot mode register value
+ * @mode: implementation-dependent boot mode register value
+ *
+ * Retrieves the boot mode register value previously registered
+ * using boot_mode_reg_set().
+ *
+ * return: 0 on success
+ */
+int boot_mode_reg_get(u32 *mode)
+{
+	int err = -ENOENT;
+
+	mutex_lock(&boot_mode_mutex);
+	if (!boot_mode_is_set)
+		goto err;
+	*mode = boot_mode;
+	err = 0;
+err:
+	mutex_unlock(&boot_mode_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(boot_mode_get);
+
+/**
+ * boot_mode_reg_set() - record boot mode register value
+ * @mode: implementation-dependent boot mode register value
+ *
+ * Records the boot mode register value which may subsequently
+ * be retrieved using boot_mode_reg_get().
+ *
+ * return: 0 on success
+ */
+int boot_mode_reg_set(u32 mode)
+{
+	int err = -EBUSY;
+
+	mutex_lock(&boot_mode_mutex);
+	if (boot_mode_is_set && boot_mode != mode)
+		goto err;
+	boot_mode = mode;
+	boot_mode_is_set = true;
+	err = 0;
+err:
+	mutex_unlock(&boot_mode_mutex);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(boot_mode_set);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Simon Horman <horms@verge.net.au>");
+MODULE_DESCRIPTION("Core Boot Mode Register Driver");
diff --git a/include/misc/boot-mode-reg.h b/include/misc/boot-mode-reg.h
new file mode 100644
index 000000000000..34ee653279a4
--- /dev/null
+++ b/include/misc/boot-mode-reg.h
@@ -0,0 +1,24 @@
+/*
+ * Boot Mode Register
+ *
+ * Copyright (C) 2015 Simon Horman
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _BOOT_MODE_REG_H
+#define _BOOT_MODE_REG_H
+
+#include <linux/types.h>
+
+int boot_mode_reg_get(u32 *mode);
+int boot_mode_reg_set(u32 mode);
+
+#endif
-- 
2.1.4

