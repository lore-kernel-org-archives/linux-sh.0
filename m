From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 15 Oct 2015 06:59:36 +0000
Subject: [PATCH/RFC 5/6] clk: shmobile: rcar-gen2: Obtain MD pin value using boot-mode-reg
Message-Id: <1444892377-10170-6-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use new boot mode reg infrastructure to obtain the mode pin
value for initialising clocks for for R-Car Gen2 SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c |  3 +--
 drivers/clk/shmobile/clk-rcar-gen2.c     | 12 ++++++++++--
 include/linux/clk/shmobile.h             |  2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 3a2bffd4c1cf..81a446bf1702 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -138,14 +138,13 @@ void __init rcar_gen2_timer_init_for_arch_timer(void)
 void __init rcar_gen2_timer_init(void)
 {
 	int err;
-	u32 mode = rcar_gen2_read_mode_pins();
 
 	err = rcar_gen2_init_boot_mode();
 	if (err)
 		pr_err("Could not initialise boot mode register driver\n");
 
 	rcar_gen2_timer_init_for_arch_timer();
-	rcar_gen2_clocks_init(mode);
+	rcar_gen2_clocks_init();
 	clocksource_of_init();
 }
 
diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
index 745496f7ee9c..deb12bb91a07 100644
--- a/drivers/clk/shmobile/clk-rcar-gen2.c
+++ b/drivers/clk/shmobile/clk-rcar-gen2.c
@@ -20,6 +20,8 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
+#include <misc/boot-mode-reg.h>
+
 struct rcar_gen2_cpg {
 	struct clk_onecell_data data;
 	spinlock_t lock;
@@ -421,9 +423,15 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
 CLK_OF_DECLARE(rcar_gen2_cpg_clks, "renesas,rcar-gen2-cpg-clocks",
 	       rcar_gen2_cpg_clocks_init);
 
-void __init rcar_gen2_clocks_init(u32 mode)
+void __init rcar_gen2_clocks_init(void)
 {
-	cpg_mode = mode;
+	int err;
+
+	err = boot_mode_reg_get(&cpg_mode);
+	if (err) {
+		pr_err("%s: failed obtain boot mode\n", __func__);
+		return;
+	}
 
 	of_clk_init(NULL);
 }
diff --git a/include/linux/clk/shmobile.h b/include/linux/clk/shmobile.h
index cb19cc1865ca..3f93ab6c2ab6 100644
--- a/include/linux/clk/shmobile.h
+++ b/include/linux/clk/shmobile.h
@@ -22,7 +22,7 @@ struct generic_pm_domain;
 
 void r8a7778_clocks_init(u32 mode);
 void r8a7779_clocks_init(u32 mode);
-void rcar_gen2_clocks_init(u32 mode);
+void rcar_gen2_clocks_init(void);
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 void cpg_mstp_add_clk_domain(struct device_node *np);
-- 
2.1.4

