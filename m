From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 11 Dec 2013 14:13:55 +0000
Subject: [PATCH v4 09/16] ARM: shmobile: koelsch-reference: Instantiate clkdevs for SCIF and CMT
Message-Id: <1386771242-21876-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now that the common clock framework is supported, the clock lookup
entries in clock-r8a7791.c are not registered anymore. Devices must
instead reference their clocks in the device tree. However, SCIF and CMT
devices are still instantiated through platform code, and thus need a
clock lookup entry.

Retrieve the SCIF and CMT clock entries by name and register clkdevs for
the corresponding devices. This will be removed when the SCIF and CMT
devices will be instantiated from the device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 30 +++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 4b48e2d..e1c787e 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -19,6 +19,8 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <mach/common.h>
@@ -28,7 +30,33 @@
 
 static void __init koelsch_add_standard_devices(void)
 {
-#ifndef CONFIG_COMMON_CLK
+#ifdef CONFIG_COMMON_CLK
+	/*
+	 * This is a really crude hack to provide clkdev support to the SCIF
+	 * and CMT devices until they get moved to DT.
+	 */
+	static const char * const scif_names[] = {
+		"scifa0", "scifa1", "scifb0", "scifb1", "scifb2", "scifa2",
+		"scif0", "scif1", "scif2", "scif3", "scif4", "scif5", "scifa3",
+		"scifa4", "scifa5",
+	};
+	struct clk *clk;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(scif_names); ++i) {
+		clk = clk_get(NULL, scif_names[i]);
+		if (clk) {
+			clk_register_clkdev(clk, NULL, "sh-sci.%u", i);
+			clk_put(clk);
+		}
+	}
+
+	clk = clk_get(NULL, "cmt0");
+	if (clk) {
+		clk_register_clkdev(clk, NULL, "sh_cmt.0");
+		clk_put(clk);
+	}
+#else
 	r8a7791_clock_init();
 #endif
 	r8a7791_add_dt_devices();
-- 
1.8.3.2

