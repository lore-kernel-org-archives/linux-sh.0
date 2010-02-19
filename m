From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 19 Feb 2010 07:27:01 +0000
Subject: [PATCH] sh: sh7724: Add workaround for FSI sound
Message-Id: <upr41pseb.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When FSI and Network (= NFS file system) had been used
at the same time, the I/O of FSI was unstable.
This patch modify the SPU2 clock which is used for FSI
as nearly equal system clock for stable continuous operation.
Special thanks to Jeremy.

Signed-off-by: Jeremy Baker <Jeremy.Baker@renesas.com>
Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   34 ++++++++++++++++++++++++++
 arch/sh/boards/mach-se/7724/setup.c  |   44 ++++++++++++++++++++++++++++++----
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 5c24628..4caa8a0 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -690,6 +690,34 @@ static struct platform_device camera_devices[] = {
 	},
 };
 
+/*
+ * SPU2
+ *
+ * used to clock core of FSI,
+ * set close to 12.288MHz,
+ * see
+ *    Table 45.9  point 4 of 7724 manual (English ver)
+ *    Table 45.11 point 4 of 7724 manual (Japanese ver)
+ */
+#define SPUCLKCR	0xA415003C
+static void spuclkcr_init(struct clk *clk)
+{
+	/* 333 MHz / (27 + 1) = 11.9 MHz */
+	ctrl_outl(0x000001B, clk->enable_reg);
+}
+
+static struct clk_ops spuclkcr_clk_ops = {
+	.init = spuclkcr_init,
+};
+
+static struct clk spuclkcr_clk = {
+	.name		= "spuclkcr_clk",
+	.id		= -1,
+	.ops		= &spuclkcr_clk_ops,
+	.enable_reg	= (void __iomem *)SPUCLKCR,
+	.rate		= 11904761, /* 11.9 MHz */
+};
+
 /* FSI */
 /*
  * FSI-B use external clock which came from da7210.
@@ -1107,6 +1135,12 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_FSIOBLRCK,  NULL);
 	gpio_request(GPIO_FN_CLKAUDIOBO, NULL);
 
+	/* change parent of SPU2 */
+	clk = clk_get(NULL, "spu_clk");
+	clk_register(&spuclkcr_clk);
+	clk_set_parent(clk, &spuclkcr_clk);
+	clk_put(clk);
+
 	/* change parent of FSI B */
 	clk = clk_get(NULL, "fsib_clk");
 	clk_register(&fsimckb_clk);
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 858ecb2..08cc731 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -257,6 +257,34 @@ static struct platform_device ceu1_device = {
 	},
 };
 
+/*
+ * SPU2
+ *
+ * used to clock core of FSI,
+ * set close to 12.288MHz,
+ * see
+ *    Table 45.9  point 4 of 7724 manual (English ver)
+ *    Table 45.11 point 4 of 7724 manual (Japanese ver)
+ */
+#define SPUCLKCR	0xA415003C
+static void spuclkcr_init(struct clk *clk)
+{
+	/* 333 MHz / (27 + 1) = 11.9 MHz */
+	ctrl_outl(0x000001B, clk->enable_reg);
+}
+
+static struct clk_ops spuclkcr_clk_ops = {
+	.init = spuclkcr_init,
+};
+
+static struct clk spuclkcr_clk = {
+	.name		= "spuclkcr_clk",
+	.id		= -1,
+	.ops		= &spuclkcr_clk_ops,
+	.enable_reg	= (void __iomem *)SPUCLKCR,
+	.rate		= 11904761, /* 11.9 MHz */
+};
+
 /* FSI */
 /*
  * FSI-A use external clock which came from ak464x.
@@ -595,7 +623,7 @@ arch_initcall(arch_setup);
 static int __init devices_setup(void)
 {
 	u16 sw = ctrl_inw(SW4140); /* select camera, monitor */
-	struct clk *fsia_clk;
+	struct clk *clk;
 
 	/* register board specific self-refresh code */
 	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
@@ -764,13 +792,19 @@ static int __init devices_setup(void)
 	gpio_request(GPIO_FN_CLKAUDIOBO, NULL);
 	gpio_request(GPIO_FN_FSIIASD,    NULL);
 
+	/* change parent of SPU2 */
+	clk = clk_get(NULL, "spu_clk");
+	clk_register(&spuclkcr_clk);
+	clk_set_parent(clk, &spuclkcr_clk);
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

