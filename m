From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 22:59:47 +0000
Subject: [PATCH v4 42/88] ARM: shmobile: kzm9g: Register pinctrl mappings for USB
Message-Id: <1363215633-4264-43-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based USB pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 7427041..c1c0401 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -654,6 +654,9 @@ static const struct pinctrl_map kzm_pinctrl_map[] = {
 	/* SMSC */
 	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x.0", "pfc-sh73a0",
 				  "bsc_cs4", "bsc"),
+	/* USB */
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-sh73a0",
+				  "usb_vbus", "usb"),
 };
 
 /*
@@ -738,9 +741,6 @@ static void __init kzm_init(void)
 	/* enable Micro SD */
 	gpio_request_one(14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
-	/* enable USB */
-	gpio_request(GPIO_FN_VBUS_0,	NULL);
-
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
-- 
1.8.1.5

