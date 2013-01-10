From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 10 Jan 2013 19:47:58 +0000
Subject: [PATCH 7/8] ARM: shmobile: kzm9g: Use gpio_request_one()
Message-Id: <1357847279-7765-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace occurences of gpio_request() and gpio_direction_*() by calls to
gpio_request_one().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index b34a59b..9739bda 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -682,18 +682,14 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_CS4_, NULL); /* CS4 */
 
 	/* SMSC */
-	gpio_request(GPIO_PORT224, NULL); /* IRQ3 */
-	gpio_direction_input(GPIO_PORT224);
+	gpio_request_one(GPIO_PORT224, GPIOF_IN, NULL); /* IRQ3 */
 
 	/* LCDC */
-	gpio_request(GPIO_PORT222,	NULL); /* LCDCDON */
-	gpio_request(GPIO_PORT226,	NULL); /* SC */
-	gpio_direction_output(GPIO_PORT222, 1);
-	gpio_direction_output(GPIO_PORT226, 1);
+	gpio_request_one(GPIO_PORT222, GPIOF_OUT_INIT_HIGH, NULL); /* LCDCDON */
+	gpio_request_one(GPIO_PORT226, GPIOF_OUT_INIT_HIGH, NULL); /* SC */
 
 	/* Touchscreen */
-	gpio_request(GPIO_PORT223, NULL); /* IRQ8 */
-	gpio_direction_input(GPIO_PORT223);
+	gpio_request_one(GPIO_PORT223, GPIOF_IN, NULL); /* IRQ8 */
 
 	/* enable MMCIF */
 	gpio_request(GPIO_FN_MMCCLK0,		NULL);
@@ -717,8 +713,7 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_SDHID0_1,		NULL);
 	gpio_request(GPIO_FN_SDHID0_0,		NULL);
 	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
-	gpio_request(GPIO_PORT15, NULL);
-	gpio_direction_output(GPIO_PORT15, 1); /* power */
+	gpio_request_one(GPIO_PORT15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
 	/* enable Micro SD */
 	gpio_request(GPIO_FN_SDHID2_0,		NULL);
@@ -727,8 +722,7 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_SDHID2_3,		NULL);
 	gpio_request(GPIO_FN_SDHICMD2,		NULL);
 	gpio_request(GPIO_FN_SDHICLK2,		NULL);
-	gpio_request(GPIO_PORT14, NULL);
-	gpio_direction_output(GPIO_PORT14, 1); /* power */
+	gpio_request_one(GPIO_PORT14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
 	/* I2C 3 */
 	gpio_request(GPIO_FN_PORT27_I2C_SCL3, NULL);
-- 
1.7.8.6

