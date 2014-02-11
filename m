From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 11 Feb 2014 20:49:50 +0000
Subject: [PATCH 2/2] ARM: shmobile: koelsch-reference: Add DU device
Message-Id: <1392151790-11262-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387704444-750-3-git-send-email-takasi-y@ops.dti.ne.jp>
In-Reply-To: <1387704444-750-3-git-send-email-takasi-y@ops.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The DU device has no DT bindings yet, instantiate it as a platform
device for now.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts            |  8 +++
 arch/arm/mach-shmobile/board-koelsch-reference.c | 82 ++++++++++++++++++++++--
 2 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 615d44d..14f5486 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -115,6 +115,14 @@
 };
 
 &pfc {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+
+	du_pins: du {
+		renesas,groups = "du_rgb666", "du_sync", "du_clk_out_0";
+		renesas,function = "du";
+	};
+
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_d";
 		renesas,function = "scif0";
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 46879d6..6485af7 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -21,32 +21,102 @@
 
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
-	 * This is a really crude hack to provide clkdev support to the CMT
-	 * device until they get moved to DT.
+	 * This is a really crude hack to provide clkdev support to the CMT and
+	 * DU devices until they get moved to DT.
 	 */
+	static const struct clk_name {
+		const char *clk;
+		const char *con_id;
+		const char *dev_id;
+	} clk_names[] = {
+		{ "cmt0", NULL, "sh_cmt.0" },
+		{ "du0", "du.0", "rcar-du-r8a7791" },
+		{ "du1", "du.1", "rcar-du-r8a7791" },
+		{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
+	};
 	struct clk *clk;
+	unsigned int i;
 
-	clk = clk_get(NULL, "cmt0");
-	if (!IS_ERR(clk)) {
-		clk_register_clkdev(clk, NULL, "sh_cmt.0");
-		clk_put(clk);
+	for (i = 0; i < ARRAY_SIZE(clk_names); ++i) {
+		clk = clk_get(NULL, clk_names[i].clk);
+		if (!IS_ERR(clk)) {
+			clk_register_clkdev(clk, clk_names[i].con_id,
+					    clk_names[i].dev_id);
+			clk_put(clk);
+		}
 	}
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

