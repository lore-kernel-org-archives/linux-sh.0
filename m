From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Feb 2010 11:13:31 +0000
Subject: [PATCH] ARM: mach-shmobile: G3EVM USBHS support
Message-Id: <20100210111331.11137.3162.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add G3EVM platform data and a magic setup sequence to
initialize the r8a66597 block aka USBHS in sh7367.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the pinmux patch.

 arch/arm/mach-shmobile/board-g3evm.c  |   58 +++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh7367.c |    7 +++
 2 files changed, 65 insertions(+)

--- 0010/arch/arm/mach-shmobile/board-g3evm.c
+++ work/arch/arm/mach-shmobile/board-g3evm.c	2010-02-10 19:48:04.000000000 +0900
@@ -26,6 +26,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/usb/r8a66597.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <mach/sh7367.h>
@@ -86,9 +87,49 @@ static struct platform_device nor_flash_
 	.resource	= nor_flash_resources,
 };
 
+/* USBHS */
+void usb_host_port_power(int port, int power)
+{
+	if (!power) /* only power-on supported for now */
+		return;
+
+	/* set VBOUT/PWEN and EXTLP0 in DVSTCTR */
+	__raw_writew(__raw_readw(0xe6890008) | 0x600, 0xe6890008);
+}
+
+static struct r8a66597_platdata usb_host_data = {
+	.on_chip = 1,
+	.port_power = usb_host_port_power,
+};
+
+static struct resource usb_host_resources[] = {
+	[0] = {
+		.name	= "USBHS",
+		.start	= 0xe6890000,
+		.end	= 0xe68900e5,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 65,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usb_host_device = {
+	.name		= "r8a66597_hcd",
+	.id		= 0,
+	.dev = {
+		.platform_data		= &usb_host_data,
+		.dma_mask		= NULL,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(usb_host_resources),
+	.resource	= usb_host_resources,
+};
 
 static struct platform_device *g3evm_devices[] __initdata = {
 	&nor_flash_device,
+	&usb_host_device,
 };
 
 static struct map_desc g3evm_io_desc[] __initdata = {
@@ -138,6 +179,23 @@ static void __init g3evm_init(void)
 	gpio_request(GPIO_FN_SCIFA1_CTS, NULL);
 	gpio_request(GPIO_FN_SCIFA1_RTS, NULL);
 
+	/* USBHS */
+	gpio_request(GPIO_FN_VBUS0, NULL);
+	gpio_request(GPIO_FN_PWEN, NULL);
+	gpio_request(GPIO_FN_OVCN, NULL);
+	gpio_request(GPIO_FN_OVCN2, NULL);
+	gpio_request(GPIO_FN_EXTLP, NULL);
+	gpio_request(GPIO_FN_IDIN, NULL);
+
+	/* enable clock in SYMSTPCR2 */
+	__raw_writel(__raw_readl(0xe6158048) & ~(1 << 22), 0xe6158048);
+
+	/* setup USB phy */
+	__raw_writew(0x0300, 0xe605810a);	/* USBCR1 */
+	__raw_writew(0x00e0, 0xe60581c0);	/* CPFCH */
+	__raw_writew(0x6010, 0xe60581c6);	/* CGPOSR */
+	__raw_writew(0x8a0a, 0xe605810c);	/* USBCR2 */
+
 	sh7367_add_standard_devices();
 
 	platform_add_devices(g3evm_devices, ARRAY_SIZE(g3evm_devices));
--- 0001/arch/arm/mach-shmobile/clock-sh7367.c
+++ work/arch/arm/mach-shmobile/clock-sh7367.c	2010-02-10 19:47:58.000000000 +0900
@@ -70,11 +70,18 @@ static struct clk r_clk = {
 	.rate	    = 32768,
 };
 
+/* a static usb0 for now - enough to get r8a66597 working */
+static struct clk usb0_clk = {
+	.name	    = "usb0",
+};
+
 static struct clk_lookup lookups[] = {
 	{
 		.clk = &peripheral_clk,
 	}, {
 		.clk = &r_clk,
+	}, {
+		.clk = &usb0_clk,
 	}
 };
 
