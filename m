From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Jul 2011 01:18:53 +0000
Subject: [RFC][PATCH 8/8] sh: clock-shx3: add CLKDEV_ICK_ID for cleanup
Message-Id: <87k4bwjjes.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-shx3.c |   66 +++++++--------------------------
 1 files changed, 14 insertions(+), 52 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-shx3.c b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
index 1afdb93..a9ba4f1 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
@@ -101,6 +101,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
@@ -116,62 +117,23 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP32 clocks */
-	{
-		/* SCIF3 */
-		.dev_id		= "sh-sci.3",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[MSTP027],
-	}, {
-		/* SCIF2 */
-		.dev_id		= "sh-sci.2",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[MSTP026],
-	}, {
-		/* SCIF1 */
-		.dev_id		= "sh-sci.1",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[MSTP025],
-	}, {
-		/* SCIF0 */
-		.dev_id		= "sh-sci.0",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[MSTP024],
-	},
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[MSTP027]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP026]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP025]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP024]),
+
 	CLKDEV_CON_ID("h8ex_fck", &mstp_clks[MSTP003]),
 	CLKDEV_CON_ID("csm_fck", &mstp_clks[MSTP002]),
 	CLKDEV_CON_ID("fe1_fck", &mstp_clks[MSTP001]),
 	CLKDEV_CON_ID("fe0_fck", &mstp_clks[MSTP000]),
-	{
-		/* TMU0 */
-		.dev_id		= "sh_tmu.0",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP008],
-	}, {
-		/* TMU1 */
-		.dev_id		= "sh_tmu.1",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP008],
-	}, {
-		/* TMU2 */
-		.dev_id		= "sh_tmu.2",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP008],
-	}, {
-		/* TMU3 */
-		.dev_id		= "sh_tmu.3",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP009],
-	}, {
-		/* TMU4 */
-		.dev_id		= "sh_tmu.4",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP009],
-	}, {
-		/* TMU5 */
-		.dev_id		= "sh_tmu.5",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP009],
-	},
+
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.0", &mstp_clks[MSTP008]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.1", &mstp_clks[MSTP008]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.2", &mstp_clks[MSTP008]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.3", &mstp_clks[MSTP009]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.4", &mstp_clks[MSTP009]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.5", &mstp_clks[MSTP009]),
+
 	CLKDEV_CON_ID("hudi_fck", &mstp_clks[MSTP119]),
 	CLKDEV_CON_ID("dmac_11_6_fck", &mstp_clks[MSTP105]),
 	CLKDEV_CON_ID("dmac_5_0_fck", &mstp_clks[MSTP104]),
-- 
1.7.4.1

