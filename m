From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 10:16:06 +0000
Subject: [PATCH 02/08] sh: Convert sh7366 to mem_init
Message-Id: <20110106101606.1617.88477.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh7366 to use shmobile_memchunk_setup().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/cpu-sh4/cpu/sh7366.h   |    6 ++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   13 +++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

--- /dev/null
+++ work/arch/sh/include/cpu-sh4/cpu/sh7366.h	2011-01-06 18:33:25.000000000 +0900
@@ -0,0 +1,6 @@
+#ifndef __ASM_SH7366_H__
+#define __ASM_SH7366_H__
+
+void sh7366_mem_init(void);
+
+#endif /* __ASM_SH7366_H__ */
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2011-01-06 18:33:35.000000000 +0900
@@ -17,6 +17,7 @@
 #include <linux/sh_timer.h>
 #include <linux/usb/r8a66597.h>
 #include <asm/clock.h>
+#include <cpu/sh7366.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xffe00000,
@@ -294,10 +295,6 @@ static struct platform_device *sh7366_de
 
 static int __init sh7366_devices_setup(void)
 {
-	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
-	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
-	platform_resource_setup_memory(&veu1_device, "veu1", 2 << 20);
-
 	return platform_add_devices(sh7366_devices,
 				    ARRAY_SIZE(sh7366_devices));
 }
@@ -317,6 +314,14 @@ void __init plat_early_device_setup(void
 				   ARRAY_SIZE(sh7366_early_devices));
 }
 
+void __init sh7366_mem_init(void)
+{
+	generic_mem_init();
+	shmobile_memchunk_setup(&vpu_device, "vpu", 2 << 20);
+	shmobile_memchunk_setup(&veu0_device, "veu0", 2 << 20);
+	shmobile_memchunk_setup(&veu1_device, "veu1", 2 << 20);
+}
+
 enum {
 	UNUSED=0,
 
