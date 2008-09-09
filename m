From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 09 Sep 2008 08:17:42 +0000
Subject: [PATCH] sh: add support FLCTL for ap325rxa board
Message-Id: <48C63126.5060008@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds platform_device for sh_flctl driver, NAND Flash
simple partition, and GPIO setting.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---

 This patch depends on the sh_flctl MTD driver patch.
 http://marc.info/?l=linux-sh&m2094731021820&w=2

 arch/sh/boards/board-ap325rxa.c |   52 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-ap325rxa.c b/arch/sh/boards/board-ap325rxa.c
index fd16125..4ba3001 100644
--- a/arch/sh/boards/board-ap325rxa.c
+++ b/arch/sh/boards/board-ap325rxa.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
+#include <linux/mtd/sh_flctl.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/smc911x.h>
@@ -93,6 +94,38 @@ static struct platform_device ap325rxa_nor_flash_device = {
 	},
 };

+static struct mtd_partition nand_partition_info[] = {
+	{
+		.name	= "nand_data",
+		.offset	= 0,
+		.size	= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct resource nand_flash_resources[] = {
+	[0] = {
+		.start	= 0xa4530000,
+		.end	= 0xa45300ff,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct sh_flctl_platform_data nand_flash_data = {
+	.parts		= nand_partition_info,
+	.nr_parts	= ARRAY_SIZE(nand_partition_info),
+	.flcmncr_val	= FCKSEL_E | TYPESEL_SET | NANWF_E,
+	.has_hwecc	= 1,
+};
+
+static struct platform_device nand_flash_device = {
+	.name		= "sh_flctl",
+	.resource	= nand_flash_resources,
+	.num_resources	= ARRAY_SIZE(nand_flash_resources),
+	.dev		= {
+		.platform_data = &nand_flash_data,
+	},
+};
+
 #define FPGA_LCDREG	0xB4100180
 #define FPGA_BKLREG	0xB4100212
 #define FPGA_LCDREG_VAL	0x0018
@@ -101,11 +134,19 @@ static struct platform_device ap325rxa_nor_flash_device = {
 #define PORT_PMCR	0xA4050116
 #define PORT_PRCR	0xA405011C
 #define PORT_PSCR	0xA405011E
+#define PORT_PUCR	0xA4050142
+#define PORT_PVCR	0xA4050144
+#define PORT_PXCR	0xA4050148
 #define PORT_PZCR	0xA405014C
 #define PORT_HIZCRA	0xA4050158
+#define PORT_HIZCRC	0xA405015C
 #define PORT_MSELCRB	0xA4050182
+#define PORT_DRVCRA	0xA405018A
+#define PORT_DRVCRB	0xA405018C
 #define PORT_PSDR	0xA405013E
+#define PORT_PXDR	0xA4050168
 #define PORT_PZDR	0xA405016C
+#define PORT_PSELC	0xA4050152
 #define PORT_PSELD	0xA4050154

 static void ap320_wvga_power_on(void *board_data)
@@ -278,6 +319,7 @@ static struct platform_device *ap325rxa_devices[] __initdata = {
 #ifdef CONFIG_I2C
 	&camera_device,
 #endif
+	&nand_flash_device,
 };

 static struct i2c_board_info __initdata ap325rxa_i2c_devices[] = {
@@ -312,6 +354,16 @@ static void __init ap325rxa_setup(char **cmdline_p)
 	ctrl_outw(ctrl_inw(PORT_PSELD) & ~0x0003, PORT_PSELD);
 	ctrl_outw((ctrl_inw(PORT_PZCR) & ~0xff00) | 0x5500, PORT_PZCR);
 	ctrl_outb((ctrl_inb(PORT_PZDR) & ~0xf0) | 0x20, PORT_PZDR);
+
+	/* FLCTL */
+	ctrl_outw(0, PORT_PUCR);
+	ctrl_outw(0, PORT_PVCR);
+	ctrl_outw(0, PORT_PSELC);
+	ctrl_outw(0, PORT_HIZCRC);
+	ctrl_outw(0xFFFF, PORT_DRVCRA);
+	ctrl_outw(0xFFFF, PORT_DRVCRB);
+	ctrl_outw((ctrl_inw(PORT_PXCR) & 0x3fff) | 0x4000, PORT_PXCR);
+	ctrl_outb(0x80, PORT_PXDR);
 }

 static struct sh_machine_vector mv_ap325rxa __initmv = {
-- 
1.5.5


