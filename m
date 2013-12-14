From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 14 Dec 2013 15:25:31 +0000
Subject: [PATCH v5 07/17] ARM: shmobile: koelsch-reference: Remove duplicate CCF initialization
Message-Id: <1387034741-3852-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The common clock framework is initialized in the rcar_gen2_init_timer()
function, remove the of_clk_init() call.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index a804a17..4b48e2d 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -19,7 +19,6 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <mach/common.h>
@@ -29,9 +28,7 @@
 
 static void __init koelsch_add_standard_devices(void)
 {
-#ifdef CONFIG_COMMON_CLK
-	of_clk_init(NULL);
-#else
+#ifndef CONFIG_COMMON_CLK
 	r8a7791_clock_init();
 #endif
 	r8a7791_add_dt_devices();
-- 
1.8.3.2

