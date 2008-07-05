From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 05 Jul 2008 03:31:46 +0000
Subject: [PATCH] sh: add SuperH Mobile I2C platform data to sh7343
Message-Id: <20080705033146.17251.47676.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds platform data for two I2C channels to the sh7343.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2008-07-01 19:50:43.000000000 +0900
@@ -12,6 +12,46 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 
+static struct resource iic0_resources[] = {
+	[0] = {
+		.name	= "IIC0",
+		.start  = 0x04470000,
+		.end    = 0x04470017,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 96,
+		.end    = 99,
+		.flags  = IORESOURCE_IRQ,
+       },
+};
+
+static struct platform_device iic0_device = {
+	.name           = "i2c-sh_mobile",
+	.num_resources  = ARRAY_SIZE(iic0_resources),
+	.resource       = iic0_resources,
+};
+
+static struct resource iic1_resources[] = {
+	[0] = {
+		.name	= "IIC1",
+		.start  = 0x04750000,
+		.end    = 0x04750017,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 44,
+		.end    = 47,
+		.flags  = IORESOURCE_IRQ,
+       },
+};
+
+static struct platform_device iic1_device = {
+	.name           = "i2c-sh_mobile",
+	.num_resources  = ARRAY_SIZE(iic1_resources),
+	.resource       = iic1_resources,
+};
+
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase	= 0xffe00000,
@@ -32,6 +72,8 @@ static struct platform_device sci_device
 };
 
 static struct platform_device *sh7343_devices[] __initdata = {
+	&iic0_device,
+	&iic1_device,
 	&sci_device,
 };
 
