From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 04:59:04 +0000
Subject: [PATCH 05/09] sh: sh7785 mstp32 index rework
Message-Id: <20100511050014.26302.30427.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds sh7785 MSTP enums for mstp_clks[] index.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |   64 +++++++++++++++++---------------
 1 file changed, 35 insertions(+), 29 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2010-05-11 12:54:43.000000000 +0900
@@ -87,31 +87,37 @@ struct clk div4_clks[DIV4_NR] = {
 #define MSTPCR0		0xffc80030
 #define MSTPCR1		0xffc80034
 
-static struct clk mstp_clks[] = {
+enum { MSTP029, MSTP028, MSTP027, MSTP026, MSTP025, MSTP024,
+       MSTP021, MSTP020, MSTP017, MSTP016,
+       MSTP013, MSTP012, MSTP009, MSTP008, MSTP003, MSTP002,
+       MSTP119, MSTP117, MSTP105, MSTP104, MSTP100,
+       MSTP_NR };
+
+static struct clk mstp_clks[MSTP_NR] = {
 	/* MSTPCR0 */
-	SH_CLK_MSTP32("sci_fck", 5, &div4_clks[DIV4_P], MSTPCR0, 29, 0),
-	SH_CLK_MSTP32("sci_fck", 4, &div4_clks[DIV4_P], MSTPCR0, 28, 0),
-	SH_CLK_MSTP32("sci_fck", 3, &div4_clks[DIV4_P], MSTPCR0, 27, 0),
-	SH_CLK_MSTP32("sci_fck", 2, &div4_clks[DIV4_P], MSTPCR0, 26, 0),
-	SH_CLK_MSTP32("sci_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 25, 0),
-	SH_CLK_MSTP32("sci_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 24, 0),
-	SH_CLK_MSTP32("ssi_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 21, 0),
-	SH_CLK_MSTP32("ssi_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 20, 0),
-	SH_CLK_MSTP32("hac_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 17, 0),
-	SH_CLK_MSTP32("hac_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 16, 0),
-	SH_CLK_MSTP32("mmcif_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 13, 0),
-	SH_CLK_MSTP32("flctl_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 12, 0),
-	SH_CLK_MSTP32("tmu345_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 9, 0),
-	SH_CLK_MSTP32("tmu012_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 8, 0),
-	SH_CLK_MSTP32("siof_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 3, 0),
-	SH_CLK_MSTP32("hspi_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 2, 0),
+	[MSTP029] = SH_CLK_MSTP32("sci_fck", 5, &div4_clks[DIV4_P], MSTPCR0, 29, 0),
+	[MSTP028] = SH_CLK_MSTP32("sci_fck", 4, &div4_clks[DIV4_P], MSTPCR0, 28, 0),
+	[MSTP027] = SH_CLK_MSTP32("sci_fck", 3, &div4_clks[DIV4_P], MSTPCR0, 27, 0),
+	[MSTP026] = SH_CLK_MSTP32("sci_fck", 2, &div4_clks[DIV4_P], MSTPCR0, 26, 0),
+	[MSTP025] = SH_CLK_MSTP32("sci_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 25, 0),
+	[MSTP024] = SH_CLK_MSTP32("sci_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 24, 0),
+	[MSTP021] = SH_CLK_MSTP32("ssi_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 21, 0),
+	[MSTP020] = SH_CLK_MSTP32("ssi_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 20, 0),
+	[MSTP017] = SH_CLK_MSTP32("hac_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 17, 0),
+	[MSTP016] = SH_CLK_MSTP32("hac_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 16, 0),
+	[MSTP013] = SH_CLK_MSTP32("mmcif_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 13, 0),
+	[MSTP012] = SH_CLK_MSTP32("flctl_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 12, 0),
+	[MSTP009] = SH_CLK_MSTP32("tmu345_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 9, 0),
+	[MSTP008] = SH_CLK_MSTP32("tmu012_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 8, 0),
+	[MSTP003] = SH_CLK_MSTP32("siof_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 3, 0),
+	[MSTP002] = SH_CLK_MSTP32("hspi_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 2, 0),
 
 	/* MSTPCR1 */
-	SH_CLK_MSTP32("hudi_fck", -1, NULL, MSTPCR1, 19, 0),
-	SH_CLK_MSTP32("ubc_fck", -1, NULL, MSTPCR1, 17, 0),
-	SH_CLK_MSTP32("dmac_11_6_fck", -1, NULL, MSTPCR1, 5, 0),
-	SH_CLK_MSTP32("dmac_5_0_fck", -1, NULL, MSTPCR1, 4, 0),
-	SH_CLK_MSTP32("gdta_fck", -1, NULL, MSTPCR1, 0, 0),
+	[MSTP119] = SH_CLK_MSTP32("hudi_fck", -1, NULL, MSTPCR1, 19, 0),
+	[MSTP117] = SH_CLK_MSTP32("ubc_fck", -1, NULL, MSTPCR1, 17, 0),
+	[MSTP105] = SH_CLK_MSTP32("dmac_11_6_fck", -1, NULL, MSTPCR1, 5, 0),
+	[MSTP104] = SH_CLK_MSTP32("dmac_5_0_fck", -1, NULL, MSTPCR1, 4, 0),
+	[MSTP100] = SH_CLK_MSTP32("gdta_fck", -1, NULL, MSTPCR1, 0, 0),
 };
 
 static struct clk_lookup lookups[] = {
@@ -119,32 +125,32 @@ static struct clk_lookup lookups[] = {
 		/* TMU0 */
 		.dev_id		= "sh_tmu.0",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[13],	/* tmu012_fck */
+		.clk		= &mstp_clks[MSTP008],
 	}, {
 		/* TMU1 */
 		.dev_id		= "sh_tmu.1",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[13],
+		.clk		= &mstp_clks[MSTP008],
 	}, {
 		/* TMU2 */
 		.dev_id		= "sh_tmu.2",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[13],
+		.clk		= &mstp_clks[MSTP008],
 	}, {
 		/* TMU3 */
 		.dev_id		= "sh_tmu.3",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[12],	/* tmu345_fck */
+		.clk		= &mstp_clks[MSTP009],
 	}, {
 		/* TMU4 */
 		.dev_id		= "sh_tmu.4",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[12],
+		.clk		= &mstp_clks[MSTP009],
 	}, {
 		/* TMU5 */
 		.dev_id		= "sh_tmu.5",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[12],
+		.clk		= &mstp_clks[MSTP009],
 	},
 };
 
@@ -161,7 +167,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div4_register(div4_clks, ARRAY_SIZE(div4_clks),
 					   &div4_table);
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, ARRAY_SIZE(mstp_clks));
+		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
 
 	return ret;
 }
