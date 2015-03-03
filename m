From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Tue, 03 Mar 2015 01:20:22 +0000
Subject: [PATCH 1/5] ARM: shmobile: r8a7794 SYSC setup code
Message-Id: <54F50C56.5030605@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add r8a7794 SYSC power management support.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---
 arch/arm/mach-shmobile/Makefile     |    2 +-
 arch/arm/mach-shmobile/pm-r8a7794.c |   44 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/r8a7794.h    |    6 +++++
 3 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-shmobile/pm-r8a7794.c
 create mode 100644 arch/arm/mach-shmobile/r8a7794.h

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index d3aca07..cde95f8 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o pm-r8a7790.o
 obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o pm-r8a7791.o
-obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o
+obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o pm-r8a7794.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
 
diff --git a/arch/arm/mach-shmobile/pm-r8a7794.c b/arch/arm/mach-shmobile/pm-r8a7794.c
new file mode 100644
index 0000000..a8a94cf
--- /dev/null
+++ b/arch/arm/mach-shmobile/pm-r8a7794.c
@@ -0,0 +1,44 @@
+/*
+ * r8a7794 Power management support
+ *
+ * Copyright (C) 2015  Renesas Electronics Corporation
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <asm/io.h>
+#include "pm-rcar.h"
+#include "r8a7794.h"
+
+/* SYSC */
+#define SYSCIER 0x0c
+#define SYSCIMR 0x10
+
+#if defined(CONFIG_SMP)
+
+static void __init r8a7794_sysc_init(void)
+{
+	void __iomem *base = rcar_sysc_init(0xe6180000);
+
+	/* enable all interrupt sources, but do not use interrupt handler */
+	iowrite32(0x00310060, base + SYSCIER);
+	iowrite32(0, base + SYSCIMR);
+}
+
+#else /* CONFIG_SMP */
+
+static inline void r8a7794_sysc_init(void) {}
+
+#endif /* CONFIG_SMP */
+
+void __init r8a7794_pm_init(void)
+{
+	static int once;
+
+	if (once++)
+		return;
+
+	r8a7794_sysc_init();
+}
diff --git a/arch/arm/mach-shmobile/r8a7794.h b/arch/arm/mach-shmobile/r8a7794.h
new file mode 100644
index 0000000..b83d387
--- /dev/null
+++ b/arch/arm/mach-shmobile/r8a7794.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_R8A7794_H__
+#define __ASM_R8A7794_H__
+
+void r8a7794_pm_init(void);
+
+#endif /* __ASM_R8A7794_H__ */
-- 
1.7.9.5

