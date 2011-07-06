From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Jul 2011 01:17:55 +0000
Subject: [RFC][PATCH 1/8] sh: clock-sh7724: add CLKDEV_ICK_ID for cleanup
Message-Id: <87tyb0jjge.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   79 +++++++-------------------------
 1 files changed, 17 insertions(+), 62 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index 77bcef5..0891876 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -254,6 +254,7 @@ static struct clk mstp_clks[HWBLK_NR] = {
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 #define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
+#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
@@ -290,71 +291,25 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("sh0", &mstp_clks[HWBLK_SHYWAY]),
 	CLKDEV_CON_ID("hudi0", &mstp_clks[HWBLK_HUDI]),
 	CLKDEV_CON_ID("ubc0", &mstp_clks[HWBLK_UBC]),
-	{
-		/* TMU0 */
-		.dev_id		= "sh_tmu.0",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[HWBLK_TMU0],
-	}, {
-		/* TMU1 */
-		.dev_id		= "sh_tmu.1",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[HWBLK_TMU0],
-	}, {
-		/* TMU2 */
-		.dev_id		= "sh_tmu.2",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[HWBLK_TMU0],
-	}, {
-		/* TMU3 */
-		.dev_id		= "sh_tmu.3",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[HWBLK_TMU1],
-	},
+
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.0", &mstp_clks[HWBLK_TMU0]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.1", &mstp_clks[HWBLK_TMU0]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.2", &mstp_clks[HWBLK_TMU0]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.3", &mstp_clks[HWBLK_TMU1]),
+
 	CLKDEV_CON_ID("cmt_fck", &mstp_clks[HWBLK_CMT]),
 	CLKDEV_CON_ID("rwdt0", &mstp_clks[HWBLK_RWDT]),
 	CLKDEV_CON_ID("dmac1", &mstp_clks[HWBLK_DMAC1]),
-	{
-		/* TMU4 */
-		.dev_id		= "sh_tmu.4",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[HWBLK_TMU1],
-	}, {
-		/* TMU5 */
-		.dev_id		= "sh_tmu.5",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[HWBLK_TMU1],
-	}, {
-		/* SCIF0 */
-		.dev_id		= "sh-sci.0",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[HWBLK_SCIF0],
-	}, {
-		/* SCIF1 */
-		.dev_id		= "sh-sci.1",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[HWBLK_SCIF1],
-	}, {
-		/* SCIF2 */
-		.dev_id		= "sh-sci.2",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[HWBLK_SCIF2],
-	}, {
-		/* SCIF3 */
-		.dev_id		= "sh-sci.3",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[HWBLK_SCIF3],
-	}, {
-		/* SCIF4 */
-		.dev_id		= "sh-sci.4",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[HWBLK_SCIF4],
-	}, {
-		/* SCIF5 */
-		.dev_id		= "sh-sci.5",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[HWBLK_SCIF5],
-	},
+
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.4", &mstp_clks[HWBLK_TMU1]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.5", &mstp_clks[HWBLK_TMU1]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[HWBLK_SCIF0]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[HWBLK_SCIF1]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[HWBLK_SCIF2]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[HWBLK_SCIF3]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.4", &mstp_clks[HWBLK_SCIF4]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[HWBLK_SCIF5]),
+
 	CLKDEV_CON_ID("msiof0", &mstp_clks[HWBLK_MSIOF0]),
 	CLKDEV_CON_ID("msiof1", &mstp_clks[HWBLK_MSIOF1]),
 	CLKDEV_CON_ID("keysc0", &mstp_clks[HWBLK_KEYSC]),
-- 
1.7.4.1

