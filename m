From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 14 Feb 2014 17:20:41 +0000
Subject: [PATCH v2 2/2] ARM: shmobile: koelsch-reference: Add DU device
Message-Id: <1392398441-9560-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/boot/dts/r8a7791-koelsch.dts            |   7 +-
 arch/arm/mach-shmobile/board-koelsch-reference.c | 101 +++++++++++++++++++----
 2 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index d4b9bba..f67d2d0 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -109,9 +109,14 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif0_pins &scif1_pins>;
+	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
 	pinctrl-names = "default";
 
+	du_pins: du {
+		renesas,groups = "du_rgb666", "du_sync", "du_clk_out_0";
+		renesas,function = "du";
+	};
+
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_d";
 		renesas,function = "scif0";
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index feb8d97..267fe83 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -21,46 +21,117 @@
 
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/rcar-du.h>
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7791.h>
 #include <asm/mach/arch.h>
 
+/* DU */
+static struct rcar_du_encoder_data koelsch_du_encoders[] = {
+	{
+		.type = RCAR_DU_ENCODER_NONE,
+		.output = RCAR_DU_OUTPUT_LVDS0,
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
+static struct rcar_du_platform_data koelsch_du_pdata = {
+	.encoders = koelsch_du_encoders,
+	.num_encoders = ARRAY_SIZE(koelsch_du_encoders),
+};
+
+static const struct resource du_resources[] __initconst = {
+	DEFINE_RES_MEM(0xfeb00000, 0x40000),
+	DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
+	DEFINE_RES_IRQ(gic_spi(256)),
+	DEFINE_RES_IRQ(gic_spi(268)),
+};
+
+static void __init koelsch_add_du_device(void)
+{
+	struct platform_device_info info = {
+		.name = "rcar-du-r8a7791",
+		.id = -1,
+		.res = du_resources,
+		.num_res = ARRAY_SIZE(du_resources),
+		.data = &koelsch_du_pdata,
+		.size_data = sizeof(koelsch_du_pdata),
+		.dma_mask = DMA_BIT_MASK(32),
+	};
+
+	platform_device_register_full(&info);
+}
+
 static void __init koelsch_add_standard_devices(void)
 {
 #ifdef CONFIG_COMMON_CLK
 	/*
-	 * This is a really crude hack to provide clkdev support to the SCIF
-	 * and CMT devices until they get moved to DT.
+	 * This is a really crude hack to provide clkdev support to the CMT and
+	 * DU devices until they get moved to DT.
 	 */
-	static const char * const scif_names[] = {
-		"scifa0", "scifa1", "scifb0", "scifb1", "scifb2", "scifa2",
-		"scif0", "scif1", "scif2", "scif3", "scif4", "scif5", "scifa3",
-		"scifa4", "scifa5",
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
+		{ "scif2", NULL, "sh-sci.8" },
+		{ "scif3", NULL, "sh-sci.9" },
+		{ "scif4", NULL, "sh-sci.10" },
+		{ "scif5", NULL, "sh-sci.11" },
+		{ "scifa3", NULL, "sh-sci.12" },
+		{ "scifa4", NULL, "sh-sci.13" },
+		{ "scifa5", NULL, "sh-sci.14" },
+		{ "du0", "du.0", "rcar-du-r8a7791" },
+		{ "du1", "du.1", "rcar-du-r8a7791" },
+		{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
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
 	r8a7791_clock_init();
 #endif
 	r8a7791_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
+	koelsch_add_du_device();
 }
 
 static const char * const koelsch_boards_compat_dt[] __initconst = {
-- 
1.8.3.2

