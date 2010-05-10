From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 11:24:20 +0000
Subject: [PATCH 08/13] sh: Get rid of sh7724 div6 clock names
Message-Id: <20100510112420.14587.34514.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Get rid of the name from the sh7724 div6 clocks.
The div6 clocks for all processors must be updated
before this can be applied.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/clock.h            |    3 +--
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   13 +++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

--- 0001/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2010-05-10 19:18:09.000000000 +0900
@@ -151,9 +151,8 @@ int sh_clk_div4_enable_register(struct c
 int sh_clk_div4_reparent_register(struct clk *clks, int nr,
 			 struct clk_div4_table *table);
 
-#define SH_CLK_DIV6(_name, _parent, _reg, _flags)	\
+#define SH_CLK_DIV6(_parent, _reg, _flags)		\
 {							\
-	.name = _name,					\
 	.parent = _parent,				\
 	.enable_reg = (void __iomem *)_reg,		\
 	.flags = _flags,				\
--- 0008/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 19:18:54.000000000 +0900
@@ -166,15 +166,12 @@ struct clk div4_clks[DIV4_NR] = {
 
 enum { DIV6_V, DIV6_FA, DIV6_FB, DIV6_I, DIV6_S, DIV6_NR };
 
-#define DIV6(_str, _reg, _flags) \
-  SH_CLK_DIV6(_str, &div3_clk, _reg, _flags)
-
 struct clk div6_clks[DIV6_NR] = {
-	[DIV6_V] = DIV6("video_clk", VCLKCR, 0),
-	[DIV6_FA] = DIV6("fsia_clk", FCLKACR, 0),
-	[DIV6_FB] = DIV6("fsib_clk", FCLKBCR, 0),
-	[DIV6_I] = DIV6("irda_clk", IRDACLKCR, 0),
-	[DIV6_S] = DIV6("spu_clk", SPUCLKCR, CLK_ENABLE_ON_INIT),
+	[DIV6_V] = SH_CLK_DIV6(&div3_clk, VCLKCR, 0),
+	[DIV6_FA] = SH_CLK_DIV6(&div3_clk, FCLKACR, 0),
+	[DIV6_FB] = SH_CLK_DIV6(&div3_clk, FCLKBCR, 0),
+	[DIV6_I] = SH_CLK_DIV6(&div3_clk, IRDACLKCR, 0),
+	[DIV6_S] = SH_CLK_DIV6(&div3_clk, SPUCLKCR, CLK_ENABLE_ON_INIT),
 };
 
 #define R_CLK (&r_clk)
