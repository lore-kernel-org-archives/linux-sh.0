From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Jan 2008 04:53:56 +0000
Subject: [PATCH] sh: add spi header and r2d platform data V2
Message-Id: <20080123045356.23667.51309.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080121102401.28997.63940.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080121102401.28997.63940.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: add spi header and r2d platform data V2

This patch adds the header file asm/spi.h and board specific code for the
r2d board. The header file contains a structure that should be used to
point out a single spi bus. The board specific code for r2d is updated with
such a structure for the new spi_sh_sci driver. The structure contains a
chip select callback plus information about the R9701 rtc chip which is
attached to the spi bus.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes since V1 include:
 - Use spi_register_board_info() instead of struct sh_spi_info.
 - Set mode for r9701 in struct spi_board_info.

 arch/sh/boards/renesas/rts7751r2d/setup.c |   47 +++++++++++++++++++++++++++++
 include/asm-sh/spi.h                      |   13 ++++++++
 2 files changed, 60 insertions(+)

--- 0001/arch/sh/boards/renesas/rts7751r2d/setup.c
+++ work/arch/sh/boards/renesas/rts7751r2d/setup.c	2008-01-23 12:38:09.000000000 +0900
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
+	ctrl_outw(state = BITBANG_CS_ACTIVE ? 1 : 0, PA_RTCCE);
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
@@ -176,6 +216,7 @@ static struct platform_device *rts7751r2
 #endif
 	&cf_ide_device,
 	&heartbeat_device,
+	&spi_sh_sci_device,
 };
 
 static int __init rts7751r2d_devices_setup(void)
@@ -260,6 +301,12 @@ static void __init rts7751r2d_setup(char
 	writel(readl(sm501_reg) | (1 << SM501_GATE_UART0), sm501_reg);
 }
 
+static int __init r2d_register_spi(void)
+{
+	return spi_register_board_info(spi_bus, ARRAY_SIZE(spi_bus));
+}
+__initcall(r2d_register_spi);
+
 /*
  * The Machine Vector
  */
--- /dev/null
+++ work/include/asm-sh/spi.h	2008-01-23 12:34:33.000000000 +0900
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
