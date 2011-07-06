From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Jul 2011 01:18:12 +0000
Subject: [RFC][PATCH 3/8] sh: clock-sh7343: add CLKDEV_ICK_ID for cleanup
Message-Id: <87r564jjfx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |   28 +++++++---------------------
 1 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
index a6d1348..16e151f 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
@@ -196,6 +196,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 #define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
+#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
@@ -234,27 +235,12 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("rwdt0", &mstp_clks[MSTP013]),
 	CLKDEV_CON_ID("mfi0", &mstp_clks[MSTP011]),
 	CLKDEV_CON_ID("flctl0", &mstp_clks[MSTP010]),
-	{
-		/* SCIF0 */
-		.dev_id		= "sh-sci.0",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[MSTP007],
-	}, {
-		/* SCIF1 */
-		.dev_id		= "sh-sci.1",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[MSTP006],
-	}, {
-		/* SCIF2 */
-		.dev_id		= "sh-sci.2",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[MSTP005],
-	}, {
-		/* SCIF3 */
-		.dev_id		= "sh-sci.3",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[MSTP004],
-	},
+
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP007]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP006]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP005]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[MSTP004]),
+
 	CLKDEV_CON_ID("sio0", &mstp_clks[MSTP003]),
 	CLKDEV_CON_ID("siof0", &mstp_clks[MSTP002]),
 	CLKDEV_CON_ID("siof1", &mstp_clks[MSTP001]),
-- 
1.7.4.1

