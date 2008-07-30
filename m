From: Simon Horman <horms@verge.net.au>
Date: Wed, 30 Jul 2008 00:29:39 +0000
Subject: [patch] kdump: sh: parse elfcorehdr command line argument
Message-Id: <20080730002937.GA21998@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Vivek Goyal <vgoyal@redhat.com>, Paul Mundt <lethal@linux-sh.org>

A quick cut and paste from other architectures to allow SH
to parse the elfcorehdr command line argument which is required
for both is_kdump_kernel() and vmcore to function.
(the former is as yet unused on SH).

Tested compilation only

Signed-off-by: Simon Horman <horms@verge.net.au>

Index: linux-2.6/arch/sh/kernel/setup.c
=================================--- linux-2.6.orig/arch/sh/kernel/setup.c	2008-07-30 09:33:45.000000000 +1000
+++ linux-2.6/arch/sh/kernel/setup.c	2008-07-30 09:37:45.000000000 +1000
@@ -25,6 +25,7 @@
 #include <linux/smp.h>
 #include <linux/err.h>
 #include <linux/debugfs.h>
+#include <linux/crash_dump.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/page.h>
@@ -286,6 +287,25 @@ static void __init setup_memory(void)
 extern void __init setup_memory(void);
 #endif
 
+/*
+ * Note: elfcorehdr_addr is not just limited to vmcore. It is also used by
+ * is_kdump_kernel() to determine if we are booting after a panic. Hence
+ * ifdef it under CONFIG_CRASH_DUMP and not CONFIG_PROC_VMCORE.
+ */
+#ifdef CONFIG_CRASH_DUMP
+/* elfcorehdr= specifies the location of elf core header
+ * stored by the crashed kernel.
+ */
+static int __init parse_elfcorehdr(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+	elfcorehdr_addr = memparse(arg, &arg);
+	return 0;
+}
+early_param("elfcorehdr", parse_elfcorehdr);
+#endif
+
 void __init setup_arch(char **cmdline_p)
 {
 	enable_mmu();
