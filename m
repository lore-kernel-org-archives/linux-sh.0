From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Apr 2009 08:02:13 +0000
Subject: [PATCH] sh: smsc911x support for the rsk7203 board
Message-Id: <20090428080213.16323.31667.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds support for the LAN9118 ethernet on rsk7203.

The LAN9118 controller is hooked up using a 16-bit data bus,
but the rsk7203 board does not swap the byte lanes as needed
between the sh7203 processor and the the ethernet controller.

In the processor the CS memory window is configured in 16-bit
mode but the smsc911x driver is told to do 32-bit accesses to
improve performance. The SMSC911X_SWAP_FIFO flag is used
to tell the driver to do software byte swapping of fifo data.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Needs "smsc911x: add fifo byteswap support V2".

 arch/sh/boards/mach-rsk/devices-rsk7203.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- 0001/arch/sh/boards/mach-rsk/devices-rsk7203.c
+++ work/arch/sh/boards/mach-rsk/devices-rsk7203.c	2009-04-21 20:30:23.000000000 +0900
@@ -26,13 +26,13 @@ static struct smsc911x_platform_config s
 	.phy_interface	= PHY_INTERFACE_MODE_MII,
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
-	.flags		= SMSC911X_USE_16BIT,
+	.flags		= SMSC911X_USE_32BIT | SMSC911X_SWAP_FIFO,
 };
 
 static struct resource smsc911x_resources[] = {
 	[0] = {
 		.start		= 0x24000000,
-		.end		= 0x24000000 + 0x100,
+		.end		= 0x240000ff,
 		.flags		= IORESOURCE_MEM,
 	},
 	[1] = {
@@ -99,6 +99,10 @@ static int __init rsk7203_devices_setup(
 	gpio_request(GPIO_FN_TXD0, NULL);
 	gpio_request(GPIO_FN_RXD0, NULL);
 
+	/* Setup LAN9118: CS1 in 16-bit Big Endian Mode, IRQ0 at Port B */
+	ctrl_outl(0x36db0400, 0xfffc0008); /* CS1BCR */
+	gpio_request(GPIO_FN_IRQ0_PB, NULL);
+
 	return platform_add_devices(rsk7203_devices,
 				    ARRAY_SIZE(rsk7203_devices));
 }
