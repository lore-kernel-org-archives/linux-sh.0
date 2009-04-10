From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 10 Apr 2009 00:47:50 +0000
Subject: [PATCH v2] Urquell: Add board comment
Message-Id: <u1vs1nwb5.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
>> Paul
I'm sorry again. please use this patch not old one.

v1 -> v2

o fix bit order miss
o add more detail comment

 arch/sh/boards/board-urquell.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-urquell.c b/arch/sh/boards/board-urquell.c
index 8367d1d..beb88c4 100644
--- a/arch/sh/boards/board-urquell.c
+++ b/arch/sh/boards/board-urquell.c
@@ -2,6 +2,8 @@
  * Renesas Technology Corp. SH7786 Urquell Support.
  *
  * Copyright (C) 2008  Kuninori Morimoto <morimoto.kuninori@renesas.com>
+ *
+ * Based on board-sh7785lcr.c
  * Copyright (C) 2008  Yoshihiro Shimoda
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -21,6 +23,32 @@
 #include <asm/heartbeat.h>
 #include <asm/sizes.h>
 
+/*
+ * bit  1234 5678
+ *----------------------------
+ * SW1  0101 0010  -> Pck 33MHz version
+ *     (1101 0010)    Pck 66MHz version
+ * SW2  0x1x xxxx  -> little endian
+ *                    29bit mode
+ * SW47 0001 1000  -> CS0 : on-board flash
+ *                    CS1 : SRAM, registers, LAN, PCMCIA
+ *                    38400 bps for SCIF1
+ *
+ * Address
+ * 0x00000000 - 0x04000000  (CS0)     Nor Flash
+ * 0x04000000 - 0x04200000  (CS1)     SRAM
+ * 0x05000000 - 0x05800000  (CS1)     on board register
+ * 0x05800000 - 0x06000000  (CS1)     LAN91C111
+ * 0x06000000 - 0x06400000  (CS1)     PCMCIA
+ * 0x08000000 - 0x10000000  (CS2-CS3) DDR3
+ * 0x10000000 - 0x14000000  (CS4)     PCIe
+ * 0x14000000 - 0x14800000  (CS5)     Core0 LRAM/URAM
+ * 0x14800000 - 0x15000000  (CS5)     Core1 LRAM/URAM
+ * 0x18000000 - 0x1C000000  (CS6)     ATA/NAND-Flash
+ * 0x1C000000 -             (CS7)     SH7786 Control register
+ */
+
+/* HeartBeat */
 static struct resource heartbeat_resources[] = {
 	[0] = {
 		.start	= BOARDREG(SLEDR),
@@ -43,6 +71,7 @@ static struct platform_device heartbeat_device = {
 	.resource	= heartbeat_resources,
 };
 
+/* LAN91C111 */
 static struct smc91x_platdata smc91x_info = {
 	.flags = SMC91X_USE_16BIT | SMC91X_NOWAIT,
 };
@@ -69,6 +98,7 @@ static struct platform_device smc91x_eth_device = {
 	},
 };
 
+/* Nor Flash */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
 		.name		= "loader",
-- 
1.5.6.3

