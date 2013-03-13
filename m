From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 22:59:53 +0000
Subject: [PATCH v4 48/88] ARM: shmobile: marzen: Register pinctrl mappings for LBSC
Message-Id: <1363215633-4264-49-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based LBSC pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 04bcf88..b16f85f 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -347,6 +347,9 @@ static const struct pinctrl_map marzen_pinctrl_map[] = {
 				  "sdhi0_cd", "sdhi0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
 				  "sdhi0_wp", "sdhi0"),
+	/* SMSC */
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a7779",
+				  "lbsc_ex_cs0", "lbsc"),
 	/* USB0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform.0", "pfc-r8a7779",
 				  "usb0", "usb0"),
@@ -370,7 +373,6 @@ static void __init marzen_init(void)
 	r8a7779_pinmux_init();
 
 	/* LAN89218 */
-	gpio_request(GPIO_FN_EX_CS0, NULL); /* nCS */
 	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
 
 	r8a7779_add_standard_devices();
-- 
1.8.1.5

