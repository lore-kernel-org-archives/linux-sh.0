From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:41:27 +0000
Subject: [PATCH 3/5] ARM: shmobile: use common extra gpio functions on g4evm
Message-Id: <87ipefk71o.wl%kuninori.morimoto.gx@renesas.com>
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
 arch/arm/mach-shmobile/board-g4evm.c |   38 +++++++++-------------------------
 1 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index f125732..af9c3e2 100644
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
@@ -351,11 +333,11 @@ static void __init g4evm_init(void)
 	gpio_request(GPIO_FN_SDHID0_3, NULL);
 	gpio_request(GPIO_FN_SDHICMD0, NULL);
 	gpio_request(GPIO_FN_SDHIWP0, NULL);
-	gpio_pull_up(GPIO_SDHID0_D0);
-	gpio_pull_up(GPIO_SDHID0_D1);
-	gpio_pull_up(GPIO_SDHID0_D2);
-	gpio_pull_up(GPIO_SDHID0_D3);
-	gpio_pull_up(GPIO_SDHICMD0);
+	gpio_request_pullup(GPIO_SDHID0_D0);
+	gpio_request_pullup(GPIO_SDHID0_D1);
+	gpio_request_pullup(GPIO_SDHID0_D2);
+	gpio_request_pullup(GPIO_SDHID0_D3);
+	gpio_request_pullup(GPIO_SDHICMD0);
 
 	/* SDHI1 */
 	gpio_request(GPIO_FN_SDHICLK1, NULL);
@@ -364,11 +346,11 @@ static void __init g4evm_init(void)
 	gpio_request(GPIO_FN_SDHID1_2, NULL);
 	gpio_request(GPIO_FN_SDHID1_3, NULL);
 	gpio_request(GPIO_FN_SDHICMD1, NULL);
-	gpio_pull_up(GPIO_SDHID1_D0);
-	gpio_pull_up(GPIO_SDHID1_D1);
-	gpio_pull_up(GPIO_SDHID1_D2);
-	gpio_pull_up(GPIO_SDHID1_D3);
-	gpio_pull_up(GPIO_SDHICMD1);
+	gpio_request_pullup(GPIO_SDHID1_D0);
+	gpio_request_pullup(GPIO_SDHID1_D1);
+	gpio_request_pullup(GPIO_SDHID1_D2);
+	gpio_request_pullup(GPIO_SDHID1_D3);
+	gpio_request_pullup(GPIO_SDHICMD1);
 
 	sh7377_add_standard_devices();
 
-- 
1.7.5.4

