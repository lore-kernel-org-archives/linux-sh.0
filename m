From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 22:59:55 +0000
Subject: [PATCH 14/37] ARM: shmobile: armadillo800eva: Don't configure LCDC routing manually
Message-Id: <1366671618-8796-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

LCDC routing is configured automatically in the PFC driver, don't
configure it manually in board code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index a74e750..e034953 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1148,8 +1148,6 @@ static void __init eva_init(void)
 	r8a7740_meram_workaround();
 
 	/* LCDC0 */
-	gpio_request(GPIO_FN_LCDC0_SELECT,	NULL);
-
 	gpio_request_one(61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
 	gpio_request_one(202, GPIOF_OUT_INIT_LOW, NULL); /* LCD0_LED_CONT */
 
-- 
1.8.1.5

