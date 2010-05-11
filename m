From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 07:06:05 +0000
Subject: [PATCH 08/09] sh: sh7786 div4 clkdev lookup
Message-Id: <20100511070605.20792.45287.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add sh7786 DIV4 clocks to the clkdev lookup list.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- 0010/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7786.c	2010-05-11 15:10:33.000000000 +0900
@@ -133,6 +133,14 @@ static struct clk mstp_clks[MSTP_NR] = {
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
+	/* DIV4 clocks */
+	CLKDEV_CON_ID("peripheral_clk", &div4_clks[DIV4_P]),
+	CLKDEV_CON_ID("du_clk", &div4_clks[DIV4_DU]),
+	CLKDEV_CON_ID("ddr_clk", &div4_clks[DIV4_DDR]),
+	CLKDEV_CON_ID("bus_clk", &div4_clks[DIV4_B]),
+	CLKDEV_CON_ID("shyway_clk", &div4_clks[DIV4_SH]),
+	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
+
 	/* MSTP32 clocks */
 	{
 		/* SCIF5 */
