From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 May 2008 13:34:28 +0000
Subject: [PATCH] sh: use sm501 8250 mfd support on r2d boards
Message-Id: <20080522133428.12549.14671.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Make use of recently added sm501 8250 uart support, commit
61711f8fd8180e458cfb6846bcf4fc636a95f3db makes the mfd code
handle 8250 uarts so there is no longer need to do it from
the r2d board code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/rts7751r2d/setup.c |   39 -----------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

--- 0001/arch/sh/boards/renesas/rts7751r2d/setup.c
+++ work/arch/sh/boards/renesas/rts7751r2d/setup.c	2008-05-15 19:18:43.000000000 +0900
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/ata_platform.h>
-#include <linux/serial_8250.h>
 #include <linux/sm501.h>
 #include <linux/sm501-regs.h>
 #include <linux/pm.h>
@@ -109,27 +108,6 @@ static struct platform_device heartbeat_
 	.resource	= heartbeat_resources,
 };
 
-static struct plat_serial8250_port uart_platform_data[] = {
-	{
-		.membase	= (void __iomem *)0xb3e30000,
-		.mapbase	= 0xb3e30000,
-		.iotype		= UPIO_MEM,
-		.irq		= IRQ_VOYAGER,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ,
-		.regshift	= 2,
-		.uartclk	= (9600 * 16),
-	},
-	{ 0 },
-};
-
-static struct platform_device uart_device = {
-	.name		= "serial8250",
-	.id		= PLAT8250_DEV_PLATFORM,
-	.dev		= {
-		.platform_data	= uart_platform_data,
-	},
-};
-
 static struct resource sm501_resources[] = {
 	[0]	= {
 		.start	= 0x10000000,
@@ -185,11 +163,7 @@ static struct sm501_platdata_fb sm501_fb
 };
 
 static struct sm501_initdata sm501_initdata = {
-	.gpio_high	= {
-		.set	= 0x00001fe0,
-		.mask	= 0x0,
-	},
-	.devices	= SM501_USE_USB_HOST,
+	.devices	= SM501_USE_USB_HOST | SM501_USE_UART0,
 };
 
 static struct sm501_platdata sm501_platform_data = {
@@ -208,7 +182,6 @@ static struct platform_device sm501_devi
 };
 
 static struct platform_device *rts7751r2d_devices[] __initdata = {
-	&uart_device,
 	&sm501_device,
 	&heartbeat_device,
 	&spi_sh_sci_device,
@@ -272,16 +245,6 @@ static void __init rts7751r2d_setup(char
 
 	sm501_reg = (void __iomem *)0xb3e00000 + SM501_DRAM_CONTROL;
 	writel(readl(sm501_reg) | 0x00f107c0, sm501_reg);
-
-	/*
-	 * Power Mode Gate - Enable UART0
-	 */
-
-	sm501_reg = (void __iomem *)0xb3e00000 + SM501_POWER_MODE_0_GATE;
-	writel(readl(sm501_reg) | (1 << SM501_GATE_UART0), sm501_reg);
-
-	sm501_reg = (void __iomem *)0xb3e00000 + SM501_POWER_MODE_1_GATE;
-	writel(readl(sm501_reg) | (1 << SM501_GATE_UART0), sm501_reg);
 }
 
 /*
