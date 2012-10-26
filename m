From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Oct 2012 08:49:26 +0000
Subject: [PATCH] sh: clkfwk: bugfix: sh_clk_div_enable() care sh_clk_div_set_rate() if div6
Message-Id: <87pq45mxd9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

764f4e4e33d18cde4dcaf8a0d860b749c6d6d08b
(sh: clkfwk: Use shared sh_clk_div_enable/disable())
shared enable/disable funcions for div4/div6.
But new sh_clk_div_enable() didn't care sh_clk_div_set_rate()
which is required on div6 clock.
This patch fixes it, and is tested by HDMI sound output on armadillo800eva

Reported-by: Cao Minh Hiep <hiepcm@gmail.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
Paul

This is bugfix patch which should go to v3.6/v3.7.
But please check this style.
It is checking CLK_MASK_DIV_ON_DISABLE for div6 or not.

 drivers/sh/clk/cpg.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 07e9fb4..fe6dbef 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -126,7 +126,14 @@ static int sh_clk_div_set_rate(struct clk *clk, unsigned long rate)
 
 static int sh_clk_div_enable(struct clk *clk)
 {
-	sh_clk_write(sh_clk_read(clk) & ~CPG_CKSTP_BIT, clk);
+	int ret = 0;
+
+	if (clk->flags & CLK_MASK_DIV_ON_DISABLE)
+		ret = sh_clk_div_set_rate(clk, clk->rate);
+
+	if (ret = 0)
+		sh_clk_write(sh_clk_read(clk) & ~CPG_CKSTP_BIT, clk);
+
 	return 0;
 }
 
-- 
1.7.9.5

