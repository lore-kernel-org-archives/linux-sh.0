From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 24 Jan 2013 12:16:32 +0000
Subject: [PATCH v2 5/8] ARM: shmobile: bonito: Use gpio_request_one()
Message-Id: <1359029795-7871-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace occurences of gpio_request() and gpio_direction_*() by calls to
gpio_request_one().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-bonito.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index cb8c994..932a9c0 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -392,8 +392,7 @@ static void __init bonito_init(void)
 	/*
 	 * base board settings
 	 */
-	gpio_request(GPIO_PORT176, NULL);
-	gpio_direction_input(GPIO_PORT176);
+	gpio_request_one(GPIO_PORT176, GPIOF_IN, NULL);
 	if (!gpio_get_value(GPIO_PORT176)) {
 		u16 bsw2;
 		u16 bsw3;
@@ -462,8 +461,8 @@ static void __init bonito_init(void)
 			gpio_request(GPIO_FN_LCD0_DISP,		NULL);
 			gpio_request(GPIO_FN_LCD0_LCLK_PORT165,	NULL);
 
-			gpio_request(GPIO_PORT61, NULL); /* LCDDON */
-			gpio_direction_output(GPIO_PORT61, 1);
+			gpio_request_one(GPIO_PORT61, GPIOF_OUT_INIT_HIGH,
+					 NULL); /* LCDDON */
 
 			/* backlight on */
 			bonito_fpga_write(LCDCR, 1);
-- 
1.7.12.4

