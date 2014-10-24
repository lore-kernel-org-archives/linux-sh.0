From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 24 Oct 2014 12:04:00 +0000
Subject: [PATCH v4 8/9] ARM: shmobile: koelsch-reference: Remove DU platform device
Message-Id: <1414152241-5390-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The DU device is now instantiated from the device tree, remove the
corresponding platform device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 73 ------------------------
 1 file changed, 73 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 46aa540133d6..c3708180e69e 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -19,87 +19,15 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/dma-mapping.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
-#include <linux/platform_data/rcar-du.h>
 
 #include <asm/mach/arch.h>
 
-#include "clock.h"
 #include "common.h"
-#include "irqs.h"
 #include "r8a7791.h"
 #include "rcar-gen2.h"
 
-/* DU */
-static struct rcar_du_encoder_data koelsch_du_encoders[] = {
-	{
-		.type = RCAR_DU_ENCODER_NONE,
-		.output = RCAR_DU_OUTPUT_LVDS0,
-		.connector.lvds.panel = {
-			.width_mm = 210,
-			.height_mm = 158,
-			.mode = {
-				.pixelclock = 65000000,
-				.hactive = 1024,
-				.hfront_porch = 20,
-				.hback_porch = 160,
-				.hsync_len = 136,
-				.vactive = 768,
-				.vfront_porch = 3,
-				.vback_porch = 29,
-				.vsync_len = 6,
-			},
-		},
-	},
-};
-
-static struct rcar_du_platform_data koelsch_du_pdata = {
-	.encoders = koelsch_du_encoders,
-	.num_encoders = ARRAY_SIZE(koelsch_du_encoders),
-};
-
-static const struct resource du_resources[] __initconst = {
-	DEFINE_RES_MEM(0xfeb00000, 0x40000),
-	DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
-	DEFINE_RES_IRQ(gic_spi(256)),
-	DEFINE_RES_IRQ(gic_spi(268)),
-};
-
-static void __init koelsch_add_du_device(void)
-{
-	struct platform_device_info info = {
-		.name = "rcar-du-r8a7791",
-		.id = -1,
-		.res = du_resources,
-		.num_res = ARRAY_SIZE(du_resources),
-		.data = &koelsch_du_pdata,
-		.size_data = sizeof(koelsch_du_pdata),
-		.dma_mask = DMA_BIT_MASK(32),
-	};
-
-	platform_device_register_full(&info);
-}
-
-/*
- * This is a really crude hack to provide clkdev support to platform
- * devices until they get moved to DT.
- */
-static const struct clk_name clk_names[] __initconst = {
-	{ "du0", "du.0", "rcar-du-r8a7791" },
-	{ "du1", "du.1", "rcar-du-r8a7791" },
-	{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
-};
-
-static void __init koelsch_add_standard_devices(void)
-{
-	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-
-	koelsch_add_du_device();
-}
-
 static const char * const koelsch_boards_compat_dt[] __initconst = {
 	"renesas,koelsch",
 	"renesas,koelsch-reference",
@@ -110,7 +38,6 @@ DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.smp		= smp_ops(r8a7791_smp_ops),
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
-	.init_machine	= koelsch_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= koelsch_boards_compat_dt,
-- 
2.0.4

