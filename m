From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:41:19 +0000
Subject: [PATCH 2/5] ARM: shmobile: use common extra gpio functions on ap4evb
Message-Id: <87k3yvk71w.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch switch over to use common extra gpio method,
and reduced a waste of code on SH-ARM.

But these functions should be replaced by correct
gpio function in the future.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   19 ++-----------------
 1 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index ace6024..d7417f3 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1138,21 +1138,6 @@ static void __init fsi_init_pm_clock(void)
 	clk_put(fsia_ick);
 }
 
-/*
- * FIXME !!
- *
- * gpio_no_direction
- * are quick_hack.
- *
- * current gpio frame work doesn't have
- * the method to control only pull up/down/free.
- * this function should be replaced by correct gpio function
- */
-static void __init gpio_no_direction(u32 addr)
-{
-	__raw_writeb(0x00, addr);
-}
-
 /* TouchScreen */
 #ifdef CONFIG_AP4EVB_QHD
 # define GPIO_TSC_IRQ	GPIO_FN_IRQ28_123
@@ -1302,8 +1287,8 @@ static void __init ap4evb_init(void)
 
 	gpio_request(GPIO_PORT9, NULL);
 	gpio_request(GPIO_PORT10, NULL);
-	gpio_no_direction(GPIO_PORT9CR);  /* FSIAOBT needs no direction */
-	gpio_no_direction(GPIO_PORT10CR); /* FSIAOLR needs no direction */
+	gpio_direction_none(GPIO_PORT9CR);  /* FSIAOBT needs no direction */
+	gpio_direction_none(GPIO_PORT10CR); /* FSIAOLR needs no direction */
 
 	/* card detect pin for MMC slot (CN7) */
 	gpio_request(GPIO_PORT41, NULL);
-- 
1.7.5.4

