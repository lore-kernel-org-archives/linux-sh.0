From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 10 Jan 2013 19:47:56 +0000
Subject: [PATCH 5/8] ARM: shmobile: bonito: Use gpio_request_one()
Message-Id: <1357847279-7765-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace occurences of gpio_request() and gpio_direction_*() by calls to
gpio_request_one().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-bonito.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index cdd9415..f55b40b 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -402,8 +402,7 @@ static void __init bonito_init(void)
 	/*
 	 * base board settings
 	 */
-	gpio_request(GPIO_PORT176, NULL);
-	gpio_direction_input(GPIO_PORT176);
+	gpio_request_one(GPIO_PORT176, GPIOF_IN, NULL);
 	if (!gpio_get_value(GPIO_PORT176)) {
 		u16 bsw2;
 		u16 bsw3;
@@ -445,8 +444,8 @@ static void __init bonito_init(void)
 						  ARRAY_SIZE(lcdc0_pinctrl_map));
 			gpio_request(GPIO_FN_LCDC0_SELECT, NULL);
 
-			gpio_request(GPIO_PORT61, NULL); /* LCDDON */
-			gpio_direction_output(GPIO_PORT61, 1);
+			gpio_request_one(GPIO_PORT61, GPIOF_OUT_INIT_HIGH,
+					 NULL); /* LCDDON */
 
 			/* backlight on */
 			bonito_fpga_write(LCDCR, 1);
-- 
1.7.8.6

