From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 01 Apr 2015 06:02:13 +0000
Subject: [PATCH] clk: shmobile: r8a7779: check return of of_property_read_string_index()
Message-Id: <87pp7o2xqg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@linaro.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch indicates error message if return value of
of_property_read_string_index() was not zero.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/clk/shmobile/clk-r8a7779.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/shmobile/clk-r8a7779.c b/drivers/clk/shmobile/clk-r8a7779.c
index 652ecac..af439b2 100644
--- a/drivers/clk/shmobile/clk-r8a7779.c
+++ b/drivers/clk/shmobile/clk-r8a7779.c
@@ -155,8 +155,10 @@ static void __init r8a7779_cpg_clocks_init(struct device_node *np)
 		const char *name;
 		struct clk *clk;
 
-		of_property_read_string_index(np, "clock-output-names", i,
-					      &name);
+		if (of_property_read_string_index(np, "clock-output-names", i,
+						  &name))
+			pr_err("%s: can't get clock-output-names (%d)\n",
+			       __func__, i);
 
 		clk = r8a7779_cpg_register_clock(np, cpg, config,
 						 plla_mult, name);
-- 
1.9.1

