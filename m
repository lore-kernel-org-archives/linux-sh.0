From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:33:57 +0000
Subject: [PATCH v2 01/17] ARM: shmobile: r8a7740: Remove unused r8a7740_add_early_devices_dt()
Message-Id: <1397565253-22741-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It was removed in commit 744fdc8dc0e22cc5b61ee1bcde9375f188daa330 ("ARM:
shmobile: r8a7740: Prepare for reference DT setup"), but accidentally
resurrected in commit 88378837780166d67a11142cd6f76596c0a2d8c3 ("ARM:
shmobile: Remove unused r8a7740 auxdata table").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New

 arch/arm/mach-shmobile/setup-r8a7740.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 8f3c68101d59..cba3a07a97c2 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -869,17 +869,6 @@ void __init r8a7740_add_early_devices(void)
 
 #ifdef CONFIG_USE_OF
 
-void __init r8a7740_add_early_devices_dt(void)
-{
-	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
-
-	early_platform_add_devices(r8a7740_early_devices,
-				   ARRAY_SIZE(r8a7740_early_devices));
-
-	/* setup early console here as well */
-	shmobile_setup_console();
-}
-
 void __init r8a7740_add_standard_devices_dt(void)
 {
 	platform_add_devices(r8a7740_devices_dt,
-- 
1.7.9.5

