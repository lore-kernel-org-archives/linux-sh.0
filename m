From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 21 Jan 2014 15:32:41 +0000
Subject: [RFC/PATCH 6/7] ARM: shmobile: koelsch-reference: Add DU platform data
Message-Id: <1390318362-29954-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/mach-shmobile/board-koelsch-reference.c | 38 +++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index feb8d97..f9831cd 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -23,11 +23,46 @@
 #include <linux/clkdev.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/rcar-du.h>
 #include <mach/common.h>
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
+static const struct of_dev_auxdata koelsch_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("renesas,du-r8a7791", 0xfeb00000, NULL, &koelsch_du_pdata),
+	{}
+};
+
 static void __init koelsch_add_standard_devices(void)
 {
 #ifdef CONFIG_COMMON_CLK
@@ -60,7 +95,8 @@ static void __init koelsch_add_standard_devices(void)
 	r8a7791_clock_init();
 #endif
 	r8a7791_add_dt_devices();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     koelsch_auxdata_lookup, NULL);
 }
 
 static const char * const koelsch_boards_compat_dt[] __initconst = {
-- 
1.8.3.2

