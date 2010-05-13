From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 13 May 2010 01:08:37 +0000
Subject: [PATCH] sh: Check return value of clk_get on ms7724
Message-Id: <u8w7oliaz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uaas4lib3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <uaas4lib3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/boards/mach-se/7724/setup.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index ccaa290..4b24125 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -771,16 +771,20 @@ static int __init devices_setup(void)
 
 	/* set SPU2 clock to 83.4 MHz */
 	clk = clk_get(NULL, "spu_clk");
-	clk_set_rate(clk, clk_round_rate(clk, 83333333));
-	clk_put(clk);
+	if (clk) {
+		clk_set_rate(clk, clk_round_rate(clk, 83333333));
+		clk_put(clk);
+	}
 
 	/* change parent of FSI A */
 	clk = clk_get(NULL, "fsia_clk");
-	clk_register(&fsimcka_clk);
-	clk_set_parent(clk, &fsimcka_clk);
-	clk_set_rate(clk, 11000);
-	clk_set_rate(&fsimcka_clk, 11000);
-	clk_put(clk);
+	if (clk) {
+		clk_register(&fsimcka_clk);
+		clk_set_parent(clk, &fsimcka_clk);
+		clk_set_rate(clk, 11000);
+		clk_set_rate(&fsimcka_clk, 11000);
+		clk_put(clk);
+	}
 
 	/* SDHI0 connected to cn7 */
 	gpio_request(GPIO_FN_SDHI0CD, NULL);
-- 
1.7.0.4

