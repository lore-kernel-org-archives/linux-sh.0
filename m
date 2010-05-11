From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 04:58:55 +0000
Subject: [PATCH 04/09] sh: sh7366 mstp32 clkdev lookup
Message-Id: <20100511050006.26302.99263.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add sh7366 MSTP clocks to the clkdev lookup table.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |   52 ++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

--- 0011/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7366.c	2010-05-11 12:41:43.000000000 +0900
@@ -205,6 +205,58 @@ static struct clk mstp_clks[MSTP_NR] = {
 static struct clk_lookup lookups[] = {
 	/* DIV6 clocks */
 	CLKDEV_CON_ID("video_clk", &div6_clks[DIV6_V]),
+
+	/* MSTP32 clocks */
+	CLKDEV_CON_ID("tlb0", &mstp_clks[MSTP031]),
+	CLKDEV_CON_ID("ic0", &mstp_clks[MSTP030]),
+	CLKDEV_CON_ID("oc0", &mstp_clks[MSTP029]),
+	CLKDEV_CON_ID("rsmem0", &mstp_clks[MSTP028]),
+	CLKDEV_CON_ID("xymem0", &mstp_clks[MSTP026]),
+	CLKDEV_CON_ID("intc3", &mstp_clks[MSTP023]),
+	CLKDEV_CON_ID("intc0", &mstp_clks[MSTP022]),
+	CLKDEV_CON_ID("dmac0", &mstp_clks[MSTP021]),
+	CLKDEV_CON_ID("sh0", &mstp_clks[MSTP020]),
+	CLKDEV_CON_ID("hudi0", &mstp_clks[MSTP019]),
+	CLKDEV_CON_ID("ubc0", &mstp_clks[MSTP017]),
+	CLKDEV_CON_ID("tmu_fck", &mstp_clks[MSTP015]),
+	CLKDEV_CON_ID("cmt_fck", &mstp_clks[MSTP014]),
+	CLKDEV_CON_ID("rwdt0", &mstp_clks[MSTP013]),
+	CLKDEV_CON_ID("mfi0", &mstp_clks[MSTP011]),
+	CLKDEV_CON_ID("flctl0", &mstp_clks[MSTP010]),
+	{
+		/* SCIF0 */
+		.dev_id		= "sh-sci.0",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[MSTP007],
+	}, {
+		/* SCIF1 */
+		.dev_id		= "sh-sci.1",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[MSTP006],
+	}, {
+		/* SCIF2 */
+		.dev_id		= "sh-sci.2",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[MSTP005],
+	},
+	CLKDEV_CON_ID("msiof0", &mstp_clks[MSTP002]),
+	CLKDEV_CON_ID("sbr0", &mstp_clks[MSTP001]),
+	CLKDEV_CON_ID("i2c0", &mstp_clks[MSTP109]),
+	CLKDEV_CON_ID("icb0", &mstp_clks[MSTP227]),
+	CLKDEV_CON_ID("meram0", &mstp_clks[MSTP226]),
+	CLKDEV_CON_ID("dacy1", &mstp_clks[MSTP224]),
+	CLKDEV_CON_ID("dacy0", &mstp_clks[MSTP223]),
+	CLKDEV_CON_ID("tsif0", &mstp_clks[MSTP222]),
+	CLKDEV_CON_ID("sdhi0", &mstp_clks[MSTP218]),
+	CLKDEV_CON_ID("mmcif0", &mstp_clks[MSTP217]),
+	CLKDEV_CON_ID("usbf0", &mstp_clks[MSTP211]),
+	CLKDEV_CON_ID("veu1", &mstp_clks[MSTP207]),
+	CLKDEV_CON_ID("vou0", &mstp_clks[MSTP205]),
+	CLKDEV_CON_ID("beu0", &mstp_clks[MSTP204]),
+	CLKDEV_CON_ID("ceu0", &mstp_clks[MSTP203]),
+	CLKDEV_CON_ID("veu0", &mstp_clks[MSTP202]),
+	CLKDEV_CON_ID("vpu0", &mstp_clks[MSTP201]),
+	CLKDEV_CON_ID("lcdc0", &mstp_clks[MSTP200]),
 };
 
 int __init arch_clk_init(void)
