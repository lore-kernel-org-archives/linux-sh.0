From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 14:01:55 +0000
Subject: [PATCH 06/07] sh: tie in div6 clocks using clkdev
Message-Id: <20100510140155.32745.37435.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Use clkdev for div6 lookup on SH-Mobile processors:
sh7343/sh7366/sh7722/sh7723/sh7724

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |   18 +++++++++++++++---
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |   18 +++++++++++++++---
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   11 ++++++++---
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |   11 ++++++++---
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   26 +++++++++++++++++++-------
 5 files changed, 65 insertions(+), 19 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7343.c	2010-05-10 22:20:09.000000000 +0900
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
+#include <asm/clkdev.h>
 #include <asm/clock.h>
 
 /* SH7343 registers */
@@ -135,8 +136,10 @@ struct clk div4_clks[DIV4_NR] = {
 	[DIV4_SIUB] = DIV4("siub_clk", SCLKBCR, 0, 0x1fff, 0),
 };
 
-struct clk div6_clks[] = {
-	SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
+enum { DIV6_V, DIV6_NR };
+
+struct clk div6_clks[DIV6_NR] = {
+	[DIV6_V] = SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
 };
 
 #define MSTP(_str, _parent, _reg, _bit, _flags) \
@@ -189,6 +192,13 @@ static struct clk mstp_clks[] = {
 	MSTP("lcdc0", &div4_clks[DIV4_B], MSTPCR2, 0, 0),
 };
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
+static struct clk_lookup lookups[] = {
+	/* DIV6 clocks */
+	CLKDEV_CON_ID("video_clk", &div6_clks[DIV6_V]),
+};
+
 int __init arch_clk_init(void)
 {
 	int k, ret = 0;
@@ -202,11 +212,13 @@ int __init arch_clk_init(void)
 	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
 		ret = clk_register(main_clks[k]);
 
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
 	if (!ret)
 		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
 
 	if (!ret)
-		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
+		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
 		ret = sh_clk_mstp32_register(mstp_clks, ARRAY_SIZE(mstp_clks));
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7366.c	2010-05-10 22:20:26.000000000 +0900
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
+#include <asm/clkdev.h>
 #include <asm/clock.h>
 
 /* SH7366 registers */
@@ -138,8 +139,10 @@ struct clk div4_clks[DIV4_NR] = {
 	[DIV4_SIUB] = DIV4("siub_clk", SCLKBCR, 0, 0x1fff, 0),
 };
 
-struct clk div6_clks[] = {
-	SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
+enum { DIV6_V, DIV6_NR };
+
+struct clk div6_clks[DIV6_NR] = {
+	[DIV6_V] = SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
 };
 
 #define MSTP(_str, _parent, _reg, _bit, _flags) \
@@ -189,6 +192,13 @@ static struct clk mstp_clks[] = {
 	MSTP("lcdc0", &div4_clks[DIV4_B], MSTPCR2, 0, 0),
 };
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
+static struct clk_lookup lookups[] = {
+	/* DIV6 clocks */
+	CLKDEV_CON_ID("video_clk", &div6_clks[DIV6_V]),
+};
+
 int __init arch_clk_init(void)
 {
 	int k, ret = 0;
@@ -202,11 +212,13 @@ int __init arch_clk_init(void)
 	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
 		ret = clk_register(main_clks[k]);
 
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
 	if (!ret)
 		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
 
 	if (!ret)
-		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
+		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
 		ret = sh_clk_mstp32_register(mstp_clks, ARRAY_SIZE(mstp_clks));
--- 0006/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2010-05-10 22:18:58.000000000 +0900
@@ -149,8 +149,10 @@ struct clk div4_reparent_clks[DIV4_REPAR
 	[DIV4_SIUB] = DIV4("siub_clk", SCLKBCR, 0, 0x1fff, 0),
 };
 
-struct clk div6_clks[] = {
-	SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
+enum { DIV6_V, DIV6_NR };
+
+struct clk div6_clks[DIV6_NR] = {
+	[DIV6_V] = SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
 };
 
 static struct clk mstp_clks[HWBLK_NR] = {
@@ -184,6 +186,9 @@ static struct clk mstp_clks[HWBLK_NR] = 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
+	/* DIV6 clocks */
+	CLKDEV_CON_ID("video_clk", &div6_clks[DIV6_V]),
+
 	/* MSTP clocks */
 	CLKDEV_CON_ID("uram0", &mstp_clks[HWBLK_URAM]),
 	CLKDEV_CON_ID("xymem0", &mstp_clks[HWBLK_XYMEM]),
@@ -265,7 +270,7 @@ int __init arch_clk_init(void)
 					DIV4_REPARENT_NR, &div4_table);
 
 	if (!ret)
-		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
+		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
 		ret = sh_hwblk_clk_register(mstp_clks, HWBLK_NR);
--- 0006/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7723.c	2010-05-10 22:16:14.000000000 +0900
@@ -149,8 +149,10 @@ struct clk div4_reparent_clks[DIV4_REPAR
 	[DIV4_SIUA] = DIV4("siua_clk", SCLKACR, 0, 0x0dbf, 0),
 	[DIV4_SIUB] = DIV4("siub_clk", SCLKBCR, 0, 0x0dbf, 0),
 };
-struct clk div6_clks[] = {
-	SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
+enum { DIV6_V, DIV6_NR };
+
+struct clk div6_clks[DIV6_NR] = {
+	[DIV6_V] = SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
 };
 
 static struct clk mstp_clks[] = {
@@ -209,6 +211,9 @@ static struct clk mstp_clks[] = {
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
+	/* DIV6 clocks */
+	CLKDEV_CON_ID("video_clk", &div6_clks[DIV6_V]),
+
 	/* MSTP clocks */
 	CLKDEV_CON_ID("tlb0", &mstp_clks[HWBLK_TLB]),
 	CLKDEV_CON_ID("ic0", &mstp_clks[HWBLK_IC]),
@@ -341,7 +346,7 @@ int __init arch_clk_init(void)
 					DIV4_REPARENT_NR, &div4_table);
 
 	if (!ret)
-		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
+		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
 		ret = sh_hwblk_clk_register(mstp_clks, HWBLK_NR);
--- 0006/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 22:14:51.000000000 +0900
@@ -164,12 +164,17 @@ struct clk div4_clks[DIV4_NR] = {
 	[DIV4_M1] = DIV4("vpu_clk", FRQCRB, 4, 0x2f7c, CLK_ENABLE_ON_INIT),
 };
 
-struct clk div6_clks[] = {
-	SH_CLK_DIV6("video_clk", &div3_clk, VCLKCR, 0),
-	SH_CLK_DIV6("fsia_clk", &div3_clk, FCLKACR, 0),
-	SH_CLK_DIV6("fsib_clk", &div3_clk, FCLKBCR, 0),
-	SH_CLK_DIV6("irda_clk", &div3_clk, IRDACLKCR, 0),
-	SH_CLK_DIV6("spu_clk", &div3_clk, SPUCLKCR, CLK_ENABLE_ON_INIT),
+enum { DIV6_V, DIV6_FA, DIV6_FB, DIV6_I, DIV6_S, DIV6_NR };
+
+#define DIV6(_str, _reg, _flags) \
+  SH_CLK_DIV6(_str, &div3_clk, _reg, _flags)
+
+struct clk div6_clks[DIV6_NR] = {
+	[DIV6_V] = DIV6("video_clk", VCLKCR, 0),
+	[DIV6_FA] = DIV6("fsia_clk", FCLKACR, 0),
+	[DIV6_FB] = DIV6("fsib_clk", FCLKBCR, 0),
+	[DIV6_I] = DIV6("irda_clk", IRDACLKCR, 0),
+	[DIV6_S] = DIV6("spu_clk", SPUCLKCR, CLK_ENABLE_ON_INIT),
 };
 
 static struct clk mstp_clks[HWBLK_NR] = {
@@ -232,6 +237,13 @@ static struct clk mstp_clks[HWBLK_NR] = 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
+	/* DIV6 clocks */
+	CLKDEV_CON_ID("video_clk", &div6_clks[DIV6_V]),
+	CLKDEV_CON_ID("fsia_clk", &div6_clks[DIV6_FA]),
+	CLKDEV_CON_ID("fsib_clk", &div6_clks[DIV6_FB]),
+	CLKDEV_CON_ID("irda_clk", &div6_clks[DIV6_I]),
+	CLKDEV_CON_ID("spu_clk", &div6_clks[DIV6_S]),
+
 	/* MSTP clocks */
 	CLKDEV_CON_ID("tlb0", &mstp_clks[HWBLK_TLB]),
 	CLKDEV_CON_ID("ic0", &mstp_clks[HWBLK_IC]),
@@ -360,7 +372,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
 
 	if (!ret)
-		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
+		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
 		ret = sh_hwblk_clk_register(mstp_clks, HWBLK_NR);
