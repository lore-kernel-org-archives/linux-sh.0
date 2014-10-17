From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 17 Oct 2014 12:24:38 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7778: Remove wrapper r8a7778_init_delay()
Message-Id: <1413548679-12391-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

r8a7778_init_delay() just calls shmobile_init_delay(), hence replace
calls to it by direct calls to shmobile_init_delay().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/r8a7778.h       | 1 -
 arch/arm/mach-shmobile/setup-r8a7778.c | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/r8a7778.h b/arch/arm/mach-shmobile/r8a7778.h
index f4076a50e970a357..4802cee250bea893 100644
--- a/arch/arm/mach-shmobile/r8a7778.h
+++ b/arch/arm/mach-shmobile/r8a7778.h
@@ -71,7 +71,6 @@ extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_dt_devices(void);
 
 extern void r8a7778_init_late(void);
-extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 85fe016d6a872a62..97eac8703d4d8ee7 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -572,11 +572,6 @@ void __init r8a7778_init_irq_extpin(int irlm)
 			&irqpin_platform_data, sizeof(irqpin_platform_data));
 }
 
-void __init r8a7778_init_delay(void)
-{
-	shmobile_init_delay();
-}
-
 #ifdef CONFIG_USE_OF
 #define INT2SMSKCR0	0x82288 /* 0xfe782288 */
 #define INT2SMSKCR1	0x8228c /* 0xfe78228c */
@@ -608,7 +603,7 @@ static const char *r8a7778_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
-	.init_early	= r8a7778_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7778_compat_dt,
-- 
1.9.1

