From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2008 09:00:11 +0000
Subject: [PATCH 03/06] sh: add st16c2550 devices to se7343
Message-Id: <20081204090011.25773.35511.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add 8250 platform data to setup the ST16C2550C chip on se7343.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-se/7343/setup.c   |   33 +++++++++++++++++++++++++++++++++
 arch/sh/include/mach-se/mach/se7343.h |    6 +++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

--- 0003/arch/sh/boards/mach-se/7343/setup.c
+++ work/arch/sh/boards/mach-se/7343/setup.c	2008-12-04 17:00:16.000000000 +0900
@@ -1,6 +1,8 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
+#include <linux/serial_8250.h>
+#include <linux/serial_reg.h>
 #include <asm/machvec.h>
 #include <mach-se/mach/se7343.h>
 #include <asm/heartbeat.h>
@@ -94,10 +96,41 @@ static struct platform_device nor_flash_
 	.resource	= nor_flash_resources,
 };
 
+#define ST16C2550C_FLAGS (UPF_BOOT_AUTOCONF | UPF_IOREMAP)
+
+static struct plat_serial8250_port serial_platform_data[] = {
+	[0] = {
+		.iotype		= UPIO_MEM,
+		.mapbase	= 0x16000000,
+		.regshift	= 1,
+		.flags		= ST16C2550C_FLAGS,
+		.irq		= UARTA_IRQ,
+		.uartclk	= 7372800,
+	},
+	[1] = {
+		.iotype		= UPIO_MEM,
+		.mapbase	= 0x17000000,
+		.regshift	= 1,
+		.flags		= ST16C2550C_FLAGS,
+		.irq		= UARTB_IRQ,
+		.uartclk	= 7372800,
+	},
+	{ },
+};
+
+static struct platform_device uart_device = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM,
+	.dev			= {
+		.platform_data	= serial_platform_data,
+	},
+};
+
 static struct platform_device *sh7343se_platform_devices[] __initdata = {
 	&smc91x_device,
 	&heartbeat_device,
 	&nor_flash_device,
+	&uart_device,
 };
 
 static int __init sh7343se_devices_setup(void)
--- 0001/arch/sh/include/mach-se/mach/se7343.h
+++ work/arch/sh/include/mach-se/mach/se7343.h	2008-12-04 16:32:06.000000000 +0900
@@ -132,8 +132,10 @@
 #define SE7343_FPGA_IRQ_MRSHPC3	3
 #define SE7343_FPGA_IRQ_SMC	6	/* EXT_IRQ2 */
 #define SE7343_FPGA_IRQ_USB	8
+#define SE7343_FPGA_IRQ_UARTA	10
+#define SE7343_FPGA_IRQ_UARTB	11
 
-#define SE7343_FPGA_IRQ_NR	11
+#define SE7343_FPGA_IRQ_NR	12
 #define SE7343_FPGA_IRQ_BASE	120
 
 #define MRSHPC_IRQ3    	(SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_MRSHPC3)
@@ -142,6 +144,8 @@
 #define MRSHPC_IRQ0    	(SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_MRSHPC0)
 #define SMC_IRQ		(SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_SMC)
 #define USB_IRQ		(SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_USB)
+#define UARTA_IRQ	(SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_UARTA)
+#define UARTB_IRQ	(SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_UARTB)
 
 /* arch/sh/boards/se/7343/irq.c */
 void init_7343se_IRQ(void);
