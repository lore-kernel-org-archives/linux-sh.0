From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 13 Dec 2011 16:36:51 +0000
Subject: [PATCH 05/05] ARM: mach-shmobile: Marzen LAN89218 support
Message-Id: <20111213163651.4096.91994.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add LAN89218 support to the r8a7779 Marzen board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-marzen.c |   36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

--- 0022/arch/arm/mach-shmobile/board-marzen.c
+++ work/arch/arm/mach-shmobile/board-marzen.c	2011-12-14 00:12:32.000000000 +0900
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/dma-mapping.h>
+#include <linux/smsc911x.h>
 #include <mach/hardware.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
@@ -37,7 +38,38 @@
 #include <asm/hardware/gic.h>
 #include <asm/traps.h>
 
+/* SMSC LAN89218 */
+static struct resource smsc911x_resources[] = {
+	[0] = {
+		.start		= 0x18000000, /* ExCS0 */
+		.end		= 0x180000ff, /* A1->A7 */
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= gic_spi(28), /* IRQ 1 */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct smsc911x_platform_config smsc911x_platdata = {
+	.flags		= SMSC911X_USE_32BIT, /* 32-bit SW on 16-bit HW bus */
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
+};
+
+static struct platform_device eth_device = {
+	.name		= "smsc911x",
+	.id		= 0,
+	.dev  = {
+		.platform_data = &smsc911x_platdata,
+	},
+	.resource	= smsc911x_resources,
+	.num_resources	= ARRAY_SIZE(smsc911x_resources),
+};
+
 static struct platform_device *marzen_devices[] __initdata = {
+	&eth_device,
 };
 
 static struct map_desc marzen_io_desc[] __initdata = {
@@ -95,6 +127,10 @@ static void __init marzen_init(void)
 	gpio_request(GPIO_FN_TX4, NULL);
 	gpio_request(GPIO_FN_RX4, NULL);
 
+	/* LAN89218 */
+	gpio_request(GPIO_FN_EX_CS0, NULL); /* nCS */
+	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
+
 	r8a7779_add_standard_devices();
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
