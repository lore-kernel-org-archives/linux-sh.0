From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 16 Feb 2014 21:31:58 +0000
Subject: [PATCH v3 1/4] ARM: shmobile: lager-reference: Refactor clock lookup hack
Message-Id: <1392586321-12187-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Make the clock lookup hack more generic to ease the addition of more
devices.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 37 +++++++++++++++-----------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index dc8d76b..634ef15 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -31,30 +31,37 @@ static void __init lager_add_standard_devices(void)
 {
 #ifdef CONFIG_COMMON_CLK
 	/*
-	 * This is a really crude hack to provide clkdev support to the SCIF
-	 * and CMT devices until they get moved to DT.
+	 * This is a really crude hack to provide clkdev support to platform
+	 * devices until they get moved to DT.
 	 */
-	static const char * const scif_names[] = {
-		"scifa0", "scifa1", "scifb0", "scifb1",
-		"scifb2", "scifa2", "scif0", "scif1",
-		"hscif0", "hscif1",
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
+		{ "hscif0", NULL, "sh-sci.8" },
+		{ "hscif1", NULL, "sh-sci.9" },
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
 	r8a7790_clock_init();
 #endif
-- 
1.8.3.2

