From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 04:59:27 +0000
Subject: [PATCH 08/09] sh: sh7786 mstp32 clkdev lookup
Message-Id: <20100511050038.26302.62997.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add sh7786 MSTP clocks to the clkdev lookup table.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |   55 +++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

--- 0015/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7786.c	2010-05-11 13:26:38.000000000 +0900
@@ -130,7 +130,49 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP102] = SH_CLK_MSTP32("ether_fck", -1, NULL, MSTPCR1, 2, 0),
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
+	CLKDEV_CON_ID("ssi3_fck", &mstp_clks[MSTP023]),
+	CLKDEV_CON_ID("ssi2_fck", &mstp_clks[MSTP022]),
+	CLKDEV_CON_ID("ssi1_fck", &mstp_clks[MSTP021]),
+	CLKDEV_CON_ID("ssi0_fck", &mstp_clks[MSTP020]),
+	CLKDEV_CON_ID("hac1_fck", &mstp_clks[MSTP017]),
+	CLKDEV_CON_ID("hac0_fck", &mstp_clks[MSTP016]),
+	CLKDEV_CON_ID("i2c1_fck", &mstp_clks[MSTP015]),
+	CLKDEV_CON_ID("i2c0_fck", &mstp_clks[MSTP014]),
 	{
 		/* TMU0 */
 		.dev_id		= "sh_tmu.0",
@@ -191,7 +233,18 @@ static struct clk_lookup lookups[] = {
 		.dev_id		= "sh_tmu.11",
 		.con_id		= "tmu_fck",
 		.clk		= &mstp_clks[MSTP011],
-	}
+	},
+	CLKDEV_CON_ID("sdif1_fck", &mstp_clks[MSTP005]),
+	CLKDEV_CON_ID("sdif0_fck", &mstp_clks[MSTP004]),
+	CLKDEV_CON_ID("hspi_fck", &mstp_clks[MSTP002]),
+	CLKDEV_CON_ID("usb_fck", &mstp_clks[MSTP112]),
+	CLKDEV_CON_ID("pcie2_fck", &mstp_clks[MSTP110]),
+	CLKDEV_CON_ID("pcie1_fck", &mstp_clks[MSTP109]),
+	CLKDEV_CON_ID("pcie0_fck", &mstp_clks[MSTP108]),
+	CLKDEV_CON_ID("dmac_11_6_fck", &mstp_clks[MSTP105]),
+	CLKDEV_CON_ID("dmac_5_0_fck", &mstp_clks[MSTP104]),
+	CLKDEV_CON_ID("du_fck", &mstp_clks[MSTP103]),
+	CLKDEV_CON_ID("ether_fck", &mstp_clks[MSTP102]),
 };
 
 int __init arch_clk_init(void)
