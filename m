From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 01 Dec 2010 00:31:46 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: Add FSI-AK4643 support
Message-Id: <w3p8w0a2v0x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This patch is depend on
[PATCH] ARM: mach-shmobile: mackerel: Add LEDs support

On paul's rmobile/mackerel branch + this patch,
compile is OK, but FSI-AK4643 doesn't work.
If ALSA tree was merged, it start work.

 arch/arm/mach-shmobile/board-mackerel.c |   84 +++++++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index b9528b0..cf3e660 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -29,15 +29,19 @@
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/io.h>
+#include <linux/i2c.h>
 #include <linux/leds.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/smsc911x.h>
+#include <linux/sh_intc.h>
 #include <linux/usb/r8a66597.h>
 
 #include <video/sh_mobile_lcdc.h>
 
+#include <sound/sh_fsi.h>
+
 #include <mach/common.h>
 #include <mach/sh7372.h>
 
@@ -133,6 +137,21 @@
  * CN31 is used as Host in Linux.
  */
 
+/*
+ * FIXME !!
+ *
+ * gpio_no_direction
+ * are quick_hack.
+ *
+ * current gpio frame work doesn't have
+ * the method to control only pull up/down/free.
+ * this function should be replaced by correct gpio function
+ */
+static void __init gpio_no_direction(u32 addr)
+{
+	__raw_writeb(0x00, addr);
+}
+
 /* MTD */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
@@ -347,6 +366,42 @@ static struct platform_device leds_device = {
 	},
 };
 
+/* FSI */
+#define IRQ_FSI evt2irq(0x1840)
+static struct sh_fsi_platform_info fsi_info = {
+	.porta_flags =	SH_FSI_BRS_INV		|
+			SH_FSI_OUT_SLAVE_MODE	|
+			SH_FSI_IN_SLAVE_MODE	|
+			SH_FSI_OFMT(PCM)	|
+			SH_FSI_IFMT(PCM),
+};
+
+static struct resource fsi_resources[] = {
+	[0] = {
+		.name	= "FSI",
+		.start	= 0xFE3C0000,
+		.end	= 0xFE3C0400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = IRQ_FSI,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device fsi_device = {
+	.name		= "sh_fsi2",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(fsi_resources),
+	.resource	= fsi_resources,
+	.dev	= {
+		.platform_data	= &fsi_info,
+	},
+};
+
+static struct platform_device fsi_ak4643_device = {
+	.name		= "sh_fsi2_a_ak4643",
+};
 
 static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
@@ -354,6 +409,15 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&lcdc_device,
 	&usb1_host_device,
 	&leds_device,
+	&fsi_device,
+	&fsi_ak4643_device,
+};
+
+/* I2C */
+static struct i2c_board_info i2c0_devices[] = {
+	{
+		I2C_BOARD_INFO("ak4643", 0x13),
+	},
 };
 
 static struct map_desc mackerel_io_desc[] __initdata = {
@@ -377,6 +441,8 @@ static void __init mackerel_map_io(void)
 	shmobile_setup_console();
 }
 
+#define GPIO_PORT9CR	0xE6051009
+#define GPIO_PORT10CR	0xE605100A
 static void __init mackerel_init(void)
 {
 	sh7372_pinmux_init();
@@ -434,6 +500,24 @@ static void __init mackerel_init(void)
 	/* setup USB phy */
 	__raw_writew(0x8a0a, 0xE6058130);	/* USBCR2 */
 
+	/* enable FSI2 port A (ak4643) */
+	gpio_request(GPIO_FN_FSIAIBT,	NULL);
+	gpio_request(GPIO_FN_FSIAILR,	NULL);
+	gpio_request(GPIO_FN_FSIAISLD,	NULL);
+	gpio_request(GPIO_FN_FSIAOSLD,	NULL);
+	gpio_request(GPIO_PORT161,	NULL);
+	gpio_direction_output(GPIO_PORT161, 0); /* slave */
+
+	gpio_request(GPIO_PORT9,  NULL);
+	gpio_request(GPIO_PORT10, NULL);
+	gpio_no_direction(GPIO_PORT9CR);  /* FSIAOBT needs no direction */
+	gpio_no_direction(GPIO_PORT10CR); /* FSIAOLR needs no direction */
+
+	intc_set_priority(IRQ_FSI, 3); /* irq priority FSI(3) > SMSC911X(2) */
+
+
+	i2c_register_board_info(0, i2c0_devices,
+				ARRAY_SIZE(i2c0_devices));
 
 	sh7372_add_standard_devices();
 
-- 
1.7.1

