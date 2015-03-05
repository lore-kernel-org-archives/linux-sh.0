From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 05 Mar 2015 01:58:27 +0000
Subject: [PATCH 11/11] ARM: shmobile: sh73a0: Remove restart callback
Message-Id: <3c7585b9901c335d10a04c8495164cb113c0b8f2.1425518682.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1425518682.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1425518682.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Remove the restart handling hack from the sh73a0 generic multiplatform
case.

Restart on DT-based sh73a0 platforms is now handled through the
R-Mobile reset driver.

This basically reverts commit cad900819fba0176 ("ARM: shmobile: sh73a0:
Add restart callback").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 2f68459e..fb2ab75 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -783,13 +783,6 @@ void __init sh73a0_add_early_devices(void)
 	shmobile_setup_console();
 }
 
-#define RESCNT2 IOMEM(0xe6188020)
-static void sh73a0_restart(enum reboot_mode mode, const char *cmd)
-{
-	/* Do soft power on reset */
-	writel((1 << 31), RESCNT2);
-}
-
 #ifdef CONFIG_USE_OF
 
 static void __init sh73a0_generic_init(void)
@@ -812,7 +805,6 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
 	.init_early	= shmobile_init_delay,
 	.init_machine	= sh73a0_generic_init,
 	.init_late	= shmobile_init_late,
-	.restart	= sh73a0_restart,
 	.dt_compat	= sh73a0_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
2.1.4

