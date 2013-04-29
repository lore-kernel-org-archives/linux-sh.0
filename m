From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 29 Apr 2013 11:12:25 +0000
Subject: [PATCH v3 4/4] ARM: shmobile: kzm9g-reference: Remove the VCCQ MC0 function GPIO
Message-Id: <1367233945-20630-5-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The VCCQ MC0 power gate is now controlled by a regulator registered by
the PFC driver. Remove the corresponding function GPIO.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index aefa50d..44055fe 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -79,7 +79,6 @@ static void __init kzm_init(void)
 	sh73a0_pinmux_init();
 
 	/* enable SD */
-	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
 	gpio_request_one(15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
 	gpio_request_one(14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
-- 
1.8.1.5

