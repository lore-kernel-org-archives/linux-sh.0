From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 06 Jun 2014 05:29:04 +0000
Subject: [PATCH v2 03/03] ARM: shmobile: Use shmobile_init_delay() on r7s72100
Message-Id: <20140606052904.17594.43724.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the r7s72100 SoC support code to use shmobile_init_delay()
together with CPU Frequency settings from the DTS. Get rid of the
C code version.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/r7s72100.h |    1 -
 arch/arm/mach-shmobile/setup-r7s72100.c        |    7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/r7s72100.h
+++ work/arch/arm/mach-shmobile/include/mach/r7s72100.h	2014-05-29 17:53:06.000000000 +0900
@@ -3,6 +3,5 @@
 
 void r7s72100_add_dt_devices(void);
 void r7s72100_clock_init(void);
-void r7s72100_init_early(void);
 
 #endif /* __ASM_R7S72100_H__ */
--- 0001/arch/arm/mach-shmobile/setup-r7s72100.c
+++ work/arch/arm/mach-shmobile/setup-r7s72100.c	2014-05-29 17:53:00.000000000 +0900
@@ -43,11 +43,6 @@ void __init r7s72100_add_dt_devices(void
 	r7s72100_register_mtu2();
 }
 
-void __init r7s72100_init_early(void)
-{
-	shmobile_setup_delay(400, 1, 3); /* Cortex-A9 @ 400MHz */
-}
-
 #ifdef CONFIG_USE_OF
 static const char *r7s72100_boards_compat_dt[] __initdata = {
 	"renesas,r7s72100",
@@ -55,7 +50,7 @@ static const char *r7s72100_boards_compa
 };
 
 DT_MACHINE_START(R7S72100_DT, "Generic R7S72100 (Flattened Device Tree)")
-	.init_early	= r7s72100_init_early,
+	.init_early	= shmobile_init_delay,
 	.dt_compat	= r7s72100_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
