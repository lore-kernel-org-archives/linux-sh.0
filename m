From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Jul 2011 02:54:11 +0000
Subject: [PATCH] sh: move CLKDEV_xxx_ID macro to sh_clk.h
Message-Id: <87fwmkjezz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
I compiled this patch on SH7724, SH7372. SH73a0.
I hope it works on other chip

 arch/arm/mach-shmobile/clock-sh7367.c  |    3 ---
 arch/arm/mach-shmobile/clock-sh7372.c  |    4 ----
 arch/arm/mach-shmobile/clock-sh7377.c  |    3 ---
 arch/arm/mach-shmobile/clock-sh73a0.c  |    4 ----
 arch/sh/boards/mach-highlander/setup.c |    2 --
 arch/sh/kernel/cpu/clock-cpg.c         |    2 --
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c |    2 --
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |    4 ----
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |    4 ----
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    4 ----
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |    3 ---
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    4 ----
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |    3 ---
 arch/sh/kernel/cpu/sh4a/clock-sh7763.c |    2 --
 arch/sh/kernel/cpu/sh4a/clock-sh7780.c |    2 --
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    3 ---
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |    3 ---
 arch/sh/kernel/cpu/sh4a/clock-shx3.c   |    3 ---
 include/linux/sh_clk.h                 |    4 ++++
 19 files changed, 4 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7367.c b/arch/arm/mach-shmobile/clock-sh7367.c
index 6b186ae..5218c34 100644
--- a/arch/arm/mach-shmobile/clock-sh7367.c
+++ b/arch/arm/mach-shmobile/clock-sh7367.c
@@ -259,9 +259,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[CMMSTP003] = MSTP(&r_clk, CMMSTPCR0, 3, 0), /* KEYSC */
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("r_clk", &r_clk),
diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index c0800d8..a06f78d 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -561,10 +561,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
-#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("dv_clki_div2_clk", &sh7372_dv_clki_div2_clk),
diff --git a/arch/arm/mach-shmobile/clock-sh7377.c b/arch/arm/mach-shmobile/clock-sh7377.c
index 9594246..8cee7b1 100644
--- a/arch/arm/mach-shmobile/clock-sh7377.c
+++ b/arch/arm/mach-shmobile/clock-sh7377.c
@@ -267,9 +267,6 @@ static struct clk mstp_clks[] = {
 	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("r_clk", &r_clk),
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index bcacb1e..6db2cca 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -306,10 +306,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
-#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("r_clk", &r_clk),
diff --git a/arch/sh/boards/mach-highlander/setup.c b/arch/sh/boards/mach-highlander/setup.c
index 87618c9..74b8db1 100644
--- a/arch/sh/boards/mach-highlander/setup.c
+++ b/arch/sh/boards/mach-highlander/setup.c
@@ -335,8 +335,6 @@ static struct clk *r7780rp_clocks[] = {
 	&ivdr_clk,
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("ivdr_clk", &ivdr_clk),
diff --git a/arch/sh/kernel/cpu/clock-cpg.c b/arch/sh/kernel/cpu/clock-cpg.c
index 8f63a26..f59b1f3 100644
--- a/arch/sh/kernel/cpu/clock-cpg.c
+++ b/arch/sh/kernel/cpu/clock-cpg.c
@@ -35,8 +35,6 @@ static struct clk *onchip_clocks[] = {
 	&cpu_clk,
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("master_clk", &master_clk),
diff --git a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
index 3f6f8e9..f4e262a 100644
--- a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
@@ -147,8 +147,6 @@ static struct clk *sh4202_onchip_clocks[] = {
 	&sh4202_shoc_clk,
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("emi_clk", &sh4202_emi_clk),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
index 16e151f..70e45bd 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
@@ -194,10 +194,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP200] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 0, 0),
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
-#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("rclk", &r_clk),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
index 092abfe..3c31650 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
@@ -192,10 +192,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP200] = MSTP(&div4_clks[DIV4_B], MSTPCR2, 0, 0),
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
-#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("rclk", &r_clk),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
index d39fcfb..c9a4808 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -175,10 +175,6 @@ static struct clk mstp_clks[HWBLK_NR] = {
 	SH_HWBLK_CLK(HWBLK_LCDC, &div4_clks[DIV4_P], 0),
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
-#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("rclk", &r_clk),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
index 7f70899..3cc3827 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
@@ -200,9 +200,6 @@ static struct clk mstp_clks[] = {
 	SH_HWBLK_CLK(HWBLK_LCDC, &div4_clks[DIV4_B], 0),
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("rclk", &r_clk),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index 0891876..8668f55 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -252,10 +252,6 @@ static struct clk mstp_clks[HWBLK_NR] = {
 	SH_HWBLK_CLK(HWBLK_LCDC, &div4_clks[DIV4_B], 0),
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
-#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("rclk", &r_clk),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index 86bf188..3b097b0 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -101,9 +101,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP220] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR2, 20, 0),
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("extal", &extal_clk),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7763.c b/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
index 599630f..2d4c7fd 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
@@ -91,8 +91,6 @@ static struct clk *sh7763_onchip_clocks[] = {
 	&sh7763_shyway_clk,
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("shyway_clk", &sh7763_shyway_clk),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7780.c b/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
index 8894926..3b53348 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
@@ -97,8 +97,6 @@ static struct clk *sh7780_onchip_clocks[] = {
 	&sh7780_shyway_clk,
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("shyway_clk", &sh7780_shyway_clk),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
index 16ad25c..e5b420c 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
@@ -116,9 +116,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP100] = SH_CLK_MSTP32(NULL, MSTPCR1, 0, 0),
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("extal", &extal_clk),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
index 5a5d209..f6c0c3d 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
@@ -125,9 +125,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP102] = SH_CLK_MSTP32(NULL, MSTPCR1, 2, 0),
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("extal", &extal_clk),
diff --git a/arch/sh/kernel/cpu/sh4a/clock-shx3.c b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
index a9ba4f1..bf2d00b 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
@@ -100,9 +100,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP104] = SH_CLK_MSTP32(NULL, MSTPCR1, 4, 0),
 };
 
-#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
-#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
-
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("extal", &extal_clk),
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 9a52f72..3ccf186 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -147,4 +147,8 @@ int sh_clk_div4_reparent_register(struct clk *clks, int nr,
 int sh_clk_div6_register(struct clk *clks, int nr);
 int sh_clk_div6_reparent_register(struct clk *clks, int nr);
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+#define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
+#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
+
 #endif /* __SH_CLOCK_H */
-- 
1.7.4.1

