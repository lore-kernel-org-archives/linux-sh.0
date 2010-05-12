From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 May 2010 08:34:51 +0000
Subject: [PATCH 01/05] ARM: mach-shmobile: Add memchunk support
Message-Id: <20100512083451.9395.54283.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SH-Mobile ARM support for "memchunk". The code is taken
straight from the SH architecture.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile              |    2 
 arch/arm/mach-shmobile/include/mach/common.h |    4 +
 arch/arm/mach-shmobile/memory.c              |   74 ++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-05-12 15:50:29.000000000 +0900
@@ -3,7 +3,7 @@
 #
 
 # Common objects
-obj-y				:= timer.o console.o
+obj-y				:= timer.o console.o memory.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-05-12 15:50:15.000000000 +0900
@@ -4,6 +4,10 @@
 extern struct sys_timer shmobile_timer;
 extern void shmobile_setup_console(void);
 
+/* allocate contiguous memory chunk and fill in struct resource */
+extern int platform_resource_setup_memory(struct platform_device *pdev,
+					  char *name, unsigned long memsize);
+
 extern void sh7367_init_irq(void);
 extern void sh7367_add_early_devices(void);
 extern void sh7367_add_standard_devices(void);
--- /dev/null
+++ work/arch/arm/mach-shmobile/memory.c	2010-05-12 15:50:16.000000000 +0900
@@ -0,0 +1,74 @@
+/*
+ * arch/sh/mm/consistent.c
+ *
+ * Copyright (C) 2004 - 2007  Paul Mundt
+ *
+ * Declared coherent memory functions based on arch/x86/kernel/pci-dma_32.c
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-debug.h>
+#include <linux/io.h>
+#include <linux/module.h>
+
+static int __init memchunk_setup(char *str)
+{
+	return 1; /* accept anything that begins with "memchunk." */
+}
+__setup("memchunk.", memchunk_setup);
+
+static void __init memchunk_cmdline_override(char *name, unsigned long *sizep)
+{
+	char *p = boot_command_line;
+	int k = strlen(name);
+
+	while ((p = strstr(p, "memchunk."))) {
+		p += 9; /* strlen("memchunk.") */
+		if (!strncmp(name, p, k) && p[k] = '=') {
+			p += k + 1;
+			*sizep = memparse(p, NULL);
+			pr_info("%s: forcing memory chunk size to 0x%08lx\n",
+				name, *sizep);
+			break;
+		}
+	}
+}
+
+int __init platform_resource_setup_memory(struct platform_device *pdev,
+					  char *name, unsigned long memsize)
+{
+	struct resource *r;
+	dma_addr_t dma_handle;
+	void *buf;
+
+	r = pdev->resource + pdev->num_resources - 1;
+	if (r->flags) {
+		pr_warning("%s: unable to find empty space for resource\n",
+			name);
+		return -EINVAL;
+	}
+
+	memchunk_cmdline_override(name, &memsize);
+	if (!memsize)
+		return 0;
+
+	buf = dma_alloc_coherent(NULL, memsize, &dma_handle, GFP_KERNEL);
+	if (!buf) {
+		pr_warning("%s: unable to allocate memory\n", name);
+		return -ENOMEM;
+	}
+
+	memset(buf, 0, memsize);
+
+	r->flags = IORESOURCE_MEM;
+	r->start = dma_handle;
+	r->end = r->start + memsize - 1;
+	r->name = name;
+	return 0;
+}
