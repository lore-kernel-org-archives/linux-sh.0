From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Nov 2012 06:01:46 +0000
Subject: [PATCH v2] sh: clkfwk: bugfix: sh_clk_div_enable() care sh_clk_div_set_rate() if div6
Message-Id: <87a9u4x5q1.wl%kuninori.morimoto.gx@renesas.com>
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
This patch fixes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Paul

This is v2 patch of sh_clk_div_disable() bugfix.
it used SH_CLK_DIV6_MSK as you indicated.
Sorry for my late response.

 drivers/sh/clk/cpg.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 07e9fb4..d118bac 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -126,6 +126,12 @@ static int sh_clk_div_set_rate(struct clk *clk, unsigned long rate)
 
 static int sh_clk_div_enable(struct clk *clk)
 {
+	if (clk->div_mask = SH_CLK_DIV6_MSK) {
+		int ret = sh_clk_div_set_rate(clk, clk->rate);
+		if (ret < 0)
+			return ret;
+	}
+
 	sh_clk_write(sh_clk_read(clk) & ~CPG_CKSTP_BIT, clk);
 	return 0;
 }
-- 
1.7.9.5

