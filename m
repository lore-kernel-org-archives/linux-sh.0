From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Dec 2012 22:54:12 +0000
Subject: [PATCH v4 30/81] sh: Add PFC platform device registration helper function
Message-Id: <1356735303-29474-31-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sh_pfc_register() function can be called by boards or SoC setup code
to register the PFC platform device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/sh/include/cpu-common/cpu/pfc.h |   30 +++++++++++++++++++++++
 arch/sh/kernel/cpu/Makefile          |    2 +-
 arch/sh/kernel/cpu/pfc.c             |   44 ++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletions(-)
 create mode 100644 arch/sh/include/cpu-common/cpu/pfc.h
 create mode 100644 arch/sh/kernel/cpu/pfc.c

diff --git a/arch/sh/include/cpu-common/cpu/pfc.h b/arch/sh/include/cpu-common/cpu/pfc.h
new file mode 100644
index 0000000..40e8643
--- /dev/null
+++ b/arch/sh/include/cpu-common/cpu/pfc.h
@@ -0,0 +1,30 @@
+/*
+ * SH Pin Function Control Initialization
+ *
+ * Copyright (C) 2012  Renesas Solutions Corp.
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
+#ifndef __ARCH_SH_CPU_PFC_H__
+#define __ARCH_SH_CPU_PFC_H__
+
+#include <linux/types.h>
+
+struct pinmux_info;
+struct resource;
+
+int sh_pfc_register(const char *name,
+		    struct resource *resource, u32 num_resources);
+int sh_pfc_register_info(const char *name,
+			 struct resource *resource, u32 num_resources,
+			 struct pinmux_info *pdata);
+
+#endif /* __ARCH_SH_CPU_PFC_H__ */
diff --git a/arch/sh/kernel/cpu/Makefile b/arch/sh/kernel/cpu/Makefile
index fa58bfd..accc7ca 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -18,4 +18,4 @@ obj-$(CONFIG_ARCH_SHMOBILE)	+= shmobile/
 obj-$(CONFIG_SH_ADC)		+= adc.o
 obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
 
-obj-y	+= irq/ init.o clock.o fpu.o proc.o
+obj-y	+= irq/ init.o clock.o fpu.o pfc.o proc.o
diff --git a/arch/sh/kernel/cpu/pfc.c b/arch/sh/kernel/cpu/pfc.c
new file mode 100644
index 0000000..d045d75
--- /dev/null
+++ b/arch/sh/kernel/cpu/pfc.c
@@ -0,0 +1,44 @@
+/*
+ * SH Pin Function Control Initialization
+ *
+ * Copyright (C) 2012  Renesas Solutions Corp.
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
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <cpu/pfc.h>
+
+static struct platform_device sh_pfc_device = {
+	.name		= "sh-pfc",
+	.id		= -1,
+};
+
+int __init sh_pfc_register(const char *name,
+			   struct resource *resource, u32 num_resources)
+{
+	if (name)
+		sh_pfc_device.name = name;
+	sh_pfc_device.num_resources = num_resources;
+	sh_pfc_device.resource = resource;
+
+	return platform_device_register(&sh_pfc_device);
+}
+
+int __init sh_pfc_register_info(const char *name,
+				struct resource *resource, u32 num_resources,
+				struct pinmux_info *pdata)
+{
+	sh_pfc_device.dev.platform_data = pdata;
+
+	return sh_pfc_register(name, resource, num_resources);
+}
-- 
1.7.8.6

