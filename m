From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:00:00 +0000
Subject: [PATCH 19/37] ARM: shmobile: bonito: Register pinctrl mapping for BSC
Message-Id: <1366671618-8796-20-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based BSC pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-bonito.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index 5076f4d..2781c7f 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -377,6 +377,12 @@ static void __init bonito_map_io(void)
 static const struct pinctrl_map fpga_pinctrl_map[] = {
 	/* FPGA */
 	PIN_MAP_MUX_GROUP_DEFAULT("pfc-r8a7740", "pfc-r8a7740",
+				  "bsc_cs5a_0", "bsc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("pfc-r8a7740", "pfc-r8a7740",
+				  "bsc_cs5b", "bsc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("pfc-r8a7740", "pfc-r8a7740",
+				  "bsc_cs6a", "bsc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("pfc-r8a7740", "pfc-r8a7740",
 				  "intc_irq10", "intc"),
 };
 
@@ -419,13 +425,6 @@ static void __init bonito_init(void)
 		u16 bsw3;
 		u16 bsw4;
 
-		/*
-		 * FPGA
-		 */
-		gpio_request(GPIO_FN_CS5B,		NULL);
-		gpio_request(GPIO_FN_CS6A,		NULL);
-		gpio_request(GPIO_FN_CS5A_PORT105,	NULL);
-
 		val = bonito_fpga_read(BVERR);
 		pr_info("bonito version: cpu %02x, base %02x\n",
 			((val >> 8) & 0xFF),
-- 
1.8.1.5

