From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:33:59 +0000
Subject: [PATCH v2 03/17] ARM: shmobile: sh7372: Call sh7372_add_early_devices() instead of open coding
Message-Id: <1397565253-22741-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New

 arch/arm/mach-shmobile/setup-sh7372.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 27301278c208..f8176b051be4 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1037,11 +1037,7 @@ void __init sh7372_add_early_devices_dt(void)
 {
 	shmobile_setup_delay(800, 1, 3); /* Cortex-A8 @ 800MHz */
 
-	early_platform_add_devices(sh7372_early_devices,
-				   ARRAY_SIZE(sh7372_early_devices));
-
-	/* setup early console here as well */
-	shmobile_setup_console();
+	sh7372_add_early_devices();
 }
 
 void __init sh7372_add_standard_devices_dt(void)
-- 
1.7.9.5

