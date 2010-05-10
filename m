From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 13:59:54 +0000
Subject: [PATCH 01/07] sh: hwblk index rework
Message-Id: <20100510140102.32745.2948.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Rework the sh7722/sh7723/sh7724 hwblk code to use the
hwblk id as index in the mstp clock array.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/hwblk.h            |    2 +-
 arch/sh/kernel/cpu/hwblk.c             |    5 +++++
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    4 ++--
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |   14 +++++++-------
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   16 ++++++++--------
 5 files changed, 23 insertions(+), 18 deletions(-)

--- 0001/arch/sh/include/asm/hwblk.h
+++ work/arch/sh/include/asm/hwblk.h	2010-05-10 20:53:57.000000000 +0900
@@ -59,7 +59,7 @@ void hwblk_cnt_dec(struct hwblk_info *in
 
 /* allow clocks to enable and disable hardware blocks */
 #define SH_HWBLK_CLK(_name, _id, _parent, _hwblk, _flags)	\
-{							\
+[_hwblk] = {							\
 	.name		= _name,			\
 	.id		= _id,				\
 	.parent		= _parent,			\
--- 0001/arch/sh/kernel/cpu/hwblk.c
+++ work/arch/sh/kernel/cpu/hwblk.c	2010-05-10 20:52:49.000000000 +0900
@@ -146,6 +146,11 @@ int __init sh_hwblk_clk_register(struct 
 
 	for (k = 0; !ret && (k < nr); k++) {
 		clkp = clks + k;
+
+		/* skip over clocks using hwblk 0 (HWBLK_UNKNOWN) */
+		if (!clkp->arch_flags)
+			continue;
+
 		clkp->ops = &sh_hwblk_clk_ops;
 		ret |= clk_register(clkp);
 	}
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2010-05-10 20:56:13.000000000 +0900
@@ -157,7 +157,7 @@ struct clk div6_clks[] = {
 #define B_CLK &div4_clks[DIV4_B]
 #define U_CLK &div4_clks[DIV4_U]
 
-static struct clk mstp_clks[] = {
+static struct clk mstp_clks[HWBLK_NR] = {
 	SH_HWBLK_CLK("uram0", -1, U_CLK, HWBLK_URAM, CLK_ENABLE_ON_INIT),
 	SH_HWBLK_CLK("xymem0", -1, B_CLK, HWBLK_XYMEM, CLK_ENABLE_ON_INIT),
 	SH_HWBLK_CLK("tmu_fck", -1, P_CLK, HWBLK_TMU, 0),
@@ -213,7 +213,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
 
 	if (!ret)
-		ret = sh_hwblk_clk_register(mstp_clks, ARRAY_SIZE(mstp_clks));
+		ret = sh_hwblk_clk_register(mstp_clks, HWBLK_NR);
 
 	return ret;
 }
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7723.c	2010-05-10 20:58:42.000000000 +0900
@@ -218,32 +218,32 @@ static struct clk_lookup lookups[] = {
 		/* TMU0 */
 		.dev_id		= "sh_tmu.0",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[11],	/* tmu012_fck */
+		.clk		= &mstp_clks[HWBLK_TMU0],
 	}, {
 		/* TMU1 */
 		.dev_id		= "sh_tmu.1",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[11],
+		.clk		= &mstp_clks[HWBLK_TMU0],
 	}, {
 		/* TMU2 */
 		.dev_id		= "sh_tmu.2",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[11],
+		.clk		= &mstp_clks[HWBLK_TMU0],
 	}, {
 		/* TMU3 */
 		.dev_id		= "sh_tmu.3",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[15],	/* tmu345_fck */
+		.clk		= &mstp_clks[HWBLK_TMU1],
 	}, {
 		/* TMU4 */
 		.dev_id		= "sh_tmu.4",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[15],
+		.clk		= &mstp_clks[HWBLK_TMU1],
 	}, {
 		/* TMU5 */
 		.dev_id		= "sh_tmu.5",
 		.con_id		= "tmu_fck",
-		.clk		= &mstp_clks[15],
+		.clk		= &mstp_clks[HWBLK_TMU1],
 	},
 };
 
@@ -277,7 +277,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
 
 	if (!ret)
-		ret = sh_hwblk_clk_register(mstp_clks, ARRAY_SIZE(mstp_clks));
+		ret = sh_hwblk_clk_register(mstp_clks, HWBLK_NR);
 
 	return ret;
 }
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 20:55:10.000000000 +0900
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
 
@@ -291,7 +291,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
 
 	if (!ret)
-		ret = sh_hwblk_clk_register(mstp_clks, ARRAY_SIZE(mstp_clks));
+		ret = sh_hwblk_clk_register(mstp_clks, HWBLK_NR);
 
 	return ret;
 }
