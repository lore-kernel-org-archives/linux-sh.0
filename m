From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 14 Feb 2014 17:20:40 +0000
Subject: [PATCH v2 1/2] ARM: shmobile: lager-reference: Add DU device
Message-Id: <1392398441-9560-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The DU device has no DT bindings yet, instantiate it as a platform
device for now.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Magnus Damm <damm@opensource.se>
---
 arch/arm/boot/dts/r8a7790-lager.dts            |   7 +-
 arch/arm/mach-shmobile/board-lager-reference.c | 103 +++++++++++++++++++++----
 2 files changed, 94 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 5466fe4..26a9010 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -111,9 +111,14 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif0_pins &scif1_pins>;
+	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
 
+	du_pins: du {
+		renesas,groups = "du_rgb666", "du_sync_1", "du_clk_out_0";
+		renesas,function = "du";
+	};
+
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data";
 		renesas,function = "scif0";
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index dc8d76b..6ba8b3b 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -20,47 +20,120 @@
 
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/rcar-du.h>
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 
+/* DU */
+static struct rcar_du_encoder_data lager_du_encoders[] = {
+	{
+		.type = RCAR_DU_ENCODER_VGA,
+		.output = RCAR_DU_OUTPUT_DPAD0,
+	}, {
+		.type = RCAR_DU_ENCODER_NONE,
+		.output = RCAR_DU_OUTPUT_LVDS1,
+		.connector.lvds.panel = {
+			.width_mm = 210,
+			.height_mm = 158,
+			.mode = {
+				.clock = 65000,
+				.hdisplay = 1024,
+				.hsync_start = 1048,
+				.hsync_end = 1184,
+				.htotal = 1344,
+				.vdisplay = 768,
+				.vsync_start = 771,
+				.vsync_end = 777,
+				.vtotal = 806,
+				.flags = 0,
+			},
+		},
+	},
+};
+
+static struct rcar_du_platform_data lager_du_pdata = {
+	.encoders = lager_du_encoders,
+	.num_encoders = ARRAY_SIZE(lager_du_encoders),
+};
+
+static const struct resource du_resources[] __initconst = {
+	DEFINE_RES_MEM(0xfeb00000, 0x70000),
+	DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
+	DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
+	DEFINE_RES_IRQ(gic_spi(256)),
+	DEFINE_RES_IRQ(gic_spi(268)),
+	DEFINE_RES_IRQ(gic_spi(269)),
+};
+
+static void __init lager_add_du_device(void)
+{
+	struct platform_device_info info = {
+		.name = "rcar-du-r8a7790",
+		.id = -1,
+		.res = du_resources,
+		.num_res = ARRAY_SIZE(du_resources),
+		.data = &lager_du_pdata,
+		.size_data = sizeof(lager_du_pdata),
+		.dma_mask = DMA_BIT_MASK(32),
+	};
+
+	platform_device_register_full(&info);
+}
+
 static void __init lager_add_standard_devices(void)
 {
 #ifdef CONFIG_COMMON_CLK
 	/*
-	 * This is a really crude hack to provide clkdev support to the SCIF
-	 * and CMT devices until they get moved to DT.
+	 * This is a really crude hack to provide clkdev support to platform
+	 * devices until they get moved to DT.
 	 */
-	static const char * const scif_names[] = {
-		"scifa0", "scifa1", "scifb0", "scifb1",
-		"scifb2", "scifa2", "scif0", "scif1",
-		"hscif0", "hscif1",
+	static const struct clk_name {
+		const char *clk;
+		const char *con_id;
+		const char *dev_id;
+	} clk_names[] = {
+		{ "cmt0", NULL, "sh_cmt.0" },
+		{ "scifa0", NULL, "sh-sci.0" },
+		{ "scifa1", NULL, "sh-sci.1" },
+		{ "scifb0", NULL, "sh-sci.2" },
+		{ "scifb1", NULL, "sh-sci.3" },
+		{ "scifb2", NULL, "sh-sci.4" },
+		{ "scifa2", NULL, "sh-sci.5" },
+		{ "scif0", NULL, "sh-sci.6" },
+		{ "scif1", NULL, "sh-sci.7" },
+		{ "hscif0", NULL, "sh-sci.8" },
+		{ "hscif1", NULL, "sh-sci.9" },
+		{ "du0", "du.0", "rcar-du-r8a7790" },
+		{ "du1", "du.1", "rcar-du-r8a7790" },
+		{ "du2", "du.2", "rcar-du-r8a7790" },
+		{ "lvds0", "lvds.0", "rcar-du-r8a7790" },
+		{ "lvds1", "lvds.1", "rcar-du-r8a7790" },
 	};
 	struct clk *clk;
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(scif_names); ++i) {
-		clk = clk_get(NULL, scif_names[i]);
+	for (i = 0; i < ARRAY_SIZE(clk_names); ++i) {
+		clk = clk_get(NULL, clk_names[i].clk);
 		if (!IS_ERR(clk)) {
-			clk_register_clkdev(clk, NULL, "sh-sci.%u", i);
+			clk_register_clkdev(clk, clk_names[i].con_id,
+					    clk_names[i].dev_id);
 			clk_put(clk);
 		}
 	}
-
-	clk = clk_get(NULL, "cmt0");
-	if (!IS_ERR(clk)) {
-		clk_register_clkdev(clk, NULL, "sh_cmt.0");
-		clk_put(clk);
-	}
 #else
 	r8a7790_clock_init();
 #endif
 
 	r8a7790_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	lager_add_du_device();
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
-- 
1.8.3.2

