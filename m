From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:03:03 +0000
Subject: [PATCH 07/10] ARM: shmobile: r8a73a4: Use shmobile_init_delay()
Message-Id: <20140820130303.32075.55636.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the r8a73a4 SoC support code to use shmobile_init_delay()
together with CPU Frequency settings from the DTS. Get rid of the
C code version and r8a73a4_init_early() that now are unused.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/r8a73a4.h       |    1 -
 arch/arm/mach-shmobile/setup-r8a73a4.c |    9 +--------
 2 files changed, 1 insertion(+), 9 deletions(-)

--- 0001/arch/arm/mach-shmobile/r8a73a4.h
+++ work/arch/arm/mach-shmobile/r8a73a4.h	2014-08-20 19:38:27.000000000 +0900
@@ -14,6 +14,5 @@ void r8a73a4_add_standard_devices(void);
 void r8a73a4_add_dt_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
-void r8a73a4_init_early(void);
 
 #endif /* __ASM_R8A73A4_H__ */
--- 0001/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2014-08-20 19:38:35.000000000 +0900
@@ -295,13 +295,6 @@ void __init r8a73a4_add_standard_devices
 	r8a73a4_register_dmac();
 }
 
-void __init r8a73a4_init_early(void)
-{
-#ifndef CONFIG_ARM_ARCH_TIMER
-	shmobile_setup_delay(1500, 2, 4); /* Cortex-A15 @ 1500MHz */
-#endif
-}
-
 #ifdef CONFIG_USE_OF
 
 static const char *r8a73a4_boards_compat_dt[] __initdata = {
@@ -310,7 +303,7 @@ static const char *r8a73a4_boards_compat
 };
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
-	.init_early	= r8a73a4_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a73a4_boards_compat_dt,
 MACHINE_END
