From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Aug 2009 14:39:15 +0000
Subject: [PATCH] sh: add r8a66597 usb0 gadget to the kfr2r09 board
Message-Id: <20090819143915.23285.30577.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add USB gadget support for port YC301 on the KFR2R09 board.

The r8a66597-udc driver is hooked up as a platform device,
clocks are enabled via I2C and some registers are configured
to enable the USB in gadget mode. The hardware driving the
USB port is the on-chip USB0 block in the sh7724 processor
configured as USB gadget controller.

This board is using external hardware to detect USB hotplug
events and allows the processor to dynamically start and stop
clocks. This well thought out hardware feature is unused at
this point and plug and play is unfortunately unsupported.
To properly support all hardware features the USB gadget
stack may need some adjustment.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-kfr2r09/setup.c |  103 +++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

--- 0001/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-08-19 22:34:52.000000000 +0900
@@ -16,6 +16,8 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
+#include <linux/i2c.h>
+#include <linux/usb/r8a66597.h>
 #include <video/sh_mobile_lcdc.h>
 #include <asm/clock.h>
 #include <asm/machvec.h>
@@ -175,6 +177,35 @@ static struct platform_device kfr2r09_sh
 	},
 };
 
+static struct r8a66597_platdata kfr2r09_usb0_gadget_data = {
+	.on_chip = 1,
+};
+
+static struct resource kfr2r09_usb0_gadget_resources[] = {
+	[0] = {
+		.start	= 0x04d80000,
+		.end	= 0x04d80123,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 65,
+		.end	= 65,
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_LOW,
+	},
+};
+
+static struct platform_device kfr2r09_usb0_gadget_device = {
+	.name		= "r8a66597_udc",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= NULL,         /*  not use dma */
+		.coherent_dma_mask	= 0xffffffff,
+		.platform_data	= &kfr2r09_usb0_gadget_data,
+	},
+	.num_resources	= ARRAY_SIZE(kfr2r09_usb0_gadget_resources),
+	.resource	= kfr2r09_usb0_gadget_resources,
+};
+
 static struct platform_device *kfr2r09_devices[] __initdata = {
 	&kfr2r09_nor_flash_device,
 	&kfr2r09_nand_flash_device,
@@ -186,6 +217,74 @@ static struct platform_device *kfr2r09_d
 #define BSC_CS0WCR 0xfec10024
 #define BSC_CS4BCR 0xfec10010
 #define BSC_CS4WCR 0xfec10030
+#define PORT_MSELCRB 0xa4050182
+
+static int kfr2r09_usb0_gadget_i2c_setup(void)
+{
+	struct i2c_adapter *a;
+	struct i2c_msg msg;
+	unsigned char buf[2];
+	int ret;
+
+	a = i2c_get_adapter(0);
+	if (!a)
+		return -ENODEV;
+
+	/* set bit 1 (the second bit) of chip at 0x09, register 0x13 */
+	buf[0] = 0x13;
+	msg.addr = 0x09;
+	msg.buf = buf;
+	msg.len = 1;
+	msg.flags = 0;
+	ret = i2c_transfer(a, &msg, 1);
+	if (ret != 1)
+		return -ENODEV;
+
+	buf[0] = 0;
+	msg.addr = 0x09;
+	msg.buf = buf;
+	msg.len = 1;
+	msg.flags = I2C_M_RD;
+	ret = i2c_transfer(a, &msg, 1);
+	if (ret != 1)
+		return -ENODEV;
+
+	buf[1] = buf[0] | (1 << 1);
+	buf[0] = 0x13;
+	msg.addr = 0x09;
+	msg.buf = buf;
+	msg.len = 2;
+	msg.flags = 0;
+	ret = i2c_transfer(a, &msg, 1);
+	if (ret != 1)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int kfr2r09_usb0_gadget_setup(void)
+{
+	int plugged_in;
+
+	gpio_request(GPIO_PTN4, NULL); /* USB_DET */
+	gpio_direction_input(GPIO_PTN4);
+	plugged_in = gpio_get_value(GPIO_PTN4);
+	if (!plugged_in)
+		return -ENODEV; /* no cable plugged in */
+
+	if (kfr2r09_usb0_gadget_i2c_setup() != 0)
+		return -ENODEV; /* unable to configure using i2c */
+
+	ctrl_outw((ctrl_inw(PORT_MSELCRB) & ~0xc000) | 0x8000, PORT_MSELCRB);
+	gpio_request(GPIO_FN_PDSTATUS, NULL); /* R-standby disables USB clock */
+	gpio_request(GPIO_PTV6, NULL); /* USBCLK_ON */
+	gpio_direction_output(GPIO_PTV6, 1); /* USBCLK_ON = H */
+	msleep(20); /* wait 20ms to let the clock settle */
+	clk_enable(clk_get(NULL, "usb0"));
+	ctrl_outw(0x0600, 0xa40501d4);
+
+	return 0;
+}
 
 static int __init kfr2r09_devices_setup(void)
 {
@@ -245,6 +344,10 @@ static int __init kfr2r09_devices_setup(
 	gpio_request(GPIO_PTU0, NULL); /* LEDSTDBY/ */
 	gpio_direction_output(GPIO_PTU0, 1);
 
+	/* setup USB function */
+	if (kfr2r09_usb0_gadget_setup() = 0)
+		platform_device_register(&kfr2r09_usb0_gadget_device);
+
 	return platform_add_devices(kfr2r09_devices,
 				    ARRAY_SIZE(kfr2r09_devices));
 }
