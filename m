From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 07 Jan 2014 16:47:53 +0000
Subject: [PATCH 2/2] clk: shmobile: rcar-gen2: Fix qspi divisor
Message-Id: <1389113273-10364-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389113273-10364-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1389113273-10364-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The qspi clock divisor is incorrectly set to twice the value it should
have, possibly because it has been computed based on PLL1 as the clock
parent instead of PLL1 / 2 (the datasheets specifies the qspi nominal
frequencies, not the divisor values). Fix it.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clk/shmobile/clk-rcar-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index 8c7bcbd..dd272a0 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -215,7 +215,7 @@ rcar_gen2_cpg_register_clock(struct device_node *np, struct rcar_gen2_cpg *cpg,
 	} else if (!strcmp(name, "qspi")) {
 		parent_name = "pll1_div2";
 		div = (cpg_mode & (BIT(3) | BIT(2) | BIT(1))) = BIT(2)
-		    ? 16 : 20;
+		    ? 8 : 10;
 	} else if (!strcmp(name, "sdh")) {
 		parent_name = "pll1_div2";
 		table = cpg_sdh_div_table;
-- 
1.8.3.2

