From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 11 Mar 2010 10:42:47 +0000
Subject: [PATCH 1/3] ARM: mach-shmobile: sh7372: Add I2C0, I2C1 support
Message-Id: <ur5nrgmvs.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh7372 chip has 2 INTC.
Then, I2C0 is connected to INTCS, and I2C1 is connected to INTCA.
Both of these has no GPIO settings.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/setup-sh7372.c |   47 +++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 1d11532..b7c5d89 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -32,6 +32,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/* SCIF */
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xe6c40000,
 	.flags		= UPF_BOOT_AUTOCONF,
@@ -137,6 +138,7 @@ static struct platform_device scif6_device = {
 	},
 };
 
+/* CMT */
 static struct sh_timer_config cmt10_platform_data = {
 	.name = "CMT10",
 	.channel_offset = 0x10,
@@ -169,6 +171,49 @@ static struct platform_device cmt10_device = {
 	.num_resources	= ARRAY_SIZE(cmt10_resources),
 };
 
+/* I2C */
+static struct resource iic0_resources[] = {
+	[0] = {
+		.name	= "IIC0",
+		.start  = 0xFFF20000,
+		.end    = 0xFFF20425 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = intcs_evt2irq(0xe00),
+		.end    = intcs_evt2irq(0xe60),
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
+static struct resource iic1_resources[] = {
+	[0] = {
+		.name	= "IIC1",
+		.start  = 0xE6C20000,
+		.end    = 0xE6C20425 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 44,
+		.end    = 47,
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
 static struct platform_device *sh7372_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -178,6 +223,8 @@ static struct platform_device *sh7372_early_devices[] __initdata = {
 	&scif5_device,
 	&scif6_device,
 	&cmt10_device,
+	&iic0_device,
+	&iic1_device,
 };
 
 void __init sh7372_add_standard_devices(void)
-- 
1.6.3.3

