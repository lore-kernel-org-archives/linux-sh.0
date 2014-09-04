From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 04 Sep 2014 14:02:28 +0000
Subject: [PATCH v3 2/4] ARM: shmobile: Initial r8a7794 SoC support
Message-Id: <1409839350-1245-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Initial support for the r8a7794 SoC, based on work by Hisashi Nakamura.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/mach-shmobile/Kconfig         |  4 ++++
 arch/arm/mach-shmobile/Makefile        |  1 +
 arch/arm/mach-shmobile/setup-r8a7794.c | 35 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7794.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index f400a8c..21f457b 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -67,6 +67,10 @@ config ARCH_R8A7791
 	bool "R-Car M2-W (R8A77910)"
 	select ARCH_RCAR_GEN2
 
+config ARCH_R8A7794
+	bool "R-Car E2 (R8A77940)"
+	select ARCH_RCAR_GEN2
+
 comment "Renesas ARM SoCs Board Type"
 
 config MACH_KOELSCH
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index f9bc4fb..e20f278 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o pm-r8a7790.o
 obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o pm-r8a7791.o
+obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7794.c b/arch/arm/mach-shmobile/setup-r8a7794.c
new file mode 100644
index 0000000..05e970c
--- /dev/null
+++ b/arch/arm/mach-shmobile/setup-r8a7794.c
@@ -0,0 +1,35 @@
+/*
+ * r8a7794 processor support
+ *
+ * Copyright (C) 2014  Renesas Electronics Corporation
+ * Copyright (C) 2014  Ulrich Hecht
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
+#include <linux/of_platform.h>
+#include "common.h"
+#include "rcar-gen2.h"
+#include <asm/mach/arch.h>
+
+#ifdef CONFIG_USE_OF
+
+static const char * const r8a7794_boards_compat_dt[] __initconst = {
+	"renesas,r8a7794",
+	NULL,
+};
+
+DT_MACHINE_START(R8A7794_DT, "Generic R8A7794 (Flattened Device Tree)")
+	.init_early	= shmobile_init_delay,
+	.init_late	= shmobile_init_late,
+	.init_time	= rcar_gen2_timer_init,
+	.dt_compat	= r8a7794_boards_compat_dt,
+MACHINE_END
+#endif /* CONFIG_USE_OF */
-- 
1.8.4.5

