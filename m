From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 28 Jan 2011 09:59:17 +0000
Subject: [PATCH] ARM: mach-shmobile: AG5EVM MIPI-DSI LCD reset delay fix
Message-Id: <20110128095917.25179.95684.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add a 100 ms delay after the MIPI-DSI panel reset to
fix issue related to the LCD panel not starting properly
at boot up time.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ag5evm.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c	2011-01-28 18:46:36.000000000 +0900
@@ -454,6 +454,7 @@ static void __init ag5evm_init(void)
 	gpio_direction_output(GPIO_PORT217, 0);
 	mdelay(1);
 	gpio_set_value(GPIO_PORT217, 1);
+	mdelay(100);
 
 	/* LCD backlight controller */
 	gpio_request(GPIO_PORT235, NULL); /* RESET */
