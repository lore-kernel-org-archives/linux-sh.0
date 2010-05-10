From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 11:24:43 +0000
Subject: [PATCH 11/13] sh: Use clkdev for sh7724 main clocks
Message-Id: <20100510112443.14587.99304.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Use clkdev for sh7724 main clocks.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0011/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 19:29:57.000000000 +0900
@@ -244,6 +244,12 @@ static struct clk mstp_clks[HWBLK_NR] = 
 }
 
 static struct clk_lookup lookups[] = {
+	CLKDEV_NO_DEV("rclk", &r_clk),
+	CLKDEV_NO_DEV("extal", &extal_clk),
+	CLKDEV_NO_DEV("fll_clk", &fll_clk),
+	CLKDEV_NO_DEV("pll_clk", &pll_clk),
+	CLKDEV_NO_DEV("div3_clk", &div3_clk),
+
 	CLKDEV_NO_DEV("cpu_clk", &div4_clks[DIV4_I]),
 	CLKDEV_NO_DEV("shyway_clk", &div4_clks[DIV4_SH]),
 	CLKDEV_NO_DEV("bus_clk", &div4_clks[DIV4_B]),
