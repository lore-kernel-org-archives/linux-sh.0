From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:41:36 +0000
Subject: [PATCH 4/5] ARM: shmobile: use common extra gpio functions on mackrel
Message-Id: <87hatzk71f.wl%kuninori.morimoto.gx@renesas.com>
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
 arch/arm/mach-shmobile/board-mackerel.c |   34 +++---------------------------
 1 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 150122a..9424ae3 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -203,32 +203,6 @@
  * amixer set "HPOUTR Mixer DACH" on
  */
 
-/*
- * FIXME !!
- *
- * gpio_no_direction
- * gpio_pull_down
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
-static void __init gpio_pull_down(u32 addr)
-{
-	u8 data = __raw_readb(addr);
-
-	data &= 0x0F;
-	data |= 0xA0;
-
-	__raw_writeb(data, addr);
-}
-
 /* MTD */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
@@ -1458,11 +1432,11 @@ static void __init mackerel_init(void)
 
 	/* USBHS0 */
 	gpio_request(GPIO_FN_VBUS0_0, NULL);
-	gpio_pull_down(GPIO_PORT168CR); /* VBUS0_0 pull down */
+	gpio_request_pulldown(GPIO_PORT168CR); /* VBUS0_0 pull down */
 
 	/* USBHS1 */
 	gpio_request(GPIO_FN_VBUS0_1, NULL);
-	gpio_pull_down(GPIO_PORT167CR); /* VBUS0_1 pull down */
+	gpio_request_pulldown(GPIO_PORT167CR); /* VBUS0_1 pull down */
 	gpio_request(GPIO_FN_IDIN_1_113, NULL);
 
 	/* enable FSI2 port A (ak4643) */
@@ -1475,8 +1449,8 @@ static void __init mackerel_init(void)
 
 	gpio_request(GPIO_PORT9,  NULL);
 	gpio_request(GPIO_PORT10, NULL);
-	gpio_no_direction(GPIO_PORT9CR);  /* FSIAOBT needs no direction */
-	gpio_no_direction(GPIO_PORT10CR); /* FSIAOLR needs no direction */
+	gpio_direction_none(GPIO_PORT9CR);  /* FSIAOBT needs no direction */
+	gpio_direction_none(GPIO_PORT10CR); /* FSIAOLR needs no direction */
 
 	intc_set_priority(IRQ_FSI, 3); /* irq priority FSI(3) > SMSC911X(2) */
 
-- 
1.7.5.4

