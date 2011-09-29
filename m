From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Sep 2011 01:31:30 +0000
Subject: [PATCH 3/5] ARM: mach-shmobile: bonito: Add dip-switch selector
Message-Id: <877h4sqglt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

devices enable/disable are controled by dip-switch on bonito board.
If bonito core board is connected to base board,
you can check the settings from FPGA.
This patch adds basic code and controls SCIFA5 settings

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bonito.c |   88 ++++++++++++++++++++++++++------
 1 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index ec8e6fc..0e9dac6 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -56,8 +56,21 @@
  */
 
 /*
+ * SCIFA5 (CN42)
+ *
+ * S38.3 = ON
+ * S39.6 = ON
+ * S43.1 = ON
+ */
+
+/*
  * FPGA
  */
+#define BUSSWMR1	0x0070
+#define BUSSWMR2	0x0072
+#define BUSSWMR3	0x0074
+#define BUSSWMR4	0x0076
+
 #define A1MDSR		0x10E0
 #define BVERR		0x1100
 u16 fpga_read(u32 offset)
@@ -75,9 +88,15 @@ void fpga_write(u32 offset, u16 val, u16 mask)
 }
 
 /*
- * devices
+ * core board devices
+ */
+static struct platform_device *bonito_core_devices[] __initdata = {
+};
+
+/*
+ * base board devices
  */
-static struct platform_device *bonito_devices[] __initdata = {
+static struct platform_device *bonito_base_devices[] __initdata = {
 };
 
 /*
@@ -147,26 +166,18 @@ static void __init bonito_map_io(void)
 /*
  * board init
  */
+#define BIT_ON(sw, bit)		(sw & (1 << bit))
+#define BIT_OFF(sw, bit)	(!(sw & (1 << bit)))
+
 static void __init bonito_init(void)
 {
 	u16 val;
 
 	r8a7740_pinmux_init();
 
-	/* FPGA */
-	gpio_request(GPIO_FN_CS5B, NULL);
-	gpio_request(GPIO_FN_CS6A, NULL);
-	gpio_request(GPIO_FN_CS5A_PORT105,  NULL);
-	gpio_request(GPIO_FN_IRQ10, NULL);
-
-	val = fpga_read(BVERR);
-	pr_info("bonito version: cpu %02x, base %02x\n",
-		((val >> 8) & 0xFF),
-		((val >> 0) & 0xFF));
-
-	/* SCIFA5 */
-	gpio_request(GPIO_FN_SCIFA5_TXD_PORT91, NULL);
-	gpio_request(GPIO_FN_SCIFA5_RXD_PORT92, NULL);
+	/*
+	 * core board settings
+	 */
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
@@ -174,7 +185,50 @@ static void __init bonito_init(void)
 #endif
 
 	r8a7740_add_standard_devices();
-	platform_add_devices(bonito_devices, ARRAY_SIZE(bonito_devices));
+
+	platform_add_devices(bonito_core_devices,
+			     ARRAY_SIZE(bonito_core_devices));
+
+	/*
+	 * base board settings
+	 */
+	gpio_request(GPIO_PORT176, NULL);
+	gpio_direction_input(GPIO_PORT176);
+	if (!gpio_get_value(GPIO_PORT176)) {
+		u16 bsw2;
+		u16 bsw3;
+		u16 bsw4;
+
+		/*
+		 * FPGA
+		 */
+		gpio_request(GPIO_FN_CS5B,		NULL);
+		gpio_request(GPIO_FN_CS6A,		NULL);
+		gpio_request(GPIO_FN_CS5A_PORT105,	NULL);
+		gpio_request(GPIO_FN_IRQ10,		NULL);
+
+		val = fpga_read(BVERR);
+		pr_info("bonito version: cpu %02x, base %02x\n",
+			((val >> 8) & 0xFF),
+			((val >> 0) & 0xFF));
+
+		bsw2 = fpga_read(BUSSWMR2);
+		bsw3 = fpga_read(BUSSWMR3);
+		bsw4 = fpga_read(BUSSWMR4);
+
+		/*
+		 * SCIFA5 (CN42)
+		 */
+		if (BIT_OFF(bsw2, 1) &&	/* S38.3 = ON */
+		    BIT_OFF(bsw3, 9) &&	/* S39.6 = ON */
+		    BIT_OFF(bsw4, 4)) {	/* S43.1 = ON */
+			gpio_request(GPIO_FN_SCIFA5_TXD_PORT91,	NULL);
+			gpio_request(GPIO_FN_SCIFA5_RXD_PORT92,	NULL);
+		}
+
+		platform_add_devices(bonito_base_devices,
+				     ARRAY_SIZE(bonito_base_devices));
+	}
 }
 
 static void __init bonito_timer_init(void)
-- 
1.7.4.1

