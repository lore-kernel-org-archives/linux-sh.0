From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Oct 2010 09:21:52 +0000
Subject: [PATCH] ARM: mach-shmobile: Add memchunk support V2
Message-Id: <20101014092152.2046.29572.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SH-Mobile ARM support for "memchunk" V2. The code is based
on the SH implementation but has been slightly modified to use 
memblock for physical memory reservation.

The function shmobile_memchunk_setup() should be called during
boot from the ->reserve() callback in struct machine_desc.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile              |    1 
 arch/arm/mach-shmobile/include/mach/common.h |    3 +
 arch/arm/mach-shmobile/memchunk.c            |   76 ++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

--- 0008/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-10-14 17:44:33.000000000 +0900
@@ -4,6 +4,7 @@
 
 # Common objects
 obj-y				:= timer.o console.o clock.o pm_runtime.o
+obj-y				+= memchunk.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_AP45)		+= head-ap45.o
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-10-14 17:53:04.000000000 +0900
@@ -3,6 +3,9 @@
 
 extern struct sys_timer shmobile_timer;
 extern void shmobile_setup_console(void);
+struct platform_device;
+extern int shmobile_memchunk_setup(struct platform_device *pdev,
+				   char *name, unsigned long memsize);
 struct clk;
 extern int clk_init(void);
 
--- /dev/null
+++ work/arch/arm/mach-shmobile/memchunk.c	2010-10-14 17:53:22.000000000 +0900
@@ -0,0 +1,76 @@
+/*
+ * SH-Mobile "memchunk" - Physically contiguous memory reservation code
+ *
+ * Copyright (C) 2010  Magnus Damm
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
+#include <mach/common.h>
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
+
+	r->flags = IORESOURCE_MEM;
+	r->start = addr;
+	r->end = r->start + memsize - 1;
+	r->name = name;
+	return 0;
+}
