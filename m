From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:41:45 +0000
Subject: [PATCH 5/5] ARM: shmobile: use common extra gpio functions on armadillo800eva
Message-Id: <87fw9jk716.wl%kuninori.morimoto.gx@renesas.com>
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
 arch/arm/mach-shmobile/board-armadillo800eva.c |   18 ++----------------
 1 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 3066fa7..5f8f571 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -122,20 +122,6 @@
  */
 
 /*
- * FIXME !!
- *
- * gpio_no_direction
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
-/*
  * USB function
  *
  * When you use USB Function,
@@ -1087,8 +1073,8 @@ static void __init eva_init(void)
 
 	gpio_request(GPIO_PORT7, NULL);
 	gpio_request(GPIO_PORT8, NULL);
-	gpio_no_direction(GPIO_PORT7CR); /* FSIAOBT needs no direction */
-	gpio_no_direction(GPIO_PORT8CR); /* FSIAOLR needs no direction */
+	gpio_direction_none(GPIO_PORT7CR); /* FSIAOBT needs no direction */
+	gpio_direction_none(GPIO_PORT8CR); /* FSIAOLR needs no direction */
 
 	/* FSI-HDMI */
 	gpio_request(GPIO_FN_FSIBCK,		NULL);
-- 
1.7.5.4

