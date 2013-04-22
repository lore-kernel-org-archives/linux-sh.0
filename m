From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 22:59:59 +0000
Subject: [PATCH 18/37] ARM: shmobile: bonito: Register pinctrl mapping for INTC
Message-Id: <1366671618-8796-19-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based INTC pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-bonito.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index b6620662..5076f4d 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -369,6 +369,17 @@ static void __init bonito_map_io(void)
 #define VCCQ1CR		IOMEM(0xE6058140)
 #define VCCQ1LCDCR	IOMEM(0xE6058186)
 
+/*
+ * HACK: The FPGA mappings should be associated with the FPGA device, but we
+ * don't have one at the moment. Associate them with the PFC device to make
+ * sure they will be applied.
+ */
+static const struct pinctrl_map fpga_pinctrl_map[] = {
+	/* FPGA */
+	PIN_MAP_MUX_GROUP_DEFAULT("pfc-r8a7740", "pfc-r8a7740",
+				  "intc_irq10", "intc"),
+};
+
 static const struct pinctrl_map scifa5_pinctrl_map[] = {
 	/* SCIFA5 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.5", "pfc-r8a7740",
@@ -381,6 +392,8 @@ static void __init bonito_init(void)
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
+	pinctrl_register_mappings(fpga_pinctrl_map,
+				  ARRAY_SIZE(fpga_pinctrl_map));
 	r8a7740_pinmux_init();
 	bonito_fpga_init();
 
@@ -412,7 +425,6 @@ static void __init bonito_init(void)
 		gpio_request(GPIO_FN_CS5B,		NULL);
 		gpio_request(GPIO_FN_CS6A,		NULL);
 		gpio_request(GPIO_FN_CS5A_PORT105,	NULL);
-		gpio_request(GPIO_FN_IRQ10,		NULL);
 
 		val = bonito_fpga_read(BVERR);
 		pr_info("bonito version: cpu %02x, base %02x\n",
-- 
1.8.1.5

