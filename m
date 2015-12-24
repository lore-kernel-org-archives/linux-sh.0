From: Dirk Behme <dirk.behme@gmail.com>
Date: Thu, 24 Dec 2015 10:09:21 +0000
Subject: [PATCH v2] clk: shmobile: r8a7795: Add SDHI clocks
Message-Id: <1450951761-3160-1-git-send-email-dirk.behme@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add R8A7795 SDHI clocks.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
---
Changes in v2: Add the missing *H clocks and correct the dividers.

This replaces v1

http://www.spinics.net/lists/linux-sh/msg47464.html

 drivers/clk/shmobile/r8a7795-cpg-mssr.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
index 05479e6..f30ed32 100644
--- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
+++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
@@ -100,8 +100,15 @@ static const struct cpg_core_clk r8a7795_core_clks[] __initconst = {
 	DEF_FIXED("s3d2",       R8A7795_CLK_S3D2,  CLK_S3,         2, 1),
 	DEF_FIXED("s3d4",       R8A7795_CLK_S3D4,  CLK_S3,         4, 1),
 	DEF_FIXED("cl",         R8A7795_CLK_CL,    CLK_PLL1_DIV2, 48, 1),
+	DEF_FIXED("sd0h",       R8A7795_CLK_SD0H,  CLK_PLL1_DIV2,  2, 1),
+	DEF_FIXED("sd0",        R8A7795_CLK_SD0,   CLK_PLL1_DIV2,  8, 1),
+	DEF_FIXED("sd1h",       R8A7795_CLK_SD1H,  CLK_PLL1_DIV2,  2, 1),
+	DEF_FIXED("sd1",        R8A7795_CLK_SD1,   CLK_PLL1_DIV2,  8, 1),
+	DEF_FIXED("sd2h",       R8A7795_CLK_SD2H,  CLK_PLL1_DIV2,  2, 1),
+	DEF_FIXED("sd2",        R8A7795_CLK_SD2,   CLK_PLL1_DIV2,  8, 1),
+	DEF_FIXED("sd3h",       R8A7795_CLK_SD3H,  CLK_PLL1_DIV2,  2, 1),
+	DEF_FIXED("sd3",        R8A7795_CLK_SD3,   CLK_PLL1_DIV2,  8, 1),
 	DEF_FIXED("cp",         R8A7795_CLK_CP,    CLK_EXTAL,      2, 1),
-
 	DEF_DIV6P1("mso",       R8A7795_CLK_MSO,   CLK_PLL1_DIV4, 0x014),
 	DEF_DIV6P1("hdmi",      R8A7795_CLK_HDMI,  CLK_PLL1_DIV2, 0x250),
 };
@@ -120,6 +127,10 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	DEF_MOD("sys-dmac1",		 218,	R8A7795_CLK_S3D1),
 	DEF_MOD("sys-dmac0",		 219,	R8A7795_CLK_S3D1),
 	DEF_MOD("scif2",		 310,	R8A7795_CLK_S3D4),
+	DEF_MOD("sdif3",	       	 311,	R8A7795_CLK_SD3),
+	DEF_MOD("sdif2",	       	 312,	R8A7795_CLK_SD2),
+	DEF_MOD("sdif1",	      	 313,	R8A7795_CLK_SD1),
+	DEF_MOD("sdif0",	     	 314,	R8A7795_CLK_SD0),
 	DEF_MOD("pcie1",		 318,	R8A7795_CLK_S3D1),
 	DEF_MOD("pcie0",		 319,	R8A7795_CLK_S3D1),
 	DEF_MOD("intc-ap",		 408,	R8A7795_CLK_S3D1),
-- 
2.6.4

