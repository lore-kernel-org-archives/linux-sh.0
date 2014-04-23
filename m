From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 23 Apr 2014 01:25:42 +0000
Subject: [PATCH 3/4] ARM: shmobile: sh7372: Call sh7372_add_early_devices() instead of open coding
Message-Id: <1fba31f047639a6c7accf4f6d075a6cf9eacecc0.1398216284.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1398216284.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1398216284.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh7372.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 2730127..f8176b0 100644
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
1.8.5.2

