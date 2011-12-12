From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 12 Dec 2011 03:02:09 +0000
Subject: [PATCH] sh: clkfwk: sh_clk_init_parent() should be called after clk_register()
Message-Id: <877h22h4r5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_clk_init_parent() are using clk->mapped_reg
which is mapped in clk_register()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This is for latest paul/common/clkfwk

 drivers/sh/clk/cpg.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index a0d8faa..45fee36 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -222,11 +222,11 @@ static int __init sh_clk_div6_register_ops(struct clk *clks, int nr,
 		clkp->ops = ops;
 		clkp->freq_table = freq_table + (k * freq_table_size);
 		clkp->freq_table[nr_divs].frequency = CPUFREQ_TABLE_END;
-		ret = sh_clk_init_parent(clkp);
+		ret = clk_register(clkp);
 		if (ret < 0)
 			break;
 
-		ret = clk_register(clkp);
+		ret = sh_clk_init_parent(clkp);
 	}
 
 	return ret;
-- 
1.7.5.4

