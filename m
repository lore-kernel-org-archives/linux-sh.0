From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:01:51 +0000
Subject: [PATCH v3 31/64] ARM: shmobile: marzen: Register pinctrl mappings for SCIF
Message-Id: <1362740544-19164-32-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based SCIF pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index d25a7b3..fd313a8 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -329,6 +329,10 @@ void __init marzen_init_late(void)
 }
 
 static const struct pinctrl_map marzen_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-r8a7779",
+				  "scif2_data_c", "scif2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-r8a7779",
+				  "scif4_data", "scif4"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
 				  "sdhi0_data4", "sdhi0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
@@ -350,14 +354,6 @@ static void __init marzen_init(void)
 				  ARRAY_SIZE(marzen_pinctrl_map));
 	r8a7779_pinmux_init();
 
-	/* SCIF2 (CN18: DEBUG0) */
-	gpio_request(GPIO_FN_TX2_C, NULL);
-	gpio_request(GPIO_FN_RX2_C, NULL);
-
-	/* SCIF4 (CN19: DEBUG1) */
-	gpio_request(GPIO_FN_TX4, NULL);
-	gpio_request(GPIO_FN_RX4, NULL);
-
 	/* LAN89218 */
 	gpio_request(GPIO_FN_EX_CS0, NULL); /* nCS */
 	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
-- 
1.8.1.5

