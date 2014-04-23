From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 23 Apr 2014 01:25:41 +0000
Subject: [PATCH 2/4] ARM: shmobile: r8a7740: Remove unused r8a7740_add_early_devices_dt()
Message-Id: <72dc392ae5bbad3477053ac4c5708dba6706ffa0.1398216284.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1398216284.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1398216284.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

It was removed in commit 744fdc8dc0e22cc5b61ee1bcde9375f188daa330 ("ARM:
shmobile: r8a7740: Prepare for reference DT setup"), but accidentally
resurrected in commit 88378837780166d67a11142cd6f76596c0a2d8c3 ("ARM:
shmobile: Remove unused r8a7740 auxdata table").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 8f3c681..cba3a07 100644
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
1.8.5.2

