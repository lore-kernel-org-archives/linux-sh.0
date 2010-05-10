From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 11:23:41 +0000
Subject: [PATCH 03/13] sh: Rework sh7724 SCIF clock lookup
Message-Id: <20100510112341.14587.27490.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Rework sh7724 SCIFS to use clkdev for lookup.
Prototype code only, needs to be done for all processors.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   42 +++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

--- 0003/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 18:38:37.000000000 +0900
@@ -196,12 +196,12 @@ static struct clk mstp_clks[HWBLK_NR] = 
 	SH_HWBLK_CLK("rwdt0", -1, R_CLK, HWBLK_RWDT, 0),
 	SH_HWBLK_CLK("dmac1", -1, B_CLK, HWBLK_DMAC1, 0),
 	SH_HWBLK_CLK("tmu345_fck", -1, P_CLK, HWBLK_TMU1, 0),
-	SH_HWBLK_CLK("sci_fck", 0, P_CLK, HWBLK_SCIF0, 0),
-	SH_HWBLK_CLK("sci_fck", 1, P_CLK, HWBLK_SCIF1, 0),
-	SH_HWBLK_CLK("sci_fck", 2, P_CLK, HWBLK_SCIF2, 0),
-	SH_HWBLK_CLK("sci_fck", 3, B_CLK, HWBLK_SCIF3, 0),
-	SH_HWBLK_CLK("sci_fck", 4, B_CLK, HWBLK_SCIF4, 0),
-	SH_HWBLK_CLK("sci_fck", 5, B_CLK, HWBLK_SCIF5, 0),
+	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF0, 0),
+	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF1, 0),
+	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF2, 0),
+	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF3, 0),
+	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF4, 0),
+	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF5, 0),
 	SH_HWBLK_CLK("msiof0", -1, B_CLK, HWBLK_MSIOF0, 0),
 	SH_HWBLK_CLK("msiof1", -1, B_CLK, HWBLK_MSIOF1, 0),
 
@@ -266,6 +266,36 @@ static struct clk_lookup lookups[] = {
 		.dev_id		= "sh_tmu.5",
 		.con_id		= "tmu_fck",
 		.clk		= &mstp_clks[HWBLK_TMU1],
+	}, {
+		/* SCIF0 */
+		.dev_id		= "sh-sci.0",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF0],
+	}, {
+		/* SCIF1 */
+		.dev_id		= "sh-sci.1",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF1],
+	}, {
+		/* SCIF2 */
+		.dev_id		= "sh-sci.2",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF2],
+	}, {
+		/* SCIF3 */
+		.dev_id		= "sh-sci.3",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF3],
+	}, {
+		/* SCIF4 */
+		.dev_id		= "sh-sci.4",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF4],
+	}, {
+		/* SCIF5 */
+		.dev_id		= "sh-sci.5",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF5],
 	},
 };
 
