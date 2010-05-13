From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 13 May 2010 01:08:33 +0000
Subject: [PATCH] sh: Check return value of clk_get on ecovec24
Message-Id: <uaas4lib3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 6c13b92..cc87a69 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1138,16 +1138,20 @@ static int __init arch_setup(void)
 
 	/* set SPU2 clock to 83.4 MHz */
 	clk = clk_get(NULL, "spu_clk");
-	clk_set_rate(clk, clk_round_rate(clk, 83333333));
-	clk_put(clk);
+	if (clk) {
+		clk_set_rate(clk, clk_round_rate(clk, 83333333));
+		clk_put(clk);
+	}
 
 	/* change parent of FSI B */
 	clk = clk_get(NULL, "fsib_clk");
-	clk_register(&fsimckb_clk);
-	clk_set_parent(clk, &fsimckb_clk);
-	clk_set_rate(clk, 11000);
-	clk_set_rate(&fsimckb_clk, 11000);
-	clk_put(clk);
+	if (clk) {
+		clk_register(&fsimckb_clk);
+		clk_set_parent(clk, &fsimckb_clk);
+		clk_set_rate(clk, 11000);
+		clk_set_rate(&fsimckb_clk, 11000);
+		clk_put(clk);
+	}
 
 	gpio_request(GPIO_PTU0, NULL);
 	gpio_direction_output(GPIO_PTU0, 0);
@@ -1159,8 +1163,10 @@ static int __init arch_setup(void)
 
 	/* set VPU clock to 166 MHz */
 	clk = clk_get(NULL, "vpu_clk");
-	clk_set_rate(clk, clk_round_rate(clk, 166000000));
-	clk_put(clk);
+	if (clk) {
+		clk_set_rate(clk, clk_round_rate(clk, 166000000));
+		clk_put(clk);
+	}
 
 	/* enable IrDA */
 	gpio_request(GPIO_FN_IRDA_OUT, NULL);
-- 
1.7.0.4

