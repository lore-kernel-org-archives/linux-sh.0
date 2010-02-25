From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Feb 2010 11:14:28 +0000
Subject: [PATCH] sh: remove dead LED code for migo-r and ms7724se
Message-Id: <20100225111428.6891.89641.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

CONFIG_PM is always set on SH-Mobile these days so
get rid of the unused LED setup code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-migor/setup.c   |   12 ------------
 arch/sh/boards/mach-se/7724/setup.c |   17 -----------------
 2 files changed, 29 deletions(-)

--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2010-02-25 19:53:23.000000000 +0900
@@ -496,23 +496,11 @@ static int __init migor_devices_setup(vo
 					&migor_sdram_enter_end,
 					&migor_sdram_leave_start,
 					&migor_sdram_leave_end);
-#ifdef CONFIG_PM
 	/* Let D11 LED show STATUS0 */
 	gpio_request(GPIO_FN_STATUS0, NULL);
 
 	/* Lit D12 LED show PDSTATUS */
 	gpio_request(GPIO_FN_PDSTATUS, NULL);
-#else
-	/* Lit D11 LED */
-	gpio_request(GPIO_PTJ7, NULL);
-	gpio_direction_output(GPIO_PTJ7, 1);
-	gpio_export(GPIO_PTJ7, 0);
-
-	/* Lit D12 LED */
-	gpio_request(GPIO_PTJ5, NULL);
-	gpio_direction_output(GPIO_PTJ5, 1);
-	gpio_export(GPIO_PTJ5, 0);
-#endif
 
 	/* SMC91C111 - Enable IRQ0, Setup CS4 for 16-bit fast access */
 	gpio_request(GPIO_FN_IRQ0, NULL);
--- 0008/arch/sh/boards/mach-se/7724/setup.c
+++ work/arch/sh/boards/mach-se/7724/setup.c	2010-02-25 19:56:15.000000000 +0900
@@ -607,7 +607,6 @@ static int __init devices_setup(void)
 	/* turn on USB clocks, use external clock */
 	__raw_writew((__raw_readw(PORT_MSELCRB) & ~0xc000) | 0x8000, PORT_MSELCRB);
 
-#ifdef CONFIG_PM
 	/* Let LED9 show STATUS2 */
 	gpio_request(GPIO_FN_STATUS2, NULL);
 
@@ -616,22 +615,6 @@ static int __init devices_setup(void)
 
 	/* Lit LED11 show PDSTATUS */
 	gpio_request(GPIO_FN_PDSTATUS, NULL);
-#else
-	/* Lit LED9 */
-	gpio_request(GPIO_PTJ6, NULL);
-	gpio_direction_output(GPIO_PTJ6, 1);
-	gpio_export(GPIO_PTJ6, 0);
-
-	/* Lit LED10 */
-	gpio_request(GPIO_PTJ5, NULL);
-	gpio_direction_output(GPIO_PTJ5, 1);
-	gpio_export(GPIO_PTJ5, 0);
-
-	/* Lit LED11 */
-	gpio_request(GPIO_PTJ7, NULL);
-	gpio_direction_output(GPIO_PTJ7, 1);
-	gpio_export(GPIO_PTJ7, 0);
-#endif
 
 	/* enable USB0 port */
 	__raw_writew(0x0600, 0xa40501d4);
