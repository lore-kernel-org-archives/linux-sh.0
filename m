From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 10:16:59 +0000
Subject: [PATCH 08/08] sh: Move new memblock reservation code to drivers/sh
Message-Id: <20110106101659.1617.32582.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Move the new physically contiguous memory reservation
code from arch/sh into drivers/sh/memchunk.c to it can
be shared with SH-Mobile / R-Mobile ARM processors.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/mm/consistent.c |   58 ----------------------------------
 drivers/sh/Makefile     |    1 
 drivers/sh/memchunk.c   |   78 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 58 deletions(-)

--- 0012/arch/sh/mm/consistent.c
+++ work/arch/sh/mm/consistent.c	2011-01-06 18:45:52.000000000 +0900
@@ -17,7 +17,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/gfp.h>
-#include <linux/memblock.h>
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
 
@@ -100,60 +99,3 @@ void dma_cache_sync(struct device *dev, 
 	}
 }
 EXPORT_SYMBOL(dma_cache_sync);
-
-static int __init memchunk_setup(char *str)
-{
-	return 1; /* accept anything that begins with "memchunk." */
-}
-__setup("memchunk.", memchunk_setup);
-
-static void __init memchunk_cmdline_override(char *name, unsigned long *sizep)
-{
-	char *p = boot_command_line;
-	int k = strlen(name);
-
-	while ((p = strstr(p, "memchunk."))) {
-		p += 9; /* strlen("memchunk.") */
-		if (!strncmp(name, p, k) && p[k] = '=') {
-			p += k + 1;
-			*sizep = memparse(p, NULL);
-			pr_info("%s: forcing memory chunk size to 0x%08lx\n",
-				name, *sizep);
-			break;
-		}
-	}
-}
-
-int __init shmobile_memchunk_setup(struct platform_device *pdev,
-				   char *name, unsigned long memsize)
-{
-	struct resource *r;
-	u64 addr;
-
-	r = pdev->resource + pdev->num_resources - 1;
-	if (r->flags) {
-		pr_warning("%s: unable to find empty space for resource\n",
-			name);
-		return -EINVAL;
-	}
-
-	memchunk_cmdline_override(name, &memsize);
-	if (!memsize)
-		return 0;
-
-	addr = memblock_alloc(memsize, PAGE_SIZE);
-	if (addr = ~(u64)0) {
-		pr_warning("%s: unable to allocate memory\n", name);
-		return -ENOMEM;
-	}
-	memblock_free(addr, memsize);
-	memblock_remove(addr, memsize);
-
-	r->flags = IORESOURCE_MEM;
-	r->start = addr;
-	r->end = r->start + memsize - 1;
-	r->name = name;
-	return 0;
-}
-
-
--- 0001/drivers/sh/Makefile
+++ work/drivers/sh/Makefile	2011-01-06 18:44:42.000000000 +0900
@@ -7,3 +7,4 @@ obj-$(CONFIG_HAVE_CLK)		+= clk/
 obj-$(CONFIG_MAPLE)		+= maple/
 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
 obj-$(CONFIG_GENERIC_GPIO)	+= pfc.o
+obj-$(CONFIG_ARCH_SHMOBILE)	+= memchunk.o
--- /dev/null
+++ work/drivers/sh/memchunk.c	2011-01-06 18:45:19.000000000 +0900
@@ -0,0 +1,78 @@
+/*
+ * SH-Mobile "memchunk" - Physically contiguous memory reservation code
+ *
+ * Copyright (C) 2011  Magnus Damm
+ * Copyright (C) 2004 - 2007  Paul Mundt
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/memblock.h>
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
+int __init shmobile_memchunk_setup(struct platform_device *pdev,
+				   char *name, unsigned long memsize)
+{
+	struct resource *r;
+	u64 addr;
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
+	addr = memblock_alloc(memsize, PAGE_SIZE);
+	if (addr = ~(u64)0) {
+		pr_warning("%s: unable to allocate memory\n", name);
+		return -ENOMEM;
+	}
+	memblock_free(addr, memsize);
+	memblock_remove(addr, memsize);
+
+	r->flags = IORESOURCE_MEM;
+	r->start = addr;
+	r->end = r->start + memsize - 1;
+	r->name = name;
+	return 0;
+}
