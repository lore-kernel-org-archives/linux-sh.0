From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Aug 2011 05:44:51 +0000
Subject: [PATCH 06/07] ARM: mach-shmobile: Kota2 SCIFA4 and SCIFB support
Message-Id: <20110818054451.23410.45985.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SCIFA4 and SCIFB support to the Kota2 board.
Only pins are configured since the SCIF platform
devices are already present in the sh73a0 code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kota2.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- 0009/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2011-08-17 22:41:42.000000000 +0900
@@ -256,6 +256,12 @@ static void __init kota2_init(void)
 	gpio_request(GPIO_FN_SCIFA2_RTS1_, NULL);
 	gpio_request(GPIO_FN_SCIFA2_CTS1_, NULL);
 
+	/* SCIFA4 (UART1) */
+	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
+	gpio_request(GPIO_FN_SCIFA4_RXD, NULL);
+	gpio_request(GPIO_FN_SCIFA4_RTS_, NULL);
+	gpio_request(GPIO_FN_SCIFA4_CTS_, NULL);
+
 	/* SMSC911X */
 	gpio_request(GPIO_FN_D0_NAF0, NULL);
 	gpio_request(GPIO_FN_D1_NAF1, NULL);
@@ -313,6 +319,13 @@ static void __init kota2_init(void)
 	gpio_request(GPIO_PORT208, NULL); /* Reset */
 	gpio_direction_output(GPIO_PORT208, 1);
 
+	/* SCIFB (BT) */
+	gpio_request(GPIO_FN_PORT159_SCIFB_SCK, NULL);
+	gpio_request(GPIO_FN_PORT160_SCIFB_TXD, NULL);
+	gpio_request(GPIO_FN_PORT161_SCIFB_CTS_, NULL);
+	gpio_request(GPIO_FN_PORT162_SCIFB_RXD, NULL);
+	gpio_request(GPIO_FN_PORT163_SCIFB_RTS_, NULL);
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(__io(0xf0100000), 0x40460000, 0x82000fff);
