From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 22 Feb 2010 05:18:10 +0000
Subject: [PATCH v2] sh: sh7724: Update FSI/SPU2 clock
Message-Id: <ueikd6dnr.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When FSI and Network (= NFS file system) had been used
at the same time, the I/O of FSI was unstable.
This patch update the SPU2 clock (which is used for FSI)
to solve this issue.
Special thanks to Jeremy.

Signed-off-by: Jeremy Baker <Jeremy.Baker@renesas.com>
Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
This patch is v2 of
Subject: [PATCH] sh: sh7724: Add workaround for FSI sound

v1 -> v2

o use clk_set_rate


 arch/sh/boards/mach-ecovec24/setup.c |    5 +++++
 arch/sh/boards/mach-se/7724/setup.c  |   15 ++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 5c24628..4ed9f87 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1107,6 +1107,11 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_FSIOBLRCK,  NULL);
 	gpio_request(GPIO_FN_CLKAUDIOBO, NULL);
 
+	/* set SPU2 clock to 83.4 MHz */
+	clk = clk_get(NULL, "spu_clk");
+	clk_set_rate(clk, clk_round_rate(clk, 83333333));
+	clk_put(clk);
+
 	/* change parent of FSI B */
 	clk = clk_get(NULL, "fsib_clk");
 	clk_register(&fsimckb_clk);
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 858ecb2..674bc3c 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -595,7 +595,7 @@ arch_initcall(arch_setup);
 static int __init devices_setup(void)
 {
 	u16 sw = ctrl_inw(SW4140); /* select camera, monitor */
-	struct clk *fsia_clk;
+	struct clk *clk;
 
 	/* register board specific self-refresh code */
 	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
@@ -764,13 +764,18 @@ static int __init devices_setup(void)
 	gpio_request(GPIO_FN_CLKAUDIOBO, NULL);
 	gpio_request(GPIO_FN_FSIIASD,    NULL);
 
+	/* set SPU2 clock to 83.4 MHz */
+	clk = clk_get(NULL, "spu_clk");
+	clk_set_rate(clk, clk_round_rate(clk, 83333333));
+	clk_put(clk);
+
 	/* change parent of FSI A */
-	fsia_clk = clk_get(NULL, "fsia_clk");
+	clk = clk_get(NULL, "fsia_clk");
 	clk_register(&fsimcka_clk);
-	clk_set_parent(fsia_clk, &fsimcka_clk);
-	clk_set_rate(fsia_clk, 11000);
+	clk_set_parent(clk, &fsimcka_clk);
+	clk_set_rate(clk, 11000);
 	clk_set_rate(&fsimcka_clk, 11000);
-	clk_put(fsia_clk);
+	clk_put(clk);
 
 	/* SDHI0 connected to cn7 */
 	gpio_request(GPIO_FN_SDHI0CD, NULL);
-- 
1.6.3.3

