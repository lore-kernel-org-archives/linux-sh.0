From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:00:01 +0000
Subject: [PATCH 20/37] ARM: shmobile: bonito: Don't configure LCDC routing manually
Message-Id: <1366671618-8796-21-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

LCDC routing is configured automatically in the PFC driver, don't
configure it manually in board code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-bonito.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index 2781c7f..b373e9c 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -451,7 +451,6 @@ static void __init bonito_init(void)
 		    BIT_ON(bsw2, 2)) {	/* S38.2 = OFF */
 			pinctrl_register_mappings(lcdc0_pinctrl_map,
 						  ARRAY_SIZE(lcdc0_pinctrl_map));
-			gpio_request(GPIO_FN_LCDC0_SELECT, NULL);
 
 			gpio_request_one(61, GPIOF_OUT_INIT_HIGH,
 					 NULL); /* LCDDON */
-- 
1.8.1.5

