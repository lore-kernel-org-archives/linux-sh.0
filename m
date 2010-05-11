From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 04:59:50 +0000
Subject: [PATCH 02/09] sh: sh7343 mstp32 clkdev lookup
Message-Id: <20100511045950.26302.96420.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add sh7343 MSTP clocks to the clkdev lookup table.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |   62 ++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

--- 0009/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7343.c	2010-05-11 12:20:33.000000000 +0900
@@ -207,6 +207,68 @@ static struct clk mstp_clks[MSTP_NR] = {
 static struct clk_lookup lookups[] = {
 	/* DIV6 clocks */
 	CLKDEV_CON_ID("video_clk", &div6_clks[DIV6_V]),
+
+	/* MSTP32 clocks */
+	CLKDEV_CON_ID("tlb0", &mstp_clks[MSTP031]),
+	CLKDEV_CON_ID("ic0", &mstp_clks[MSTP030]),
+	CLKDEV_CON_ID("oc0", &mstp_clks[MSTP029]),
+	CLKDEV_CON_ID("uram0", &mstp_clks[MSTP028]),
+	CLKDEV_CON_ID("xymem0", &mstp_clks[MSTP026]),
+	CLKDEV_CON_ID("intc3", &mstp_clks[MSTP023]),
+	CLKDEV_CON_ID("intc0", &mstp_clks[MSTP022]),
+
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
+	}, {
+		/* SCIF3 */
+		.dev_id		= "sh-sci.3",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[MSTP004],
+	},
+	CLKDEV_CON_ID("sio0", &mstp_clks[MSTP003]),
+	CLKDEV_CON_ID("siof0", &mstp_clks[MSTP002]),
+	CLKDEV_CON_ID("siof1", &mstp_clks[MSTP001]),
+	CLKDEV_CON_ID("i2c0", &mstp_clks[MSTP109]),
+	CLKDEV_CON_ID("i2c1", &mstp_clks[MSTP108]),
+	CLKDEV_CON_ID("tpu0", &mstp_clks[MSTP225]),
+	CLKDEV_CON_ID("irda0", &mstp_clks[MSTP224]),
+	CLKDEV_CON_ID("sdhi0", &mstp_clks[MSTP218]),
+	CLKDEV_CON_ID("mmcif0", &mstp_clks[MSTP217]),
+	CLKDEV_CON_ID("sim0", &mstp_clks[MSTP216]),
+	CLKDEV_CON_ID("keysc0", &mstp_clks[MSTP214]),
+	CLKDEV_CON_ID("tsif0", &mstp_clks[MSTP213]),
+	CLKDEV_CON_ID("s3d40", &mstp_clks[MSTP212]),
+	CLKDEV_CON_ID("usbf0", &mstp_clks[MSTP211]),
+	CLKDEV_CON_ID("siu0", &mstp_clks[MSTP208]),
+	CLKDEV_CON_ID("jpu0", &mstp_clks[MSTP206]),
+	CLKDEV_CON_ID("vou0", &mstp_clks[MSTP205]),
+	CLKDEV_CON_ID("beu0", &mstp_clks[MSTP204]),
+	CLKDEV_CON_ID("ceu0", &mstp_clks[MSTP203]),
+	CLKDEV_CON_ID("veu0", &mstp_clks[MSTP202]),
+	CLKDEV_CON_ID("vpu0", &mstp_clks[MSTP201]),
+	CLKDEV_CON_ID("lcdc0", &mstp_clks[MSTP200]),
 };
 
 int __init arch_clk_init(void)
