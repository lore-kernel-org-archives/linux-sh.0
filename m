From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 01:03:44 +0000
Subject: [PATCH v3 07/15] ARM: shmobile: lager-reference: Instantiate clkdevs for SCIF and CMT
Message-Id: <1385600632-5181-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now that the common clock framework is supported, the clock lookup
entries in clock-r8a7790.c are not registered anymore. Devices must
instead reference their clocks in the device tree. However, SCIF and CMT
devices are still instantiated through platform code, and thus need a
clock lookup entry.

Retrieve the SCIF and CMT clock entries by name and register clkdevs for
the corresponding devices. This will be removed when the SCIF and CMT
devices will be instantiated from the device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 396ef28..85a744b 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -18,6 +18,8 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk.h>
+#include <linux/clkdev.h>
 #include <linux/clk/shmobile.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
@@ -35,6 +37,32 @@ static void __init lager_init_time(void)
 
 static void __init lager_add_standard_devices(void)
 {
+	/*
+	 * This is a really crude hack to provide clkdev support to the SCIF
+	 * and CMT devices until they get moved to DT.
+	 */
+	static const char * const scif_names[] = {
+		"scifa0", "scifa1", "scifb0", "scifb1",
+		"scifb2", "scifa2", "scif0", "scif1",
+		"hscif0", "hscif1",
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
+
 	r8a7790_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
1.8.3.2

