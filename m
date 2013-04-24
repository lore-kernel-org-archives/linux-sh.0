From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 24 Apr 2013 22:00:27 +0000
Subject: [PATCH v2 3/4] ARM: shmobile: kzm9g: Remove the VCCQ MC0 function GPIO
Message-Id: <1366840828-17335-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The VCCQ MC0 power gate is now controlled by a regulator registered by
the PFC driver. Remove the corresponding function GPIO.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index ceabb44..e0e027c 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -871,9 +871,6 @@ static void __init kzm_init(void)
 	/* Touchscreen */
 	gpio_request_one(223, GPIOF_IN, NULL); /* IRQ8 */
 
-	/* enable SD */
-	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
-
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
-- 
1.8.1.5

