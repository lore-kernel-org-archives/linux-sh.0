From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 02 Dec 2013 00:31:55 +0000
Subject: [PATCH] ARM: shmobile: koelsch: Add DU device
Message-Id: <1385944315-30117-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Only the LVDS output is currently supported.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-koelsch.c | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index ec02054..e8431f1 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -27,6 +27,7 @@
 #include <linux/phy.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
+#include <linux/platform_data/rcar-du.h>
 #include <linux/platform_device.h>
 #include <linux/sh_eth.h>
 #include <mach/common.h>
@@ -36,6 +37,57 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/* DU */
+static struct rcar_du_encoder_data lager_du_encoders[] = {
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
+static const struct rcar_du_platform_data lager_du_pdata __initconst = {
+	.encoders = lager_du_encoders,
+	.num_encoders = ARRAY_SIZE(lager_du_encoders),
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
+		.data = &lager_du_pdata,
+		.size_data = sizeof(lager_du_pdata),
+		.dma_mask = DMA_BIT_MASK(32),
+	};
+
+	platform_device_register_full(&info);
+}
+
 /* Ether */
 static const struct sh_eth_plat_data ether_pdata __initconst = {
 	.phy			= 0x1,
@@ -96,6 +148,13 @@ static const struct gpio_keys_platform_data koelsch_keys_pdata __initconst = {
 };
 
 static const struct pinctrl_map koelsch_pinctrl_map[] = {
+	/* DU */
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7791", "pfc-r8a7791",
+				  "du_rgb666", "du"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7791", "pfc-r8a7791",
+				  "du_sync", "du"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7791", "pfc-r8a7791",
+				  "du_clk_out_0", "du"),
 	/* Ether */
 	PIN_MAP_MUX_GROUP_DEFAULT("r8a7790-ether", "pfc-r8a7791",
 				  "eth_link", "eth"),
@@ -128,6 +187,8 @@ static void __init koelsch_add_standard_devices(void)
 	platform_device_register_data(&platform_bus, "gpio-keys", -1,
 				      &koelsch_keys_pdata,
 				      sizeof(koelsch_keys_pdata));
+
+	koelsch_add_du_device();
 }
 
 /*
-- 
Regards,

Laurent Pinchart

