From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 17 Dec 2015 07:21:32 +0000
Subject: [PATCH 1/4] clk: shmobile: r8a7795: Add LVDS module clock
Message-Id: <1450336895-4279-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The parent clock hasn't been validated yet.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clk/shmobile/r8a7795-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
index 57c413635d1a..05479e64d253 100644
--- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
+++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
@@ -147,6 +147,7 @@ static const struct mssr_mod_clk r8a7795_mod_clks[] __initconst = {
 	DEF_MOD("du2",			 722,	R8A7795_CLK_S2D1),
 	DEF_MOD("du1",			 723,	R8A7795_CLK_S2D1),
 	DEF_MOD("du0",			 724,	R8A7795_CLK_S2D1),
+	DEF_MOD("lvds",			 727,	R8A7795_CLK_S2D1),
 	DEF_MOD("hdmi1",		 728,	R8A7795_CLK_HDMI),
 	DEF_MOD("hdmi0",		 729,	R8A7795_CLK_HDMI),
 	DEF_MOD("etheravb",		 812,	R8A7795_CLK_S3D2),
-- 
2.4.10

