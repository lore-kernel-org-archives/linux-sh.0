From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 11:24:35 +0000
Subject: [PATCH 10/13] sh: Get rid of sh7724 div4 clock names
Message-Id: <20100510112435.14587.26182.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Get rid of name from common code and sh7724 div4 clocks.
Obviously all div4 clocks need to be updated first.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/clock.h            |   15 +++++++--------
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   14 +++++++-------
 2 files changed, 14 insertions(+), 15 deletions(-)

--- 0009/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2010-05-10 19:26:02.000000000 +0900
@@ -129,14 +129,13 @@ int clk_rate_table_find(struct clk *clk,
 
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
--- 0010/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 19:25:30.000000000 +0900
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
