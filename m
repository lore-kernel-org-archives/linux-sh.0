From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 04:59:11 +0000
Subject: [PATCH 06/09] sh: sh7785 mstp32 clkdev lookup
Message-Id: <20100511050022.26302.96280.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add sh7785 MSTP clocks to the clkdev lookup table.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |   47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

--- 0013/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2010-05-11 13:03:53.000000000 +0900
@@ -120,7 +120,47 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP100] = SH_CLK_MSTP32("gdta_fck", -1, NULL, MSTPCR1, 0, 0),
 };
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
 static struct clk_lookup lookups[] = {
+	/* MSTP32 clocks */
+	{
+		/* SCIF5 */
+		.dev_id		= "sh-sci.5",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[MSTP029],
+	}, {
+		/* SCIF4 */
+		.dev_id		= "sh-sci.4",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[MSTP028],
+	}, {
+		/* SCIF3 */
+		.dev_id		= "sh-sci.3",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[MSTP027],
+	}, {
+		/* SCIF2 */
+		.dev_id		= "sh-sci.2",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[MSTP026],
+	}, {
+		/* SCIF1 */
+		.dev_id		= "sh-sci.1",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[MSTP025],
+	}, {
+		/* SCIF0 */
+		.dev_id		= "sh-sci.0",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[MSTP024],
+	},
+	CLKDEV_CON_ID("ssi1_fck", &mstp_clks[MSTP021]),
+	CLKDEV_CON_ID("ssi0_fck", &mstp_clks[MSTP020]),
+	CLKDEV_CON_ID("hac1_fck", &mstp_clks[MSTP017]),
+	CLKDEV_CON_ID("hac0_fck", &mstp_clks[MSTP016]),
+	CLKDEV_CON_ID("mmcif_fck", &mstp_clks[MSTP013]),
+	CLKDEV_CON_ID("flctl_fck", &mstp_clks[MSTP012]),
 	{
 		/* TMU0 */
 		.dev_id		= "sh_tmu.0",
@@ -152,6 +192,13 @@ static struct clk_lookup lookups[] = {
 		.con_id		= "tmu_fck",
 		.clk		= &mstp_clks[MSTP009],
 	},
+	CLKDEV_CON_ID("siof_fck", &mstp_clks[MSTP003]),
+	CLKDEV_CON_ID("hspi_fck", &mstp_clks[MSTP002]),
+	CLKDEV_CON_ID("hudi_fck", &mstp_clks[MSTP119]),
+	CLKDEV_CON_ID("ubc_fck", &mstp_clks[MSTP117]),
+	CLKDEV_CON_ID("dmac_11_6_fck", &mstp_clks[MSTP105]),
+	CLKDEV_CON_ID("dmac_5_0_fck", &mstp_clks[MSTP104]),
+	CLKDEV_CON_ID("gdta_fck", &mstp_clks[MSTP100]),
 };
 
 int __init arch_clk_init(void)
