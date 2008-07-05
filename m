From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 05 Jul 2008 03:32:23 +0000
Subject: [PATCH] sh: add SuperH Mobile I2C platform data to sh7366
Message-Id: <20080705033223.17253.86868.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080705033146.17251.47676.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080705033146.17251.47676.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds platform data for the single I2C channel on sh7366.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2008-07-01 19:57:37.000000000 +0900
@@ -14,6 +14,26 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 
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
@@ -34,6 +54,7 @@ static struct platform_device sci_device
 };
 
 static struct platform_device *sh7366_devices[] __initdata = {
+	&iic_device,
 	&sci_device,
 };
 
