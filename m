From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:22 +0000
Subject: [PATCH 19/35] ARM: shmobile: mackerel: Register pinctrl mapping for SMSC911x
Message-Id: <1366671758-8954-20-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based SMSC911x pinmux configuration by a pinctrl
mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index cfcd028..f515c57 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1373,6 +1373,11 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 				  "sdhi2_data4", "sdhi2"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-sh7372",
 				  "sdhi2_ctrl", "sdhi2"),
+	/* SMSC911X */
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-sh7372",
+				  "bsc_cs5a", "bsc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-sh7372",
+				  "intc_irq6_0", "intc"),
 };
 
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
@@ -1416,10 +1421,6 @@ static void __init mackerel_init(void)
 				  ARRAY_SIZE(mackerel_pinctrl_map));
 	sh7372_pinmux_init();
 
-	/* enable SMSC911X */
-	gpio_request(GPIO_FN_CS5A,	NULL);
-	gpio_request(GPIO_FN_IRQ6_39,	NULL);
-
 	/* backlight, off by default */
 	gpio_request_one(31, GPIOF_OUT_INIT_LOW, NULL);
 
-- 
1.8.1.5

