From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 14:01:12 +0000
Subject: [PATCH 02/07] sh: scif and tmu clkdev changes
Message-Id: <20100510140112.32745.14842.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Modify sh7722/sh7723/sh7724 to use clkdev for
TMU and SCIF clock lookups.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   43 +++++++++++++++++++++++++++++---
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |   42 ++++++++++++++++++++++++++-----
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   42 ++++++++++++++++++++++++++-----
 3 files changed, 112 insertions(+), 15 deletions(-)

--- 0002/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2010-05-10 21:11:01.000000000 +0900
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
+#include <asm/clkdev.h>
 #include <asm/clock.h>
 #include <asm/hwblk.h>
 #include <cpu/sh7722.h>
@@ -164,9 +165,9 @@ static struct clk mstp_clks[HWBLK_NR] = 
 	SH_HWBLK_CLK("cmt_fck", -1, R_CLK, HWBLK_CMT, 0),
 	SH_HWBLK_CLK("rwdt0", -1, R_CLK, HWBLK_RWDT, 0),
 	SH_HWBLK_CLK("flctl0", -1, P_CLK, HWBLK_FLCTL, 0),
-	SH_HWBLK_CLK("sci_fck", 0, P_CLK, HWBLK_SCIF0, 0),
-	SH_HWBLK_CLK("sci_fck", 1, P_CLK, HWBLK_SCIF1, 0),
-	SH_HWBLK_CLK("sci_fck", 2, P_CLK, HWBLK_SCIF2, 0),
+	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF0, 0),
+	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF1, 0),
+	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF2, 0),
 
 	SH_HWBLK_CLK("i2c0", -1, P_CLK, HWBLK_IIC, 0),
 	SH_HWBLK_CLK("rtc0", -1, R_CLK, HWBLK_RTC, 0),
@@ -185,6 +186,40 @@ static struct clk mstp_clks[HWBLK_NR] = 
 	SH_HWBLK_CLK("lcdc0", -1, P_CLK, HWBLK_LCDC, 0),
 };
 
+static struct clk_lookup lookups[] = {
+	{
+		/* TMU0 */
+		.dev_id		= "sh_tmu.0",
+		.con_id		= "tmu_fck",
+		.clk		= &mstp_clks[HWBLK_TMU],
+	}, {
+		/* TMU1 */
+		.dev_id		= "sh_tmu.1",
+		.con_id		= "tmu_fck",
+		.clk		= &mstp_clks[HWBLK_TMU],
+	}, {
+		/* TMU2 */
+		.dev_id		= "sh_tmu.2",
+		.con_id		= "tmu_fck",
+		.clk		= &mstp_clks[HWBLK_TMU],
+	}, {
+		/* SCIF0 */
+		.dev_id		= "sh-sci.0",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF0],
+	}, {
+		/* SCIF1 */
+		.dev_id		= "sh-sci.1",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF1],
+	}, {
+		/* SCIF2 */
+		.dev_id		= "sh-sci.2",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF2],
+	},
+};
+
 int __init arch_clk_init(void)
 {
 	int k, ret = 0;
@@ -198,6 +233,8 @@ int __init arch_clk_init(void)
 	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
 		ret = clk_register(main_clks[k]);
 
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
 	if (!ret)
 		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
 
--- 0002/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7723.c	2010-05-10 21:10:56.000000000 +0900
@@ -179,12 +179,12 @@ static struct clk mstp_clks[] = {
 	SH_HWBLK_CLK("dmac1", -1, B_CLK, HWBLK_DMAC1, 0),
 	SH_HWBLK_CLK("tmu345_fck", -1, P_CLK, HWBLK_TMU1, 0),
 	SH_HWBLK_CLK("flctl0", -1, P_CLK, HWBLK_FLCTL, 0),
-	SH_HWBLK_CLK("sci_fck", 0, P_CLK, HWBLK_SCIF0, 0),
-	SH_HWBLK_CLK("sci_fck", 1, P_CLK, HWBLK_SCIF1, 0),
-	SH_HWBLK_CLK("sci_fck", 2, P_CLK, HWBLK_SCIF2, 0),
-	SH_HWBLK_CLK("sci_fck", 3, B_CLK, HWBLK_SCIF3, 0),
-	SH_HWBLK_CLK("sci_fck", 4, B_CLK, HWBLK_SCIF4, 0),
-	SH_HWBLK_CLK("sci_fck", 5, B_CLK, HWBLK_SCIF5, 0),
+	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF0, 0),
+	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF1, 0),
+	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF2, 0),
+	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF3, 0),
+	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF4, 0),
+	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF5, 0),
 	SH_HWBLK_CLK("msiof0", -1, B_CLK, HWBLK_MSIOF0, 0),
 	SH_HWBLK_CLK("msiof1", -1, B_CLK, HWBLK_MSIOF1, 0),
 	SH_HWBLK_CLK("meram0", -1, SH_CLK, HWBLK_MERAM, 0),
@@ -244,6 +244,36 @@ static struct clk_lookup lookups[] = {
 		.dev_id		= "sh_tmu.5",
 		.con_id		= "tmu_fck",
 		.clk		= &mstp_clks[HWBLK_TMU1],
+	}, {
+		/* SCIF0 */
+		.dev_id		= "sh-sci.0",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF0],
+	}, {
+		/* SCIF1 */
+		.dev_id		= "sh-sci.1",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF1],
+	}, {
+		/* SCIF2 */
+		.dev_id		= "sh-sci.2",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF2],
+	}, {
+		/* SCIF3 */
+		.dev_id		= "sh-sci.3",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF3],
+	}, {
+		/* SCIF4 */
+		.dev_id		= "sh-sci.4",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF4],
+	}, {
+		/* SCIF5 */
+		.dev_id		= "sh-sci.5",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF5],
 	},
 };
 
--- 0002/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 21:07:04.000000000 +0900
@@ -196,12 +196,12 @@ static struct clk mstp_clks[HWBLK_NR] = 
 	SH_HWBLK_CLK("rwdt0", -1, R_CLK, HWBLK_RWDT, 0),
 	SH_HWBLK_CLK("dmac1", -1, B_CLK, HWBLK_DMAC1, 0),
 	SH_HWBLK_CLK("tmu345_fck", -1, P_CLK, HWBLK_TMU1, 0),
-	SH_HWBLK_CLK("sci_fck", 0, P_CLK, HWBLK_SCIF0, 0),
-	SH_HWBLK_CLK("sci_fck", 1, P_CLK, HWBLK_SCIF1, 0),
-	SH_HWBLK_CLK("sci_fck", 2, P_CLK, HWBLK_SCIF2, 0),
-	SH_HWBLK_CLK("sci_fck", 3, B_CLK, HWBLK_SCIF3, 0),
-	SH_HWBLK_CLK("sci_fck", 4, B_CLK, HWBLK_SCIF4, 0),
-	SH_HWBLK_CLK("sci_fck", 5, B_CLK, HWBLK_SCIF5, 0),
+	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF0, 0),
+	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF1, 0),
+	SH_HWBLK_CLK("sci_fck", -1, P_CLK, HWBLK_SCIF2, 0),
+	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF3, 0),
+	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF4, 0),
+	SH_HWBLK_CLK("sci_fck", -1, B_CLK, HWBLK_SCIF5, 0),
 	SH_HWBLK_CLK("msiof0", -1, B_CLK, HWBLK_MSIOF0, 0),
 	SH_HWBLK_CLK("msiof1", -1, B_CLK, HWBLK_MSIOF1, 0),
 
@@ -266,6 +266,36 @@ static struct clk_lookup lookups[] = {
 		.dev_id		= "sh_tmu.5",
 		.con_id		= "tmu_fck",
 		.clk		= &mstp_clks[HWBLK_TMU1],
+	}, {
+		/* SCIF0 */
+		.dev_id		= "sh-sci.0",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF0],
+	}, {
+		/* SCIF1 */
+		.dev_id		= "sh-sci.1",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF1],
+	}, {
+		/* SCIF2 */
+		.dev_id		= "sh-sci.2",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF2],
+	}, {
+		/* SCIF3 */
+		.dev_id		= "sh-sci.3",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF3],
+	}, {
+		/* SCIF4 */
+		.dev_id		= "sh-sci.4",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF4],
+	}, {
+		/* SCIF5 */
+		.dev_id		= "sh-sci.5",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[HWBLK_SCIF5],
 	},
 };
 
