From: Dirk Behme <dirk.behme@gmail.com>
Date: Fri, 04 Dec 2015 13:54:44 +0000
Subject: [PATCH] clk: shmobile: r8a7795: Add SDHI clocks
Message-Id: <1449237284-4744-1-git-send-email-dirk.behme@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add R8A7795 SDHI clocks.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
---
Note: This patch is based on

https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/gen3-latest renesas-drivers-2015-12-01-v4.4-rc3

 drivers/clk/shmobile/r8a7795-cpg-mssr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
index 05479e6..b8831bd 100644
--- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
+++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
@@ -99,6 +99,10 @@ static const struct cpg_core_clk r8a7795_core_clks[] __initconst = {
 	DEF_FIXED("s3d1",       R8A7795_CLK_S3D1,  CLK_S3,         1, 1),
 	DEF_FIXED("s3d2",       R8A7795_CLK_S3D2,  CLK_S3,         2, 1),
 	DEF_FIXED("s3d4",       R8A7795_CLK_S3D4,  CLK_S3,         4, 1),
+	DEF_FIXED("sd0",        R8A7795_CLK_SD0,   CLK_PLL1_DIV2, 16, 1),
+	DEF_FIXED("sd1",        R8A7795_CLK_SD1,   CLK_PLL1_DIV2, 16, 1),
+	DEF_FIXED("sd2",        R8A7795_CLK_SD2,   CLK_PLL1_DIV2, 16, 1),
+	DEF_FIXED("sd3",        R8A7795_CLK_SD3,   CLK_PLL1_DIV2, 16, 1),
 	DEF_FIXED("cl",         R8A7795_CLK_CL,    CLK_PLL1_DIV2, 48, 1),
 	DEF_FIXED("cp",         R8A7795_CLK_CP,    CLK_EXTAL,      2, 1),
 
@@ -120,6 +124,10 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	DEF_MOD("sys-dmac1",		 218,	R8A7795_CLK_S3D1),
 	DEF_MOD("sys-dmac0",		 219,	R8A7795_CLK_S3D1),
 	DEF_MOD("scif2",		 310,	R8A7795_CLK_S3D4),
+	DEF_MOD("sdhi3",	       	 311,	R8A7795_CLK_SD3),
+	DEF_MOD("sdhi2",	       	 312,	R8A7795_CLK_SD2),
+	DEF_MOD("sdhi1",	      	 313,	R8A7795_CLK_SD1),
+	DEF_MOD("sdhi0",	     	 314,	R8A7795_CLK_SD0),
 	DEF_MOD("pcie1",		 318,	R8A7795_CLK_S3D1),
 	DEF_MOD("pcie0",		 319,	R8A7795_CLK_S3D1),
 	DEF_MOD("intc-ap",		 408,	R8A7795_CLK_S3D1),
-- 
2.6.3

