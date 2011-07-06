From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Jul 2011 01:18:27 +0000
Subject: [RFC][PATCH 5/8] sh: clock-sh7757: add CLKDEV_ICK_ID for cleanup
Message-Id: <87oc18jjfi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |   35 +++++++------------------------
 1 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index eedddad..86bf188 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -102,6 +102,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* main clocks */
@@ -116,33 +117,13 @@ static struct clk_lookup lookups[] = {
 	/* MSTP32 clocks */
 	CLKDEV_CON_ID("sdhi0", &mstp_clks[MSTP004]),
 	CLKDEV_CON_ID("riic", &mstp_clks[MSTP000]),
-	{
-		/* TMU0 */
-		.dev_id		= "sh_tmu.0",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP113],
-	}, {
-		/* TMU1 */
-		.dev_id		= "sh_tmu.1",
-		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[MSTP114],
-	},
-	{
-		/* SCIF4 (But, ID is 2) */
-		.dev_id		= "sh-sci.2",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[MSTP112],
-	}, {
-		/* SCIF3 */
-		.dev_id		= "sh-sci.1",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[MSTP111],
-	}, {
-		/* SCIF2 */
-		.dev_id		= "sh-sci.0",
-		.con_id		= "sci_fck",
-		.clk		= &mstp_clks[MSTP110],
-	},
+
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.0", &mstp_clks[MSTP113]),
+	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.1", &mstp_clks[MSTP114]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP112]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP111]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP110]),
+
 	CLKDEV_CON_ID("usb0", &mstp_clks[MSTP102]),
 	CLKDEV_CON_ID("mmc0", &mstp_clks[MSTP220]),
 };
-- 
1.7.4.1

