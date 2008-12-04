From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2008 09:00:22 +0000
Subject: [PATCH 04/06] sh: add isp1161 usb host device to se7343
Message-Id: <20081204090022.25773.49705.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add isp1161 platform data to get usb host working on se7343.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-se/7343/setup.c |   45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

--- 0013/arch/sh/boards/mach-se/7343/setup.c
+++ work/arch/sh/boards/mach-se/7343/setup.c	2008-12-04 13:38:21.000000000 +0900
@@ -3,6 +3,8 @@
 #include <linux/mtd/physmap.h>
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
+#include <linux/usb/isp116x.h>
+#include <linux/delay.h>
 #include <asm/machvec.h>
 #include <mach-se/mach/se7343.h>
 #include <asm/heartbeat.h>
@@ -126,11 +128,54 @@ static struct platform_device uart_devic
 	},
 };
 
+static void isp116x_delay(struct device *dev, int delay)
+{
+	ndelay(delay);
+}
+
+static struct resource usb_resources[] = {
+	[0] = {
+		.start  = 0x11800000,
+		.end    = 0x11800001,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 0x11800002,
+		.end    = 0x11800003,
+		.flags  = IORESOURCE_MEM,
+	},
+	[2] = {
+		.start  = USB_IRQ,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct isp116x_platform_data usb_platform_data = {
+	.sel15Kres		= 1,
+	.oc_enable		= 1,
+	.int_act_high		= 0,
+	.int_edge_triggered	= 0,
+	.remote_wakeup_enable	= 0,
+	.delay			= isp116x_delay,
+};
+
+static struct platform_device usb_device = {
+	.name			= "isp116x-hcd",
+	.id			= -1,
+	.num_resources  	= ARRAY_SIZE(usb_resources),
+	.resource       	= usb_resources,
+	.dev			= {
+		.platform_data	= &usb_platform_data,
+	},
+
+};
+
 static struct platform_device *sh7343se_platform_devices[] __initdata = {
 	&smc91x_device,
 	&heartbeat_device,
 	&nor_flash_device,
 	&uart_device,
+	&usb_device,
 };
 
 static int __init sh7343se_devices_setup(void)
