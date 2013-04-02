From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 02 Apr 2013 11:06:15 +0000
Subject: [PATCH 1/6] clk: sh: add sh_clk_reparent_register()
Message-Id: <87a9ph5h0c.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Some SuperH clocks need to decide its parent clock from
specified register.
This patch adds sh_clk_reparent_register() for this purpose

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/sh/clk/cpg.c   |   15 ++++++++++++---
 include/linux/sh_clk.h |    1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 1ebe67c..54e3e32 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -200,6 +200,17 @@ static int __init sh_clk_init_parent(struct clk *clk)
 	return 0;
 }
 
+int __init sh_clk_reparent_register(struct clk *clk)
+{
+	int ret;
+
+	ret = clk_register(clk);
+	if (ret = 0)
+		ret = sh_clk_init_parent(clk);
+
+	return ret;
+}
+
 static int __init sh_clk_div_register_ops(struct clk *clks, int nr,
 			struct clk_div_table *table, struct sh_clk_ops *ops)
 {
@@ -226,9 +237,7 @@ static int __init sh_clk_div_register_ops(struct clk *clks, int nr,
 		clkp->freq_table = freq_table + (k * freq_table_size);
 		clkp->freq_table[nr_divs].frequency = CPUFREQ_TABLE_END;
 
-		ret = clk_register(clkp);
-		if (ret = 0)
-			ret = sh_clk_init_parent(clkp);
+		ret = sh_clk_reparent_register(clkp);
 	}
 
 	return ret;
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 60c7239..aa349d6 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -192,6 +192,7 @@ int sh_clk_div4_reparent_register(struct clk *clks, int nr,
 	.flags		= _flags | CLK_MASK_DIV_ON_DISABLE,	\
 }
 
+int sh_clk_reparent_register(struct clk *clk);
 int sh_clk_div6_register(struct clk *clks, int nr);
 int sh_clk_div6_reparent_register(struct clk *clks, int nr);
 
-- 
1.7.9.5

