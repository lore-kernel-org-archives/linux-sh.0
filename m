From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2011 02:46:56 +0000
Subject: [PATCH 16/20] ARM: mach-shmobile: bonito: Add dip-switch selector
Message-Id: <87ehxf9y02.wl%kuninori.morimoto.gx@renesas.com>
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
index 901d745..efaa5fe 100644
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
 static u16 bonito_fpga_read(u32 offset)
@@ -71,9 +84,15 @@ static void bonito_fpga_write(u32 offset, u16 val)
 }
 
 /*
- * devices
+ * core board devices
  */
-static struct platform_device *bonito_devices[] __initdata = {
+static struct platform_device *bonito_core_devices[] __initdata = {
+};
+
+/*
+ * base board devices
+ */
+static struct platform_device *bonito_base_devices[] __initdata = {
 };
 
 /*
@@ -126,26 +145,18 @@ static void __init bonito_map_io(void)
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
-	val = bonito_fpga_read(BVERR);
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
@@ -153,7 +164,50 @@ static void __init bonito_init(void)
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
+		val = bonito_fpga_read(BVERR);
+		pr_info("bonito version: cpu %02x, base %02x\n",
+			((val >> 8) & 0xFF),
+			((val >> 0) & 0xFF));
+
+		bsw2 = bonito_fpga_read(BUSSWMR2);
+		bsw3 = bonito_fpga_read(BUSSWMR3);
+		bsw4 = bonito_fpga_read(BUSSWMR4);
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
1.7.5.4

