From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 01:03:43 +0000
Subject: [PATCH v3 06/15] ARM: shmobile: koelsch-reference: Initialize CPG device
Message-Id: <1385600632-5181-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On multiplatform kernels clocks are handled by the CCF CPG driver. It
must be explicitly initialized by a call to rcar_gen2_clocks_init() with
the value of the boot mode pins.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index a804a17..788ccdf 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -19,7 +19,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/clk-provider.h>
+#include <linux/clk/shmobile.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <mach/common.h>
@@ -27,11 +27,17 @@
 #include <mach/r8a7791.h>
 #include <asm/mach/arch.h>
 
-static void __init koelsch_add_standard_devices(void)
+static void __init koelsch_init_time(void)
 {
 #ifdef CONFIG_COMMON_CLK
-	of_clk_init(NULL);
-#else
+	rcar_gen2_clocks_init(rcar_gen2_read_mode_pins());
+#endif
+	rcar_gen2_timer_init();
+}
+
+static void __init koelsch_add_standard_devices(void)
+{
+#ifndef CONFIG_COMMON_CLK
 	r8a7791_clock_init();
 #endif
 	r8a7791_add_dt_devices();
@@ -46,7 +52,7 @@ static const char * const koelsch_boards_compat_dt[] __initconst = {
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.smp		= smp_ops(r8a7791_smp_ops),
 	.init_early	= r8a7791_init_early,
-	.init_time	= rcar_gen2_timer_init,
+	.init_time	= koelsch_init_time,
 	.init_machine	= koelsch_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= koelsch_boards_compat_dt,
-- 
1.8.3.2

