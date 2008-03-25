From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 25 Mar 2008 08:14:03 +0000
Subject: [PATCH] sh: Add I2C platform data to sh7722
Message-Id: <20080325081403.10579.23375.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add platform data for the SuperH Mobile I2C block to sh7722.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- 0004/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-03-24 10:27:18.000000000 +0900
@@ -39,6 +39,26 @@ static struct platform_device usbf_devic
 	.resource	= usbf_resources,
 };
 
+static struct resource iic_resources[] = {
+	[0] = {
+		.name	= "IIC",
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
+static struct platform_device iic_device = {
+	.name           = "i2c-sh_mobile",
+	.num_resources  = ARRAY_SIZE(iic_resources),
+	.resource       = iic_resources,
+};
+
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase	= 0xffe00000,
@@ -73,6 +93,7 @@ static struct platform_device sci_device
 
 static struct platform_device *sh7722_devices[] __initdata = {
 	&usbf_device,
+	&iic_device,
 	&sci_device,
 };
 
