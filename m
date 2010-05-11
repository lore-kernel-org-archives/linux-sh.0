From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 07:05:17 +0000
Subject: [PATCH 02/09] sh: sh7722 div4 clkdev lookup
Message-Id: <20100511070517.20792.11828.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add sh7722 DIV4 clocks to the clkdev lookup list.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2010-05-11 14:46:39.000000000 +0900
@@ -186,6 +186,17 @@ static struct clk mstp_clks[HWBLK_NR] = 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
+	/* DIV4 clocks */
+	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
+	CLKDEV_CON_ID("umem_clk", &div4_clks[DIV4_U]),
+	CLKDEV_CON_ID("shyway_clk", &div4_clks[DIV4_SH]),
+	CLKDEV_CON_ID("bus_clk", &div4_clks[DIV4_B]),
+	CLKDEV_CON_ID("b3_clk", &div4_clks[DIV4_B3]),
+	CLKDEV_CON_ID("peripheral_clk", &div4_clks[DIV4_P]),
+	CLKDEV_CON_ID("irda_clk", &div4_enable_clks[DIV4_IRDA]),
+	CLKDEV_CON_ID("siua_clk", &div4_reparent_clks[DIV4_SIUA]),
+	CLKDEV_CON_ID("siub_clk", &div4_reparent_clks[DIV4_SIUB]),
+
 	/* DIV6 clocks */
 	CLKDEV_CON_ID("video_clk", &div6_clks[DIV6_V]),
 
