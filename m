From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 21 Jan 2014 15:32:38 +0000
Subject: [RFC/PATCH 3/7] ARM: shmobile: lager-reference: Add DU platform data
Message-Id: <1390318362-29954-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390318362-29954-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1390318362-29954-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Magnus Damm <magnus.damm@gmail.com>

The DU device is instantiated through the device tree, pass the DU
platform data using OF_DEV_AUXDATA.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 41 +++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index dc8d76b..0294836 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -22,11 +22,49 @@
 #include <linux/clkdev.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/rcar-du.h>
 #include <mach/common.h>
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
+static const struct of_dev_auxdata lager_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("renesas,du-r8a7790", 0xfeb00000, NULL, &lager_du_pdata),
+	{}
+};
+
 static void __init lager_add_standard_devices(void)
 {
 #ifdef CONFIG_COMMON_CLK
@@ -60,7 +98,8 @@ static void __init lager_add_standard_devices(void)
 #endif
 
 	r8a7790_add_dt_devices();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     lager_auxdata_lookup, NULL);
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
-- 
1.8.3.2

