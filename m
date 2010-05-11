From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 07:05:58 +0000
Subject: [PATCH 07/09] sh: sh7785 div4 clkdev lookup
Message-Id: <20100511070558.20792.9499.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add sh7785 DIV4 clocks to the clkdev lookup list.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- 0010/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2010-05-11 15:06:57.000000000 +0900
@@ -123,6 +123,16 @@ static struct clk mstp_clks[MSTP_NR] = {
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
+	/* DIV4 clocks */
+	CLKDEV_CON_ID("peripheral_clk", &div4_clks[DIV4_P]),
+	CLKDEV_CON_ID("du_clk", &div4_clks[DIV4_DU]),
+	CLKDEV_CON_ID("ga_clk", &div4_clks[DIV4_GA]),
+	CLKDEV_CON_ID("ddr_clk", &div4_clks[DIV4_DDR]),
+	CLKDEV_CON_ID("bus_clk", &div4_clks[DIV4_B]),
+	CLKDEV_CON_ID("shyway_clk", &div4_clks[DIV4_SH]),
+	CLKDEV_CON_ID("umem_clk", &div4_clks[DIV4_U]),
+	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
+
 	/* MSTP32 clocks */
 	{
 		/* SCIF5 */
