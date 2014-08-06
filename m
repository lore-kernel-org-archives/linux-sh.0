From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 06 Aug 2014 01:24:00 +0000
Subject: [PATCH 1/3 v2] clk: shmobile: add missing 0x0100 for SDCKCR
Message-Id: <871tsul8b3.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

10cdfe9f327ab8d120cf6957e58c6203e3a53847
(clk: shmobile: Add R-Car Gen2 clocks support)
added R-Car Gen2 clock support via DT for v3.14.

But, cpg_sd01_div_table is missing
"0x0100: x 1/8" division ratio.
This patch fixes hidden bug.
It is based on R-Car H2 v0.7, R-Car M2 v0.9.

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/clk/shmobile/clk-rcar-gen2.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index dff7f79..e996425 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -202,6 +202,7 @@ static const struct clk_div_table cpg_sdh_div_table[] = {
 };
 
 static const struct clk_div_table cpg_sd01_div_table[] = {
+	{  4,  8 },
 	{  5, 12 }, {  6, 16 }, {  7, 18 }, {  8, 24 },
 	{ 10, 36 }, { 11, 48 }, { 12, 10 }, {  0,  0 },
 };
-- 
1.7.9.5

