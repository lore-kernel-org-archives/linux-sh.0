From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Aug 2009 09:52:02 +0000
Subject: [PATCH] sh: add r8a66597 usb1 gadget to the se7724 board
Message-Id: <20090819095202.11560.98304.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add USB gadget support for port CN26 on the Solution Engine 7724
board. The r8a66597-udc driver is hooked up as a platform device
and some registers are configured to enable the USB in gadget mode.
The hardware driving the USB port is the on-chip USB1 block in
the sh7724 processor configured as USB gadget controller.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Needs the r8a66597-udc clock framework patch to run properly.

 arch/sh/boards/mach-se/7724/setup.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- 0001/arch/sh/boards/mach-se/7724/setup.c
+++ work/arch/sh/boards/mach-se/7724/setup.c	2009-08-19 18:34:38.000000000 +0900
@@ -341,6 +341,35 @@ static struct platform_device sh7724_usb
 	.resource	= sh7724_usb0_host_resources,
 };
 
+static struct r8a66597_platdata sh7724_usb1_gadget_data = {
+	.on_chip = 1,
+};
+
+static struct resource sh7724_usb1_gadget_resources[] = {
+	[0] = {
+		.start	= 0xa4d90000,
+		.end	= 0xa4d90123,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 66,
+		.end	= 66,
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
+	},
+};
+
+static struct platform_device sh7724_usb1_gadget_device = {
+	.name		= "r8a66597_udc",
+	.id		= 1, /* USB1 */
+	.dev = {
+		.dma_mask		= NULL,         /*  not use dma */
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data		= &sh7724_usb1_gadget_data,
+	},
+	.num_resources	= ARRAY_SIZE(sh7724_usb1_gadget_resources),
+	.resource	= sh7724_usb1_gadget_resources,
+};
+
 static struct platform_device *ms7724se_devices[] __initdata = {
 	&heartbeat_device,
 	&smc91x_eth_device,
@@ -351,6 +380,7 @@ static struct platform_device *ms7724se_
 	&keysc_device,
 	&sh_eth_device,
 	&sh7724_usb0_host_device,
+	&sh7724_usb1_gadget_device,
 };
 
 #define EEPROM_OP   0xBA206000
@@ -459,6 +489,9 @@ static int __init devices_setup(void)
 	/* enable USB0 port */
 	ctrl_outw(0x0600, 0xa40501d4);
 
+	/* enable USB1 port */
+	ctrl_outw(0x0600, 0xa4050192);
+
 	/* enable IRQ 0,1,2 */
 	gpio_request(GPIO_FN_INTC_IRQ0, NULL);
 	gpio_request(GPIO_FN_INTC_IRQ1, NULL);
