From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Apr 2011 08:13:53 +0000
Subject: [PATCH] sh: clkfwk: fixup clk_rate_table_build parameter in div6 clock
Message-Id: <w3paaft1c8u.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

div6 clock should not use arch_flags for clk_rate_table_build,
because SH_CLK_DIV6_EXT doesn't care .arch_flags.
clk->freq_table[] will be all CPUFREQ_ENTRY_INVALID without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/sh/clk/cpg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 6172335..82dd6fb 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -105,7 +105,7 @@ static int sh_clk_div6_set_parent(struct clk *clk, struct clk *parent)
 
 	/* Rebuild the frequency table */
 	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
-			     table, &clk->arch_flags);
+			     table, NULL);
 
 	return 0;
 }
-- 
1.7.1

