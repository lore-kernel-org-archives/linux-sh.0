From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 05 Dec 2011 06:26:09 +0000
Subject: [PATCH 2/4] sh: modify SH_CLK_DIV6_EXT macro parameter
Message-Id: <874nxf8rgh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

array size which can be calculated from specific table was removed,
and the "flags" which can use CLK_ENABLE_ON_INIT became last parameter.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7372.c  |    9 +++------
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    6 ++----
 include/linux/sh_clk.h                 |    5 ++---
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index e349c22..bb7fe48 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -411,12 +411,9 @@ static struct clk *fsibckcr_parent[] = {
 };
 
 static struct clk div6_reparent_clks[DIV6_REPARENT_NR] = {
-	[DIV6_HDMI] = SH_CLK_DIV6_EXT(HDMICKCR, 0,
-				      hdmi_parent, ARRAY_SIZE(hdmi_parent), 6, 2),
-	[DIV6_FSIA] = SH_CLK_DIV6_EXT(FSIACKCR, 0,
-				      fsiackcr_parent, ARRAY_SIZE(fsiackcr_parent), 6, 2),
-	[DIV6_FSIB] = SH_CLK_DIV6_EXT(FSIBCKCR, 0,
-				      fsibckcr_parent, ARRAY_SIZE(fsibckcr_parent), 6, 2),
+	[DIV6_HDMI] = SH_CLK_DIV6_EXT(HDMICKCR, hdmi_parent, 6, 2, 0),
+	[DIV6_FSIA] = SH_CLK_DIV6_EXT(FSIACKCR, fsiackcr_parent, 6, 2, 0),
+	[DIV6_FSIB] = SH_CLK_DIV6_EXT(FSIBCKCR, fsibckcr_parent, 6, 2, 0),
 };
 
 /* FSI DIV */
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index 7711838..4957ca4 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -189,10 +189,8 @@ static struct clk *fclkbcr_parent[] = {
 };
 
 static struct clk div6_reparent_clks[DIV6_REPARENT_NR] = {
-	[DIV6_FA] = SH_CLK_DIV6_EXT(FCLKACR, 0,
-				      fclkacr_parent, ARRAY_SIZE(fclkacr_parent), 6, 2),
-	[DIV6_FB] = SH_CLK_DIV6_EXT(FCLKBCR, 0,
-				      fclkbcr_parent, ARRAY_SIZE(fclkbcr_parent), 6, 2),
+	[DIV6_FA] = SH_CLK_DIV6_EXT(FCLKACR, fclkacr_parent, 6, 2, 0),
+	[DIV6_FB] = SH_CLK_DIV6_EXT(FCLKBCR, fclkbcr_parent, 6, 2, 0),
 };
 
 static struct clk mstp_clks[HWBLK_NR] = {
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index e834304..4d65540 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -131,13 +131,12 @@ int sh_clk_div4_enable_register(struct clk *clks, int nr,
 int sh_clk_div4_reparent_register(struct clk *clks, int nr,
 			 struct clk_div4_table *table);
 
-#define SH_CLK_DIV6_EXT(_reg, _flags, _parents,			\
-			_num_parents, _src_shift, _src_width)	\
+#define SH_CLK_DIV6_EXT(_reg, _parents, _src_shift, _src_width, _flags)\
 {								\
 	.enable_reg = (void __iomem *)_reg,			\
 	.flags = _flags,					\
 	.parent_table = _parents,				\
-	.parent_num = _num_parents,				\
+	.parent_num = ARRAY_SIZE(_parents),			\
 	.src_shift = _src_shift,				\
 	.src_width = _src_width,				\
 }
-- 
1.7.5.4

