From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Jul 2011 01:18:03 +0000
Subject: [RFC][PATCH 2/8] sh: clock-sh7722: add CLKDEV_ICK_ID for cleanup
Message-Id: <87sjqkjjg6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   43 ++++++++-----------------------
 1 files changed, 11 insertions(+), 32 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
index e0e80d2..d39fcfb 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -177,6 +177,7 @@ static struct clk mstp_clks[HWBLK_NR] = {
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 #define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
+#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
@@ -202,41 +203,19 @@ static struct clk_lookup lookups[] = {
 	/* MSTP clocks */
 	CLKDEV_CON_ID("uram0", &mstp_clks[HWBLK_URAM]),
 	CLKDEV_CON_ID("xymem0", &mstp_clks[HWBLK_XYMEM]),
-	{
-		/* TMU0 */
-		.dev_id		= "sh_tmu.0",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[HWBLK_TMU],
-	}, {
-		/* TMU1 */
-		.dev_id		= "sh_tmu.1",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[HWBLK_TMU],
-	}, {
-		/* TMU2 */
-		.dev_id		= "sh_tmu.2",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[HWBLK_TMU],
-	},
+
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.0", &mstp_clks[HWBLK_TMU]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.1", &mstp_clks[HWBLK_TMU]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.2", &mstp_clks[HWBLK_TMU]),
+
 	CLKDEV_CON_ID("cmt_fck", &mstp_clks[HWBLK_CMT]),
 	CLKDEV_CON_ID("rwdt0", &mstp_clks[HWBLK_RWDT]),
 	CLKDEV_CON_ID("flctl0", &mstp_clks[HWBLK_FLCTL]),
-	{
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
-	},
+
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[HWBLK_SCIF0]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[HWBLK_SCIF1]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[HWBLK_SCIF2]),
+
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[HWBLK_IIC]),
 	CLKDEV_CON_ID("rtc0", &mstp_clks[HWBLK_RTC]),
 	CLKDEV_CON_ID("sdhi0", &mstp_clks[HWBLK_SDHI]),
-- 
1.7.4.1

