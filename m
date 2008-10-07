From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 07 Oct 2008 13:55:10 +0000
Subject: [PATCH] sh: Use sh7720 pinmux code on the magicpanelr2 board
Message-Id: <20081007135510.29528.37293.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch hooks up the magicpanelr2 board with the sh7720 pinmux code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Compiles fine but untested.

 arch/sh/boards/Kconfig              |    1 +
 arch/sh/boards/board-magicpanelr2.c |   11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

--- 0010/arch/sh/boards/Kconfig
+++ work/arch/sh/boards/Kconfig	2008-10-06 16:00:48.000000000 +0900
@@ -238,6 +238,7 @@ config SH_X3PROTO
 config SH_MAGIC_PANEL_R2
 	bool "Magic Panel R2"
 	depends on CPU_SUBTYPE_SH7720
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Select Magic Panel R2 if configuring for Magic Panel R2.
 
--- 0001/arch/sh/boards/board-magicpanelr2.c
+++ work/arch/sh/boards/board-magicpanelr2.c	2008-10-06 16:06:12.000000000 +0900
@@ -13,12 +13,14 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/map.h>
 #include <asm/magicpanelr2.h>
 #include <asm/heartbeat.h>
+#include <asm/sh7720.h>
 
 #define LAN9115_READY	(ctrl_inl(0xA8000084UL) & 0x00000001UL)
 
@@ -170,7 +172,14 @@ static void __init setup_port_multiplexi
 	/* R7 A25;	     R6 A24;	     R5 A23;		  R4 A22;
 	 * R3 A21;	     R2 A20;	     R1 A19;		  R0 A0;
 	 */
-	ctrl_outw(0x0000, PORT_PRCR);	/* 00 00 00 00 00 00 00 00 */
+	gpio_request(GPIO_FN_A25, NULL);
+	gpio_request(GPIO_FN_A24, NULL);
+	gpio_request(GPIO_FN_A23, NULL);
+	gpio_request(GPIO_FN_A22, NULL);
+	gpio_request(GPIO_FN_A21, NULL);
+	gpio_request(GPIO_FN_A20, NULL);
+	gpio_request(GPIO_FN_A19, NULL);
+	gpio_request(GPIO_FN_A0, NULL);
 
 	/* S7 (x);		S6 (x);        S5 (x);	     S4 GPO(EEPROM_CS2);
 	 * S3 GPO(EEPROM_CS1);  S2 SIOF0_TXD;  S1 SIOF0_RXD; S0 SIOF0_SCK;
