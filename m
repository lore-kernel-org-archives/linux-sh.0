From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Jul 2011 01:18:47 +0000
Subject: [RFC][PATCH 7/8] sh: clock-sh7786: add CLKDEV_ICK_ID for cleanup
Message-Id: <87liwcjjey.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |  114 ++++++-------------------------
 1 files changed, 22 insertions(+), 92 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
index 42e403b..5a5d209 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
@@ -126,6 +126,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
@@ -141,37 +142,13 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP32 clocks */
-	{
-		/* SCIF5 */
-		.dev_id		= "sh-sci.5",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[MSTP029],
-	}, {
-		/* SCIF4 */
-		.dev_id		= "sh-sci.4",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[MSTP028],
-	}, {
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
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[MSTP029]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.4", &mstp_clks[MSTP028]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[MSTP027]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP026]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP025]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP024]),
+
 	CLKDEV_CON_ID("ssi3_fck", &mstp_clks[MSTP023]),
 	CLKDEV_CON_ID("ssi2_fck", &mstp_clks[MSTP022]),
 	CLKDEV_CON_ID("ssi1_fck", &mstp_clks[MSTP021]),
@@ -180,67 +157,20 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("hac0_fck", &mstp_clks[MSTP016]),
 	CLKDEV_CON_ID("i2c1_fck", &mstp_clks[MSTP015]),
 	CLKDEV_CON_ID("i2c0_fck", &mstp_clks[MSTP014]),
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
-	}, {
-		/* TMU6 */
-		.dev_id		= "sh_tmu.6",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP010],
-	}, {
-		/* TMU7 */
-		.dev_id		= "sh_tmu.7",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP010],
-	}, {
-		/* TMU8 */
-		.dev_id		= "sh_tmu.8",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP010],
-	}, {
-		/* TMU9 */
-		.dev_id		= "sh_tmu.9",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP011],
-	}, {
-		/* TMU10 */
-		.dev_id		= "sh_tmu.10",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP011],
-	}, {
-		/* TMU11 */
-		.dev_id		= "sh_tmu.11",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP011],
-	},
+
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.0", &mstp_clks[MSTP008]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.1", &mstp_clks[MSTP008]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.2", &mstp_clks[MSTP008]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.3", &mstp_clks[MSTP009]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.4", &mstp_clks[MSTP009]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.5", &mstp_clks[MSTP009]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.6", &mstp_clks[MSTP010]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.7", &mstp_clks[MSTP010]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.8", &mstp_clks[MSTP010]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.9", &mstp_clks[MSTP011]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.10", &mstp_clks[MSTP011]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.11", &mstp_clks[MSTP011]),
+
 	CLKDEV_CON_ID("sdif1_fck", &mstp_clks[MSTP005]),
 	CLKDEV_CON_ID("sdif0_fck", &mstp_clks[MSTP004]),
 	CLKDEV_CON_ID("hspi_fck", &mstp_clks[MSTP002]),
-- 
1.7.4.1

