From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 16 Apr 2009 04:16:07 +0000
Subject: [PATCH 4/6 v2] Add I2C support for SH7724
Message-Id: <uocuxutbs.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
v1 -> v2

o fixed end of address in iicX_resource.
o iicX_device and iicX_resource order was changed.

 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   46 ++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 471a736..a89a2bc 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -125,10 +125,56 @@ static struct platform_device usb0_device = {
 	.resource	= usb0_host_resources,
 };
 
+/* I2C0 */
+static struct resource iic0_resources[] = {
+	[0] = {
+		.name	= "IIC0",
+		.start  = 0x04470000,
+		.end    = 0x04470018 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 96,
+		.end    = 99,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device iic0_device = {
+	.name           = "i2c-sh_mobile",
+	.id             = 0, /* "i2c0" clock */
+	.num_resources  = ARRAY_SIZE(iic0_resources),
+	.resource       = iic0_resources,
+};
+
+/* I2C1 */
+static struct resource iic1_resources[] = {
+	[0] = {
+		.name	= "IIC1",
+		.start  = 0x04750000,
+		.end    = 0x04750018 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 92,
+		.end    = 95,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device iic1_device = {
+	.name           = "i2c-sh_mobile",
+	.id             = 1, /* "i2c1" clock */
+	.num_resources  = ARRAY_SIZE(iic1_resources),
+	.resource       = iic1_resources,
+};
+
 static struct platform_device *sh7724_devices[] __initdata = {
 	&sci_device,
 	&rtc_device,
 	&usb0_device,
+	&iic0_device,
+	&iic1_device,
 };
 
 #define UPONCR0		0xa40501d4
-- 
1.5.6.3

