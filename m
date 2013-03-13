From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 22:59:52 +0000
Subject: [PATCH v4 47/88] ARM: shmobile: marzen: Register pinctrl mappings for USB
Message-Id: <1363215633-4264-48-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based USB pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 8871af3..04bcf88 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -347,6 +347,15 @@ static const struct pinctrl_map marzen_pinctrl_map[] = {
 				  "sdhi0_cd", "sdhi0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
 				  "sdhi0_wp", "sdhi0"),
+	/* USB0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform.0", "pfc-r8a7779",
+				  "usb0", "usb0"),
+	/* USB1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform.0", "pfc-r8a7779",
+				  "usb1", "usb1"),
+	/* USB2 */
+	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform.1", "pfc-r8a7779",
+				  "usb2", "usb2"),
 };
 
 static void __init marzen_init(void)
@@ -364,14 +373,6 @@ static void __init marzen_init(void)
 	gpio_request(GPIO_FN_EX_CS0, NULL); /* nCS */
 	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
 
-	/* USB (CN21) */
-	gpio_request(GPIO_FN_USB_OVC0, NULL);
-	gpio_request(GPIO_FN_USB_OVC1, NULL);
-	gpio_request(GPIO_FN_USB_OVC2, NULL);
-
-	/* USB (CN22) */
-	gpio_request(GPIO_FN_USB_PENC2, NULL);
-
 	r8a7779_add_standard_devices();
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
-- 
1.8.1.5

