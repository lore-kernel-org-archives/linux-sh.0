From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 May 2012 08:12:51 +0000
Subject: [PATCH] ARM: mach-shmobile: add extra gpio setting functions
Message-Id: <87obpgab28.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current gpio frame work doesn't have the method to control only pull
up/down/free, but some SH-ARM boards need such kind of operation.
This patch adds extra gpio method for it, but these functions should
be replaced by correct gpio function in the future.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c          |   19 +------------
 arch/arm/mach-shmobile/board-armadillo800eva.c |   18 +------------
 arch/arm/mach-shmobile/board-g4evm.c           |   18 -------------
 arch/arm/mach-shmobile/board-mackerel.c        |   30 +---------------------
 arch/arm/mach-shmobile/include/mach/gpio.h     |   32 ++++++++++++++++++++++++
 5 files changed, 38 insertions(+), 79 deletions(-)

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
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 8a76def..c27dbe2 100644
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
@@ -1081,8 +1067,8 @@ static void __init eva_init(void)
 
 	gpio_request(GPIO_PORT7, NULL);
 	gpio_request(GPIO_PORT8, NULL);
-	gpio_no_direction(GPIO_PORT7CR); /* FSIAOBT needs no direction */
-	gpio_no_direction(GPIO_PORT8CR); /* FSIAOLR needs no direction */
+	gpio_direction_none(GPIO_PORT7CR); /* FSIAOBT needs no direction */
+	gpio_direction_none(GPIO_PORT8CR); /* FSIAOLR needs no direction */
 
 	/* FSI-HDMI */
 	gpio_request(GPIO_FN_FSIBCK,		NULL);
diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index f125732..6b6f028 100644
--- a/arch/arm/mach-shmobile/board-g4evm.c
+++ b/arch/arm/mach-shmobile/board-g4evm.c
@@ -271,24 +271,6 @@ static struct platform_device *g4evm_devices[] __initdata = {
 #define GPIO_SDHID1_D3	0xe6052106
 #define GPIO_SDHICMD1	0xe6052107
 
-/*
- * FIXME !!
- *
- * gpio_pull_up is quick_hack.
- *
- * current gpio frame work doesn't have
- * the method to control only pull up/down/free.
- * this function should be replaced by correct gpio function
- */
-static void __init gpio_pull_up(u32 addr)
-{
-	u8 data = __raw_readb(addr);
-
-	data &= 0x0F;
-	data |= 0xC0;
-	__raw_writeb(data, addr);
-}
-
 static void __init g4evm_init(void)
 {
 	sh7377_pinmux_init();
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index b577f7c..798be2b 100644
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
@@ -1475,8 +1449,8 @@ static void __init mackerel_init(void)
 
 	gpio_request(GPIO_PORT9,  NULL);
 	gpio_request(GPIO_PORT10, NULL);
-	gpio_no_direction(GPIO_PORT9CR);  /* FSIAOBT needs no direction */
-	gpio_no_direction(GPIO_PORT10CR); /* FSIAOLR needs no direction */
+	gpio_direction_none(GPIO_PORT9CR);  /* FSIAOBT needs no direction */
+	gpio_direction_none(GPIO_PORT10CR); /* FSIAOLR needs no direction */
 
 	intc_set_priority(IRQ_FSI, 3); /* irq priority FSI(3) > SMSC911X(2) */
 
diff --git a/arch/arm/mach-shmobile/include/mach/gpio.h b/arch/arm/mach-shmobile/include/mach/gpio.h
index de795b4..7c1e4ab 100644
--- a/arch/arm/mach-shmobile/include/mach/gpio.h
+++ b/arch/arm/mach-shmobile/include/mach/gpio.h
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/sh_pfc.h>
+#include <asm/io.h>
 
 #ifdef CONFIG_GPIOLIB
 
@@ -27,4 +28,35 @@ static inline int irq_to_gpio(unsigned int irq)
 
 #endif /* CONFIG_GPIOLIB */
 
+/*
+ * FIXME !!
+ *
+ * current gpio frame work doesn't have
+ * the method to control only pull up/down/free.
+ * this function should be replaced by correct gpio function
+ */
+static inline void __init gpio_direction_none(u32 addr)
+{
+	__raw_writeb(0x00, addr);
+}
+
+static inline void __init gpio_pull_up(u32 addr)
+{
+	u8 data = __raw_readb(addr);
+
+	data &= 0x0F;
+	data |= 0xC0;
+	__raw_writeb(data, addr);
+}
+
+static inline void __init gpio_pull_down(u32 addr)
+{
+	u8 data = __raw_readb(addr);
+
+	data &= 0x0F;
+	data |= 0xA0;
+
+	__raw_writeb(data, addr);
+}
+
 #endif /* __ASM_ARCH_GPIO_H */
-- 
1.7.5.4

