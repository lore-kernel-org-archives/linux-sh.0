From: yoshii.takashi@gmail.com
Date: Fri, 19 Nov 2010 04:11:12 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: ag5evm: use gpio.
Message-Id: <20101119131112.45efa0dc.yoshii.takashi@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Ag5evm board now uses gpio api to initialize pins and peripherals.

Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig        |    1 +
 arch/arm/mach-shmobile/board-ag5evm.c |   17 ++++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 2910ba2..7d56e86 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -61,6 +61,7 @@ endchoice
 config MACH_AG5EVM
 	bool "AG5EVM board"
 	depends on ARCH_SH73A0
+	select ARCH_REQUIRE_GPIOLIB
 
 comment "SH-Mobile System Configuration"
 
diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index bade04a..e0bc081 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -121,16 +121,19 @@ void __init ag5evm_init_irq(void)
 
 static void __init ag5evm_init(void)
 {
+	sh73a0_pinmux_init();
+
 	/* enable SCIFA2 */
-	__raw_writeb(0x12, PORT154CR); /* TXD */
-	__raw_writeb(0x22, PORT155CR); /* RXD */
-	__raw_writeb(0x12, PORT156CR); /* RTS */
-	__raw_writeb(0x22, PORT157CR); /* CTS */
+	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
+	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
+	gpio_request(GPIO_FN_SCIFA2_RTS1_, NULL);
+	gpio_request(GPIO_FN_SCIFA2_CTS1_, NULL);
 
 	/* enable SMSC911X */
-	__raw_writeb(0x20, PORT144CR); /* PINTA2 */
-	__raw_writeb(0x10, PORT145CR); /* RESET */
-	__raw_writel(__raw_readl(PORTR159_128DR) & ~(1 << 17), PORTR159_128DR);
+	gpio_request(GPIO_PORT144, NULL); /* PINTA2 */
+	gpio_direction_input(GPIO_PORT144);
+	gpio_request(GPIO_PORT145, NULL); /* RESET */
+	gpio_direction_output(GPIO_PORT145, 1);
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 64K*8way */
-- 
1.7.2.2

