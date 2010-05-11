From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 07:05:32 +0000
Subject: [PATCH 04/09] sh: sh7724 div4 clkdev lookup
Message-Id: <20100511070532.20792.50767.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add sh7724 DIV4 clocks to the clkdev lookup list.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-11 14:54:58.000000000 +0900
@@ -234,6 +234,13 @@ static struct clk mstp_clks[HWBLK_NR] = 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
+	/* DIV4 clocks */
+	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
+	CLKDEV_CON_ID("shyway_clk", &div4_clks[DIV4_SH]),
+	CLKDEV_CON_ID("bus_clk", &div4_clks[DIV4_B]),
+	CLKDEV_CON_ID("peripheral_clk", &div4_clks[DIV4_P]),
+	CLKDEV_CON_ID("vpu_clk", &div4_clks[DIV4_M1]),
+
 	/* DIV6 clocks */
 	CLKDEV_CON_ID("video_clk", &div6_clks[DIV6_V]),
 	CLKDEV_CON_ID("fsia_clk", &div6_clks[DIV6_FA]),
