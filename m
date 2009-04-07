From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 07 Apr 2009 08:41:57 +0000
Subject: [PATCH] Urquell: Add board comment
Message-Id: <uocv8etjd.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/board-urquell.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-urquell.c b/arch/sh/boards/board-urquell.c
index 8367d1d..f217f35 100644
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
@@ -21,6 +23,29 @@
 #include <asm/heartbeat.h>
 #include <asm/sizes.h>
 
+/* SWx  8765 4321
+ *----------------------------
+ * SW1  1101 0010  -> Pck 66MHz version
+ *     (0101 0010)    Pck 33MHz version (check CS1BCR)
+ * SW2  xxxx x1x0  -> little endian
+ *                    29bit mode
+ * SW47 0001 1000  -> CS0 : nor flash
+ *                    CS1 : SRAM, registers, LAN, PCMCIA
+ *                    38400 bps
+ *
+ * Address
+ * 0x00000000     Nor Flash
+ * 0x04000000     SRAM
+ * 0x05000000     FPGA register
+ * 0x05800000     LAN91C111
+ * 0x06000000     PCMCIA
+ * 0x10000000     PCIe
+ * 0x14000000     LRAM/URAM
+ * 0x18000000     ATA/NAND-Flash
+ * 0x1C000000     SH7786 Control register
+ */
+
+/* HeartBeat */
 static struct resource heartbeat_resources[] = {
 	[0] = {
 		.start	= BOARDREG(SLEDR),
@@ -43,6 +68,7 @@ static struct platform_device heartbeat_device = {
 	.resource	= heartbeat_resources,
 };
 
+/* LAN91C111 */
 static struct smc91x_platdata smc91x_info = {
 	.flags = SMC91X_USE_16BIT | SMC91X_NOWAIT,
 };
@@ -69,6 +95,7 @@ static struct platform_device smc91x_eth_device = {
 	},
 };
 
+/* Nor Flash */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
 		.name		= "loader",
-- 
1.5.6.3

