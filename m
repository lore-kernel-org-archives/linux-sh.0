From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 05 Jul 2008 03:32:06 +0000
Subject: [PATCH] sh: add SuperH Mobile I2C platform data to sh7723
Message-Id: <20080705033206.17252.98753.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080705033146.17251.47676.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080705033146.17251.47676.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds platform data for the single I2C channel on sh7723.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-07-01 19:54:16.000000000 +0900
@@ -113,9 +113,30 @@ static struct platform_device sh7723_usb
 	.resource	= sh7723_usb_host_resources,
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
 static struct platform_device *sh7723_devices[] __initdata = {
 	&sci_device,
 	&rtc_device,
+	&iic_device,
 	&sh7723_usb_host_device,
 };
 
