From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 22:59:58 +0000
Subject: [PATCH 17/37] ARM: shmobile: bonito: Register pinctrl mapping for SCIF
Message-Id: <1366671618-8796-18-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based SCIF pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-bonito.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index b111c13..b6620662 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -369,6 +369,12 @@ static void __init bonito_map_io(void)
 #define VCCQ1CR		IOMEM(0xE6058140)
 #define VCCQ1LCDCR	IOMEM(0xE6058186)
 
+static const struct pinctrl_map scifa5_pinctrl_map[] = {
+	/* SCIFA5 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.5", "pfc-r8a7740",
+				  "scifa5_data_2", "scifa5"),
+};
+
 static void __init bonito_init(void)
 {
 	u16 val;
@@ -423,8 +429,8 @@ static void __init bonito_init(void)
 		if (BIT_OFF(bsw2, 1) &&	/* S38.3 = ON */
 		    BIT_OFF(bsw3, 9) &&	/* S39.6 = ON */
 		    BIT_OFF(bsw4, 4)) {	/* S43.1 = ON */
-			gpio_request(GPIO_FN_SCIFA5_TXD_PORT91,	NULL);
-			gpio_request(GPIO_FN_SCIFA5_RXD_PORT92,	NULL);
+			pinctrl_register_mappings(scifa5_pinctrl_map,
+						  ARRAY_SIZE(scifa5_pinctrl_map));
 		}
 
 		/*
-- 
1.8.1.5

