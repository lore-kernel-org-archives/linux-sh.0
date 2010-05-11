From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 07:06:13 +0000
Subject: [PATCH 09/09] sh: get rid of div4 clock name
Message-Id: <20100511070613.20792.88598.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Remove the name parameter from SH_CLK_DIV4() and
adjust the processor specific code. The lookup
happens using clkdev so the name is unused.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/clock.h            |   15 +++++++--------
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |   20 ++++++++++----------
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |   20 ++++++++++----------
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   22 +++++++++++-----------
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |   22 +++++++++++-----------
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   14 +++++++-------
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |   20 ++++++++++----------
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |   16 ++++++++--------
 8 files changed, 74 insertions(+), 75 deletions(-)

--- 0010/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2010-05-11 15:12:47.000000000 +0900
@@ -126,14 +126,13 @@ int clk_rate_table_find(struct clk *clk,
 
 int sh_clk_mstp32_register(struct clk *clks, int nr);
 
-#define SH_CLK_DIV4(_name, _parent, _reg, _shift, _div_bitmap, _flags)	\
-{									\
-	.name = _name,							\
-	.parent = _parent,						\
-	.enable_reg = (void __iomem *)_reg,				\
-	.enable_bit = _shift,						\
-	.arch_flags = _div_bitmap,					\
-	.flags = _flags,						\
+#define SH_CLK_DIV4(_parent, _reg, _shift, _div_bitmap, _flags)	\
+{								\
+	.parent = _parent,					\
+	.enable_reg = (void __iomem *)_reg,			\
+	.enable_bit = _shift,					\
+	.arch_flags = _div_bitmap,				\
+	.flags = _flags,					\
 }
 
 struct clk_div4_table {
--- 0015/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7343.c	2010-05-11 15:28:04.000000000 +0900
@@ -122,18 +122,18 @@ static struct clk_div4_table div4_table 
 enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_B3, DIV4_P,
        DIV4_SIUA, DIV4_SIUB, DIV4_NR };
 
-#define DIV4(_str, _reg, _bit, _mask, _flags) \
-  SH_CLK_DIV4(_str, &pll_clk, _reg, _bit, _mask, _flags)
+#define DIV4(_reg, _bit, _mask, _flags) \
+  SH_CLK_DIV4(&pll_clk, _reg, _bit, _mask, _flags)
 
 struct clk div4_clks[DIV4_NR] = {
-	[DIV4_I] = DIV4("cpu_clk", FRQCR, 20, 0x1fff, CLK_ENABLE_ON_INIT),
-	[DIV4_U] = DIV4("umem_clk", FRQCR, 16, 0x1fff, CLK_ENABLE_ON_INIT),
-	[DIV4_SH] = DIV4("shyway_clk", FRQCR, 12, 0x1fff, CLK_ENABLE_ON_INIT),
-	[DIV4_B] = DIV4("bus_clk", FRQCR, 8, 0x1fff, CLK_ENABLE_ON_INIT),
-	[DIV4_B3] = DIV4("b3_clk", FRQCR, 4, 0x1fff, CLK_ENABLE_ON_INIT),
-	[DIV4_P] = DIV4("peripheral_clk", FRQCR, 0, 0x1fff, 0),
-	[DIV4_SIUA] = DIV4("siua_clk", SCLKACR, 0, 0x1fff, 0),
-	[DIV4_SIUB] = DIV4("siub_clk", SCLKBCR, 0, 0x1fff, 0),
+	[DIV4_I] = DIV4(FRQCR, 20, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_U] = DIV4(FRQCR, 16, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_SH] = DIV4(FRQCR, 12, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4(FRQCR, 8, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B3] = DIV4(FRQCR, 4, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_P] = DIV4(FRQCR, 0, 0x1fff, 0),
+	[DIV4_SIUA] = DIV4(SCLKACR, 0, 0x1fff, 0),
+	[DIV4_SIUB] = DIV4(SCLKBCR, 0, 0x1fff, 0),
 };
 
 enum { DIV6_V, DIV6_NR };
--- 0016/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7366.c	2010-05-11 15:19:39.000000000 +0900
@@ -125,18 +125,18 @@ static struct clk_div4_table div4_table 
 enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_B3, DIV4_P,
        DIV4_SIUA, DIV4_SIUB, DIV4_NR };
 
-#define DIV4(_str, _reg, _bit, _mask, _flags) \
-  SH_CLK_DIV4(_str, &pll_clk, _reg, _bit, _mask, _flags)
+#define DIV4(_reg, _bit, _mask, _flags) \
+  SH_CLK_DIV4(&pll_clk, _reg, _bit, _mask, _flags)
 
 struct clk div4_clks[DIV4_NR] = {
-	[DIV4_I] = DIV4("cpu_clk", FRQCR, 20, 0x1fef, CLK_ENABLE_ON_INIT),
-	[DIV4_U] = DIV4("umem_clk", FRQCR, 16, 0x1fff, CLK_ENABLE_ON_INIT),
-	[DIV4_SH] = DIV4("shyway_clk", FRQCR, 12, 0x1fff, CLK_ENABLE_ON_INIT),
-	[DIV4_B] = DIV4("bus_clk", FRQCR, 8, 0x1fff, CLK_ENABLE_ON_INIT),
-	[DIV4_B3] = DIV4("b3_clk", FRQCR, 4, 0x1fff, CLK_ENABLE_ON_INIT),
-	[DIV4_P] = DIV4("peripheral_clk", FRQCR, 0, 0x1fff, 0),
-	[DIV4_SIUA] = DIV4("siua_clk", SCLKACR, 0, 0x1fff, 0),
-	[DIV4_SIUB] = DIV4("siub_clk", SCLKBCR, 0, 0x1fff, 0),
+	[DIV4_I] = DIV4(FRQCR, 20, 0x1fef, CLK_ENABLE_ON_INIT),
+	[DIV4_U] = DIV4(FRQCR, 16, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_SH] = DIV4(FRQCR, 12, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4(FRQCR, 8, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B3] = DIV4(FRQCR, 4, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_P] = DIV4(FRQCR, 0, 0x1fff, 0),
+	[DIV4_SIUA] = DIV4(SCLKACR, 0, 0x1fff, 0),
+	[DIV4_SIUB] = DIV4(SCLKBCR, 0, 0x1fff, 0),
 };
 
 enum { DIV6_V, DIV6_NR };
--- 0012/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2010-05-11 15:32:45.000000000 +0900
@@ -122,31 +122,31 @@ static struct clk_div4_table div4_table 
 	.div_mult_table = &div4_div_mult_table,
 };
 
-#define DIV4(_str, _reg, _bit, _mask, _flags) \
-  SH_CLK_DIV4(_str, &pll_clk, _reg, _bit, _mask, _flags)
+#define DIV4(_reg, _bit, _mask, _flags) \
+  SH_CLK_DIV4(&pll_clk, _reg, _bit, _mask, _flags)
 
 enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_B3, DIV4_P, DIV4_NR };
 
 struct clk div4_clks[DIV4_NR] = {
-	[DIV4_I] = DIV4("cpu_clk", FRQCR, 20, 0x1fef, CLK_ENABLE_ON_INIT),
-	[DIV4_U] = DIV4("umem_clk", FRQCR, 16, 0x1fff, CLK_ENABLE_ON_INIT),
-	[DIV4_SH] = DIV4("shyway_clk", FRQCR, 12, 0x1fff, CLK_ENABLE_ON_INIT),
-	[DIV4_B] = DIV4("bus_clk", FRQCR, 8, 0x1fff, CLK_ENABLE_ON_INIT),
-	[DIV4_B3] = DIV4("b3_clk", FRQCR, 4, 0x1fff, CLK_ENABLE_ON_INIT),
-	[DIV4_P] = DIV4("peripheral_clk", FRQCR, 0, 0x1fff, 0),
+	[DIV4_I] = DIV4(FRQCR, 20, 0x1fef, CLK_ENABLE_ON_INIT),
+	[DIV4_U] = DIV4(FRQCR, 16, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_SH] = DIV4(FRQCR, 12, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4(FRQCR, 8, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B3] = DIV4(FRQCR, 4, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_P] = DIV4(FRQCR, 0, 0x1fff, 0),
 };
 
 enum { DIV4_IRDA, DIV4_ENABLE_NR };
 
 struct clk div4_enable_clks[DIV4_ENABLE_NR] = {
-	[DIV4_IRDA] = DIV4("irda_clk", IRDACLKCR, 0, 0x1fff, 0),
+	[DIV4_IRDA] = DIV4(IRDACLKCR, 0, 0x1fff, 0),
 };
 
 enum { DIV4_SIUA, DIV4_SIUB, DIV4_REPARENT_NR };
 
 struct clk div4_reparent_clks[DIV4_REPARENT_NR] = {
-	[DIV4_SIUA] = DIV4("siua_clk", SCLKACR, 0, 0x1fff, 0),
-	[DIV4_SIUB] = DIV4("siub_clk", SCLKBCR, 0, 0x1fff, 0),
+	[DIV4_SIUA] = DIV4(SCLKACR, 0, 0x1fff, 0),
+	[DIV4_SIUB] = DIV4(SCLKBCR, 0, 0x1fff, 0),
 };
 
 enum { DIV6_V, DIV6_NR };
--- 0013/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7723.c	2010-05-11 15:34:45.000000000 +0900
@@ -125,29 +125,29 @@ static struct clk_div4_table div4_table 
 
 enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_B3, DIV4_P, DIV4_NR };
 
-#define DIV4(_str, _reg, _bit, _mask, _flags) \
-  SH_CLK_DIV4(_str, &pll_clk, _reg, _bit, _mask, _flags)
+#define DIV4(_reg, _bit, _mask, _flags) \
+  SH_CLK_DIV4(&pll_clk, _reg, _bit, _mask, _flags)
 
 struct clk div4_clks[DIV4_NR] = {
-	[DIV4_I] = DIV4("cpu_clk", FRQCR, 20, 0x0dbf, CLK_ENABLE_ON_INIT),
-	[DIV4_U] = DIV4("umem_clk", FRQCR, 16, 0x0dbf, CLK_ENABLE_ON_INIT),
-	[DIV4_SH] = DIV4("shyway_clk", FRQCR, 12, 0x0dbf, CLK_ENABLE_ON_INIT),
-	[DIV4_B] = DIV4("bus_clk", FRQCR, 8, 0x0dbf, CLK_ENABLE_ON_INIT),
-	[DIV4_B3] = DIV4("b3_clk", FRQCR, 4, 0x0db4, CLK_ENABLE_ON_INIT),
-	[DIV4_P] = DIV4("peripheral_clk", FRQCR, 0, 0x0dbf, 0),
+	[DIV4_I] = DIV4(FRQCR, 20, 0x0dbf, CLK_ENABLE_ON_INIT),
+	[DIV4_U] = DIV4(FRQCR, 16, 0x0dbf, CLK_ENABLE_ON_INIT),
+	[DIV4_SH] = DIV4(FRQCR, 12, 0x0dbf, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4(FRQCR, 8, 0x0dbf, CLK_ENABLE_ON_INIT),
+	[DIV4_B3] = DIV4(FRQCR, 4, 0x0db4, CLK_ENABLE_ON_INIT),
+	[DIV4_P] = DIV4(FRQCR, 0, 0x0dbf, 0),
 };
 
 enum { DIV4_IRDA, DIV4_ENABLE_NR };
 
 struct clk div4_enable_clks[DIV4_ENABLE_NR] = {
-	[DIV4_IRDA] = DIV4("irda_clk", IRDACLKCR, 0, 0x0dbf, 0),
+	[DIV4_IRDA] = DIV4(IRDACLKCR, 0, 0x0dbf, 0),
 };
 
 enum { DIV4_SIUA, DIV4_SIUB, DIV4_REPARENT_NR };
 
 struct clk div4_reparent_clks[DIV4_REPARENT_NR] = {
-	[DIV4_SIUA] = DIV4("siua_clk", SCLKACR, 0, 0x0dbf, 0),
-	[DIV4_SIUB] = DIV4("siub_clk", SCLKBCR, 0, 0x0dbf, 0),
+	[DIV4_SIUA] = DIV4(SCLKACR, 0, 0x0dbf, 0),
+	[DIV4_SIUB] = DIV4(SCLKBCR, 0, 0x0dbf, 0),
 };
 enum { DIV6_V, DIV6_NR };
 
--- 0014/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-11 15:29:51.000000000 +0900
@@ -153,15 +153,15 @@ static struct clk_div4_table div4_table 
 
 enum { DIV4_I, DIV4_SH, DIV4_B, DIV4_P, DIV4_M1, DIV4_NR };
 
-#define DIV4(_str, _reg, _bit, _mask, _flags) \
-  SH_CLK_DIV4(_str, &pll_clk, _reg, _bit, _mask, _flags)
+#define DIV4(_reg, _bit, _mask, _flags) \
+  SH_CLK_DIV4(&pll_clk, _reg, _bit, _mask, _flags)
 
 struct clk div4_clks[DIV4_NR] = {
-	[DIV4_I] = DIV4("cpu_clk", FRQCRA, 20, 0x2f7d, CLK_ENABLE_ON_INIT),
-	[DIV4_SH] = DIV4("shyway_clk", FRQCRA, 12, 0x2f7c, CLK_ENABLE_ON_INIT),
-	[DIV4_B] = DIV4("bus_clk", FRQCRA, 8, 0x2f7c, CLK_ENABLE_ON_INIT),
-	[DIV4_P] = DIV4("peripheral_clk", FRQCRA, 0, 0x2f7c, 0),
-	[DIV4_M1] = DIV4("vpu_clk", FRQCRB, 4, 0x2f7c, CLK_ENABLE_ON_INIT),
+	[DIV4_I] = DIV4(FRQCRA, 20, 0x2f7d, CLK_ENABLE_ON_INIT),
+	[DIV4_SH] = DIV4(FRQCRA, 12, 0x2f7c, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4(FRQCRA, 8, 0x2f7c, CLK_ENABLE_ON_INIT),
+	[DIV4_P] = DIV4(FRQCRA, 0, 0x2f7c, 0),
+	[DIV4_M1] = DIV4(FRQCRB, 4, 0x2f7c, CLK_ENABLE_ON_INIT),
 };
 
 enum { DIV6_V, DIV6_FA, DIV6_FB, DIV6_I, DIV6_S, DIV6_NR };
--- 0017/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2010-05-11 15:17:19.000000000 +0900
@@ -70,18 +70,18 @@ static struct clk_div4_table div4_table 
 enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_DDR, DIV4_GA,
 	DIV4_DU, DIV4_P, DIV4_NR };
 
-#define DIV4(_str, _bit, _mask, _flags) \
-  SH_CLK_DIV4(_str, &pll_clk, FRQMR1, _bit, _mask, _flags)
+#define DIV4(_bit, _mask, _flags) \
+  SH_CLK_DIV4(&pll_clk, FRQMR1, _bit, _mask, _flags)
 
 struct clk div4_clks[DIV4_NR] = {
-	[DIV4_P] = DIV4("peripheral_clk", 0, 0x0f80, 0),
-	[DIV4_DU] = DIV4("du_clk", 4, 0x0ff0, 0),
-	[DIV4_GA] = DIV4("ga_clk", 8, 0x0030, 0),
-	[DIV4_DDR] = DIV4("ddr_clk", 12, 0x000c, CLK_ENABLE_ON_INIT),
-	[DIV4_B] = DIV4("bus_clk", 16, 0x0fe0, CLK_ENABLE_ON_INIT),
-	[DIV4_SH] = DIV4("shyway_clk", 20, 0x000c, CLK_ENABLE_ON_INIT),
-	[DIV4_U] = DIV4("umem_clk", 24, 0x000c, CLK_ENABLE_ON_INIT),
-	[DIV4_I] = DIV4("cpu_clk", 28, 0x000e, CLK_ENABLE_ON_INIT),
+	[DIV4_P] = DIV4(0, 0x0f80, 0),
+	[DIV4_DU] = DIV4(4, 0x0ff0, 0),
+	[DIV4_GA] = DIV4(8, 0x0030, 0),
+	[DIV4_DDR] = DIV4(12, 0x000c, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4(16, 0x0fe0, CLK_ENABLE_ON_INIT),
+	[DIV4_SH] = DIV4(20, 0x000c, CLK_ENABLE_ON_INIT),
+	[DIV4_U] = DIV4(24, 0x000c, CLK_ENABLE_ON_INIT),
+	[DIV4_I] = DIV4(28, 0x000e, CLK_ENABLE_ON_INIT),
 };
 
 #define MSTPCR0		0xffc80030
--- 0018/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7786.c	2010-05-11 15:16:15.000000000 +0900
@@ -72,16 +72,16 @@ static struct clk_div4_table div4_table 
 
 enum { DIV4_I, DIV4_SH, DIV4_B, DIV4_DDR, DIV4_DU, DIV4_P, DIV4_NR };
 
-#define DIV4(_str, _bit, _mask, _flags) \
-  SH_CLK_DIV4(_str, &pll_clk, FRQMR1, _bit, _mask, _flags)
+#define DIV4(_bit, _mask, _flags) \
+  SH_CLK_DIV4(&pll_clk, FRQMR1, _bit, _mask, _flags)
 
 struct clk div4_clks[DIV4_NR] = {
-	[DIV4_P] = DIV4("peripheral_clk", 0, 0x0b40, 0),
-	[DIV4_DU] = DIV4("du_clk", 4, 0x0010, 0),
-	[DIV4_DDR] = DIV4("ddr_clk", 12, 0x0002, CLK_ENABLE_ON_INIT),
-	[DIV4_B] = DIV4("bus_clk", 16, 0x0360, CLK_ENABLE_ON_INIT),
-	[DIV4_SH] = DIV4("shyway_clk", 20, 0x0002, CLK_ENABLE_ON_INIT),
-	[DIV4_I] = DIV4("cpu_clk", 28, 0x0006, CLK_ENABLE_ON_INIT),
+	[DIV4_P] = DIV4(0, 0x0b40, 0),
+	[DIV4_DU] = DIV4(4, 0x0010, 0),
+	[DIV4_DDR] = DIV4(12, 0x0002, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4(16, 0x0360, CLK_ENABLE_ON_INIT),
+	[DIV4_SH] = DIV4(20, 0x0002, CLK_ENABLE_ON_INIT),
+	[DIV4_I] = DIV4(28, 0x0006, CLK_ENABLE_ON_INIT),
 };
 
 #define MSTPCR0		0xffc40030
