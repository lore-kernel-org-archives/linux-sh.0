From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 11:23:33 +0000
Subject: [PATCH 02/13] sh: Rework sh7724 hwblk index
Message-Id: <20100510112333.14587.6250.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the sh7724 hwblk code to use HWBLK_ as index.
Prototype code only, needs to be done for all processors.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/hwblk.h            |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

--- 0001/arch/sh/include/asm/hwblk.h
+++ work/arch/sh/include/asm/hwblk.h	2010-05-10 18:30:09.000000000 +0900
@@ -59,7 +59,7 @@ void hwblk_cnt_dec(struct hwblk_info *in
 
 /* allow clocks to enable and disable hardware blocks */
 #define SH_HWBLK_CLK(_name, _id, _parent, _hwblk, _flags)	\
-{							\
+[_hwblk] = {							\
 	.name		= _name,			\
 	.id		= _id,				\
 	.parent		= _parent,			\
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 18:31:19.000000000 +0900
@@ -178,7 +178,7 @@ struct clk div6_clks[] = {
 #define I_CLK (&div4_clks[DIV4_I])
 #define SH_CLK (&div4_clks[DIV4_SH])
 
-static struct clk mstp_clks[] = {
+static struct clk mstp_clks[HWBLK_NR] = {
 	SH_HWBLK_CLK("tlb0", -1, I_CLK, HWBLK_TLB, CLK_ENABLE_ON_INIT),
 	SH_HWBLK_CLK("ic0", -1, I_CLK, HWBLK_IC, CLK_ENABLE_ON_INIT),
 	SH_HWBLK_CLK("oc0", -1, I_CLK, HWBLK_OC, CLK_ENABLE_ON_INIT),
@@ -240,32 +240,32 @@ static struct clk_lookup lookups[] = {
 		/* TMU0 */
 		.dev_id		= "sh_tmu.0",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[12],	/* tmu012_fck */
+		.clk		= &mstp_clks[HWBLK_TMU0],
 	}, {
 		/* TMU1 */
 		.dev_id		= "sh_tmu.1",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[12],
+		.clk		= &mstp_clks[HWBLK_TMU0],
 	}, {
 		/* TMU2 */
 		.dev_id		= "sh_tmu.2",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[12],
+		.clk		= &mstp_clks[HWBLK_TMU0],
 	}, {
 		/* TMU3 */
 		.dev_id		= "sh_tmu.3",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[16],	/* tmu345_fck */
+		.clk		= &mstp_clks[HWBLK_TMU1],
 	}, {
 		/* TMU4 */
 		.dev_id		= "sh_tmu.4",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[16],
+		.clk		= &mstp_clks[HWBLK_TMU1],
 	}, {
 		/* TMU5 */
 		.dev_id		= "sh_tmu.5",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[16],
+		.clk		= &mstp_clks[HWBLK_TMU1],
 	},
 };
 
