From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 10:16:15 +0000
Subject: [PATCH 03/08] sh: Convert sh7343 and se7343 to mem_init
Message-Id: <20110106101615.1617.36530.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh7343 to use shmobile_memchunk_setup().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-se/7343/setup.c    |    2 ++
 arch/sh/include/cpu-sh4/cpu/sh7343.h   |    6 ++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   13 +++++++++----
 3 files changed, 17 insertions(+), 4 deletions(-)

--- 0001/arch/sh/boards/mach-se/7343/setup.c
+++ work/arch/sh/boards/mach-se/7343/setup.c	2011-01-06 18:26:30.000000000 +0900
@@ -10,6 +10,7 @@
 #include <asm/heartbeat.h>
 #include <asm/irq.h>
 #include <asm/io.h>
+#include <cpu/sh7343.h>
 
 static struct resource heartbeat_resource = {
 	.start	= PA_LED,
@@ -176,4 +177,5 @@ static struct sh_machine_vector mv_7343s
 	.mv_name = "SolutionEngine 7343",
 	.mv_setup = sh7343se_setup,
 	.mv_init_irq = init_7343se_IRQ,
+	.mv_mem_init = sh7343_mem_init,
 };
--- /dev/null
+++ work/arch/sh/include/cpu-sh4/cpu/sh7343.h	2011-01-06 18:24:39.000000000 +0900
@@ -0,0 +1,6 @@
+#ifndef __ASM_SH7343_H__
+#define __ASM_SH7343_H__
+
+void sh7343_mem_init(void);
+
+#endif /* __ASM_SH7343_H__ */
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2011-01-06 18:25:26.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/uio_driver.h>
 #include <linux/sh_timer.h>
 #include <asm/clock.h>
+#include <cpu/sh7343.h>
 
 /* Serial */
 static struct plat_sci_port scif0_platform_data = {
@@ -332,10 +333,6 @@ static struct platform_device *sh7343_de
 
 static int __init sh7343_devices_setup(void)
 {
-	platform_resource_setup_memory(&vpu_device, "vpu", 1 << 20);
-	platform_resource_setup_memory(&veu_device, "veu", 2 << 20);
-	platform_resource_setup_memory(&jpu_device, "jpu", 2 << 20);
-
 	return platform_add_devices(sh7343_devices,
 				    ARRAY_SIZE(sh7343_devices));
 }
@@ -358,6 +355,14 @@ void __init plat_early_device_setup(void
 				   ARRAY_SIZE(sh7343_early_devices));
 }
 
+void __init sh7343_mem_init(void)
+{
+	generic_mem_init();
+	shmobile_memchunk_setup(&vpu_device, "vpu", 1 << 20);
+	shmobile_memchunk_setup(&veu_device, "veu", 2 << 20);
+	shmobile_memchunk_setup(&jpu_device, "jpu", 2 << 20);
+}
+
 enum {
 	UNUSED = 0,
 
