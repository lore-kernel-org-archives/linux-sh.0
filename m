From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Apr 2009 10:50:21 +0000
Subject: [PATCH 03/05] sh: Add plat_early_device_setup()
Message-Id: <20090415105021.29940.78289.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add a plat_early_device_setup() function to allow
processor-specific code to register Early Platform Data.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/device.h |    2 ++
 arch/sh/kernel/setup.c       |    7 +++++++
 2 files changed, 9 insertions(+)

--- 0001/arch/sh/include/asm/device.h
+++ work/arch/sh/include/asm/device.h	2009-01-22 17:03:40.000000000 +0900
@@ -10,3 +10,5 @@ struct platform_device;
 int platform_resource_setup_memory(struct platform_device *pdev,
 				   char *name, unsigned long memsize);
 
+void plat_early_device_setup(void);
+
--- 0001/arch/sh/kernel/setup.c
+++ work/arch/sh/kernel/setup.c	2009-01-22 17:06:39.000000000 +0900
@@ -29,6 +29,7 @@
 #include <linux/mmzone.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/page.h>
@@ -329,6 +330,10 @@ static int __init parse_elfcorehdr(char 
 early_param("elfcorehdr", parse_elfcorehdr);
 #endif
 
+void __init __attribute__ ((weak)) plat_early_device_setup(void)
+{
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	enable_mmu();
@@ -382,6 +387,8 @@ void __init setup_arch(char **cmdline_p)
 
 	parse_early_param();
 
+	plat_early_device_setup();
+
 	sh_mv_setup();
 
 	/*
