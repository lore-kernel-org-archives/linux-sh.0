From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Jan 2008 07:21:18 +0000
Subject: [PATCH] sh: add spi header and r2d platform data V3
Message-Id: <20080123072118.8931.688.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080121102401.28997.63940.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080121102401.28997.63940.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: add spi header and r2d platform data V3

This patch adds the header file asm/spi.h and board specific code for the
r2d board. The header file contains a structure that should be used to
point out a single spi bus. The board specific code for r2d is updated with
such a structure for the new spi_sh_sci driver. The structure contains a
chip select callback plus information about the R9701 rtc chip which is
attached to the spi bus.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes since V2 include:
 - Moved spi_register_board_info() to rts7751r2d_devices_setup().
 - Removed silly comparison in r2d_chip_select().

 arch/sh/boards/renesas/rts7751r2d/setup.c |   42 +++++++++++++++++++++++++++++
 include/asm-sh/spi.h                      |   13 ++++++++
 2 files changed, 55 insertions(+)

--- 0001/arch/sh/boards/renesas/rts7751r2d/setup.c
+++ work/arch/sh/boards/renesas/rts7751r2d/setup.c	2008-01-23 16:00:49.000000000 +0900
@@ -16,9 +16,12 @@
 #include <linux/sm501-regs.h>
 #include <linux/pm.h>
 #include <linux/fb.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
 #include <asm/machvec.h>
 #include <asm/rts7751r2d.h>
 #include <asm/io.h>
+#include <asm/spi.h>
 
 static struct resource cf_ide_resources[] = {
 	[0] = {
@@ -53,6 +56,43 @@ static struct platform_device cf_ide_dev
 	},
 };
 
+static struct spi_board_info spi_bus[] = {
+	{
+		.modalias	= "rtc-r9701",
+		.max_speed_hz	= 1000000,
+		.mode		= SPI_MODE_3,
+	},
+};
+
+static void r2d_chip_select(struct sh_spi_info *spi, int cs, int state)
+{
+	BUG_ON(cs != 0);  /* Single Epson RTC-9701JE attached on CS0 */
+	ctrl_outw(state = BITBANG_CS_ACTIVE, PA_RTCCE);
+}
+
+static struct sh_spi_info spi_info = {
+	.num_chipselect = 1,
+	.chip_select = r2d_chip_select,
+};
+
+static struct resource spi_sh_sci_resources[] = {
+	{
+		.start	= 0xffe00000,
+		.end	= 0xffe0001f,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device spi_sh_sci_device  = {
+	.name		= "spi_sh_sci",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(spi_sh_sci_resources),
+	.resource	= spi_sh_sci_resources,
+	.dev	= {
+		.platform_data	= &spi_info,
+	},
+};
+
 static struct resource heartbeat_resources[] = {
 	[0] = {
 		.start	= PA_OUTPORT,
@@ -176,10 +216,12 @@ static struct platform_device *rts7751r2
 #endif
 	&cf_ide_device,
 	&heartbeat_device,
+	&spi_sh_sci_device,
 };
 
 static int __init rts7751r2d_devices_setup(void)
 {
+	spi_register_board_info(spi_bus, ARRAY_SIZE(spi_bus));
 	return platform_add_devices(rts7751r2d_devices,
 				    ARRAY_SIZE(rts7751r2d_devices));
 }
--- /dev/null
+++ work/include/asm-sh/spi.h	2008-01-23 12:38:38.000000000 +0900
@@ -0,0 +1,13 @@
+#ifndef __ASM_SPI_H__
+#define __ASM_SPI_H__
+
+struct sh_spi_info;
+
+struct sh_spi_info {
+	int			 bus_num;
+	int			 num_chipselect;
+
+	void (*chip_select)(struct sh_spi_info *spi, int cs, int state);
+};
+
+#endif /* __ASM_SPI_H__ */
