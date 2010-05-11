From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 04:59:18 +0000
Subject: [PATCH 07/09] sh: sh7786 mstp32 index rework
Message-Id: <20100511050030.26302.72039.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds sh7786 MSTP enums for mstp_clks[] index.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |   94 +++++++++++++++++---------------
 1 file changed, 51 insertions(+), 43 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7786.c	2010-05-11 13:14:31.000000000 +0900
@@ -87,39 +87,47 @@ struct clk div4_clks[DIV4_NR] = {
 #define MSTPCR0		0xffc40030
 #define MSTPCR1		0xffc40034
 
-static struct clk mstp_clks[] = {
+enum { MSTP029, MSTP028, MSTP027, MSTP026, MSTP025, MSTP024,
+       MSTP023, MSTP022, MSTP021, MSTP020, MSTP017, MSTP016,
+       MSTP015, MSTP014, MSTP011, MSTP010, MSTP009, MSTP008,
+       MSTP005, MSTP004, MSTP002,
+       MSTP112, MSTP110, MSTP109, MSTP108,
+       MSTP105, MSTP104, MSTP103, MSTP102,
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
-	SH_CLK_MSTP32("ssi_fck", 3, &div4_clks[DIV4_P], MSTPCR0, 23, 0),
-	SH_CLK_MSTP32("ssi_fck", 2, &div4_clks[DIV4_P], MSTPCR0, 22, 0),
-	SH_CLK_MSTP32("ssi_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 21, 0),
-	SH_CLK_MSTP32("ssi_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 20, 0),
-	SH_CLK_MSTP32("hac_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 17, 0),
-	SH_CLK_MSTP32("hac_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 16, 0),
-	SH_CLK_MSTP32("i2c_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 15, 0),
-	SH_CLK_MSTP32("i2c_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 14, 0),
-	SH_CLK_MSTP32("tmu9_11_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 11, 0),
-	SH_CLK_MSTP32("tmu678_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 10, 0),
-	SH_CLK_MSTP32("tmu345_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 9, 0),
-	SH_CLK_MSTP32("tmu012_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 8, 0),
-	SH_CLK_MSTP32("sdif_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 5, 0),
-	SH_CLK_MSTP32("sdif_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 4, 0),
-	SH_CLK_MSTP32("hspi_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 2, 0),
+	[MSTP029] = SH_CLK_MSTP32("sci_fck", 5, &div4_clks[DIV4_P], MSTPCR0, 29, 0),
+	[MSTP028] = SH_CLK_MSTP32("sci_fck", 4, &div4_clks[DIV4_P], MSTPCR0, 28, 0),
+	[MSTP027] = SH_CLK_MSTP32("sci_fck", 3, &div4_clks[DIV4_P], MSTPCR0, 27, 0),
+	[MSTP026] = SH_CLK_MSTP32("sci_fck", 2, &div4_clks[DIV4_P], MSTPCR0, 26, 0),
+	[MSTP025] = SH_CLK_MSTP32("sci_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 25, 0),
+	[MSTP024] = SH_CLK_MSTP32("sci_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 24, 0),
+	[MSTP023] = SH_CLK_MSTP32("ssi_fck", 3, &div4_clks[DIV4_P], MSTPCR0, 23, 0),
+	[MSTP022] = SH_CLK_MSTP32("ssi_fck", 2, &div4_clks[DIV4_P], MSTPCR0, 22, 0),
+	[MSTP021] = SH_CLK_MSTP32("ssi_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 21, 0),
+	[MSTP020] = SH_CLK_MSTP32("ssi_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 20, 0),
+	[MSTP017] = SH_CLK_MSTP32("hac_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 17, 0),
+	[MSTP016] = SH_CLK_MSTP32("hac_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 16, 0),
+	[MSTP015] = SH_CLK_MSTP32("i2c_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 15, 0),
+	[MSTP014] = SH_CLK_MSTP32("i2c_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 14, 0),
+	[MSTP011] = SH_CLK_MSTP32("tmu9_11_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 11, 0),
+	[MSTP010] = SH_CLK_MSTP32("tmu678_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 10, 0),
+	[MSTP009] = SH_CLK_MSTP32("tmu345_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 9, 0),
+	[MSTP008] = SH_CLK_MSTP32("tmu012_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 8, 0),
+	[MSTP005] = SH_CLK_MSTP32("sdif_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 5, 0),
+	[MSTP004] = SH_CLK_MSTP32("sdif_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 4, 0),
+	[MSTP002] = SH_CLK_MSTP32("hspi_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 2, 0),
 
 	/* MSTPCR1 */
-	SH_CLK_MSTP32("usb_fck", -1, NULL, MSTPCR1, 12, 0),
-	SH_CLK_MSTP32("pcie_fck", 2, NULL, MSTPCR1, 10, 0),
-	SH_CLK_MSTP32("pcie_fck", 1, NULL, MSTPCR1, 9, 0),
-	SH_CLK_MSTP32("pcie_fck", 0, NULL, MSTPCR1, 8, 0),
-	SH_CLK_MSTP32("dmac_11_6_fck", -1, NULL, MSTPCR1, 5, 0),
-	SH_CLK_MSTP32("dmac_5_0_fck", -1, NULL, MSTPCR1, 4, 0),
-	SH_CLK_MSTP32("du_fck", -1, NULL, MSTPCR1, 3, 0),
-	SH_CLK_MSTP32("ether_fck", -1, NULL, MSTPCR1, 2, 0),
+	[MSTP112] = SH_CLK_MSTP32("usb_fck", -1, NULL, MSTPCR1, 12, 0),
+	[MSTP110] = SH_CLK_MSTP32("pcie_fck", 2, NULL, MSTPCR1, 10, 0),
+	[MSTP109] = SH_CLK_MSTP32("pcie_fck", 1, NULL, MSTPCR1, 9, 0),
+	[MSTP108] = SH_CLK_MSTP32("pcie_fck", 0, NULL, MSTPCR1, 8, 0),
+	[MSTP105] = SH_CLK_MSTP32("dmac_11_6_fck", -1, NULL, MSTPCR1, 5, 0),
+	[MSTP104] = SH_CLK_MSTP32("dmac_5_0_fck", -1, NULL, MSTPCR1, 4, 0),
+	[MSTP103] = SH_CLK_MSTP32("du_fck", -1, NULL, MSTPCR1, 3, 0),
+	[MSTP102] = SH_CLK_MSTP32("ether_fck", -1, NULL, MSTPCR1, 2, 0),
 };
 
 static struct clk_lookup lookups[] = {
@@ -127,62 +135,62 @@ static struct clk_lookup lookups[] = {
 		/* TMU0 */
 		.dev_id		= "sh_tmu.0",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[17],	/* tmu012_fck */
+		.clk		= &mstp_clks[MSTP008],
 	}, {
 		/* TMU1 */
 		.dev_id		= "sh_tmu.1",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[17],
+		.clk		= &mstp_clks[MSTP008],
 	}, {
 		/* TMU2 */
 		.dev_id		= "sh_tmu.2",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[17],
+		.clk		= &mstp_clks[MSTP008],
 	}, {
 		/* TMU3 */
 		.dev_id		= "sh_tmu.3",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[16],	/* tmu345_fck */
+		.clk		= &mstp_clks[MSTP009],
 	}, {
 		/* TMU4 */
 		.dev_id		= "sh_tmu.4",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[16],
+		.clk		= &mstp_clks[MSTP009],
 	}, {
 		/* TMU5 */
 		.dev_id		= "sh_tmu.5",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[16],
+		.clk		= &mstp_clks[MSTP009],
 	}, {
 		/* TMU6 */
 		.dev_id		= "sh_tmu.6",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[15],	/* tmu678_fck */
+		.clk		= &mstp_clks[MSTP010],
 	}, {
 		/* TMU7 */
 		.dev_id		= "sh_tmu.7",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[15],
+		.clk		= &mstp_clks[MSTP010],
 	}, {
 		/* TMU8 */
 		.dev_id		= "sh_tmu.8",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[15],
+		.clk		= &mstp_clks[MSTP010],
 	}, {
 		/* TMU9 */
 		.dev_id		= "sh_tmu.9",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[14],	/* tmu9_11_fck */
+		.clk		= &mstp_clks[MSTP011],
 	}, {
 		/* TMU10 */
 		.dev_id		= "sh_tmu.10",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[14],
+		.clk		= &mstp_clks[MSTP011],
 	}, {
 		/* TMU11 */
 		.dev_id		= "sh_tmu.11",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[14],
+		.clk		= &mstp_clks[MSTP011],
 	}
 };
 
@@ -199,7 +207,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div4_register(div4_clks, ARRAY_SIZE(div4_clks),
 					   &div4_table);
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, ARRAY_SIZE(mstp_clks));
+		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
 
 	return ret;
 }
