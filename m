From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 28 Jul 2008 09:47:30 +0000
Subject: [PATCH] sh: Add SuperH Mobile LCDC platform data for Migo-R
Message-Id: <20080728094730.4239.83716.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add WVGA and QVGA LCD panel support to Migo-R.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                         |    1 
 arch/sh/boards/renesas/migor/Kconfig    |   15 ++
 arch/sh/boards/renesas/migor/Makefile   |    1 
 arch/sh/boards/renesas/migor/lcd_qvga.c |  165 +++++++++++++++++++++++++++++++
 arch/sh/boards/renesas/migor/setup.c    |   96 ++++++++++++++++++
 include/asm-sh/migor.h                  |    6 +
 6 files changed, 284 insertions(+)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-07-28 12:20:25.000000000 +0900
@@ -591,6 +591,7 @@ endmenu
 source "arch/sh/boards/renesas/rts7751r2d/Kconfig"
 source "arch/sh/boards/renesas/r7780rp/Kconfig"
 source "arch/sh/boards/renesas/sdk7780/Kconfig"
+source "arch/sh/boards/renesas/migor/Kconfig"
 source "arch/sh/boards/magicpanelr2/Kconfig"
 
 menu "Timer and clock configuration"
--- /dev/null
+++ work/arch/sh/boards/renesas/migor/Kconfig	2008-07-28 12:20:25.000000000 +0900
@@ -0,0 +1,15 @@
+if SH_MIGOR
+
+choice
+	prompt "Migo-R LCD Panel Board Selection"
+	default SH_MIGOR_QVGA
+
+config SH_MIGOR_QVGA
+	bool "QVGA (320x240)"
+
+config SH_MIGOR_RTA_WVGA
+	bool "RTA WVGA (800x480)"
+
+endchoice
+
+endif
--- 0001/arch/sh/boards/renesas/migor/Makefile
+++ work/arch/sh/boards/renesas/migor/Makefile	2008-07-28 12:23:13.000000000 +0900
@@ -1 +1,2 @@
 obj-y	 := setup.o
+obj-$(CONFIG_SH_MIGOR_QVGA)	+=  lcd_qvga.o
--- /dev/null
+++ work/arch/sh/boards/renesas/migor/lcd_qvga.c	2008-07-28 12:20:25.000000000 +0900
@@ -0,0 +1,165 @@
+/*
+ * Support for SuperH MigoR Quarter VGA LCD Panel
+ *
+ * Copyright (C) 2008 Magnus Damm
+ *
+ * Based on lcd_powertip.c from Kenati Technologies Pvt Ltd.
+ * Copyright (c) 2007 Ujjwal Pande <ujjwal@kenati.com>,
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <asm/sh_mobile_lcdc.h>
+#include <asm/migor.h>
+
+/* LCD Module is a PH240320T according to board schematics. This module
+ * is made up of a 240x320 LCD hooked up to a R61505U (or HX8347-A01?)
+ * Driver IC. This IC is connected to the SH7722 built-in LCDC using a
+ * SYS-80 interface configured in 16 bit mode.
+ *
+ * Index 0: "Device Code Read" returns 0x1505.
+ */
+
+static void reset_lcd_module(void)
+{
+	ctrl_outb(ctrl_inb(PORT_PHDR) & ~0x04, PORT_PHDR);
+	mdelay(2);
+	ctrl_outb(ctrl_inb(PORT_PHDR) | 0x04, PORT_PHDR);
+	mdelay(1);
+}
+
+/* DB0-DB7 are connected to D1-D8, and DB8-DB15 to D10-D17 */
+
+static unsigned long adjust_reg18(unsigned short data)
+{
+	unsigned long tmp1, tmp2;
+
+	tmp1 = (data<<1 | 0x00000001) & 0x000001FF;
+	tmp2 = (data<<2 | 0x00000200) & 0x0003FE00;
+	return tmp1 | tmp2;
+}
+
+static void write_reg(void *sys_ops_handle,
+		       struct sh_mobile_lcdc_sys_bus_ops *sys_ops,
+		       unsigned short reg, unsigned short data)
+{
+	sys_ops->write_index(sys_ops_handle, adjust_reg18(reg << 8 | data));
+}
+
+static void write_reg16(void *sys_ops_handle,
+			struct sh_mobile_lcdc_sys_bus_ops *sys_ops,
+			unsigned short reg, unsigned short data)
+{
+	sys_ops->write_index(sys_ops_handle, adjust_reg18(reg));
+	sys_ops->write_data(sys_ops_handle, adjust_reg18(data));
+}
+
+static unsigned long read_reg16(void *sys_ops_handle,
+				struct sh_mobile_lcdc_sys_bus_ops *sys_ops,
+				unsigned short reg)
+{
+	unsigned long data;
+
+	sys_ops->write_index(sys_ops_handle, adjust_reg18(reg));
+	data = sys_ops->read_data(sys_ops_handle);
+	return ((data >> 1) & 0xff) | ((data >> 2) & 0xff00);
+}
+
+static void migor_lcd_qvga_seq(void *sys_ops_handle,
+			       struct sh_mobile_lcdc_sys_bus_ops *sys_ops,
+			       unsigned short const *data, int no_data)
+{
+	int i;
+
+	for (i = 0; i < no_data; i += 2)
+		write_reg16(sys_ops_handle, sys_ops, data[i], data[i + 1]);
+}
+
+static const unsigned short sync_data[] = {
+	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+};
+
+static const unsigned short magic0_data[] = {
+	0x0060, 0x2700, 0x0008, 0x0808, 0x0090, 0x001A, 0x0007, 0x0001,
+	0x0017, 0x0001, 0x0019, 0x0000, 0x0010, 0x17B0, 0x0011, 0x0116,
+	0x0012, 0x0198, 0x0013, 0x1400, 0x0029, 0x000C, 0x0012, 0x01B8,
+};
+
+static const unsigned short magic1_data[] = {
+	0x0030, 0x0307, 0x0031, 0x0303, 0x0032, 0x0603, 0x0033, 0x0202,
+	0x0034, 0x0202, 0x0035, 0x0202, 0x0036, 0x1F1F, 0x0037, 0x0303,
+	0x0038, 0x0303, 0x0039, 0x0603, 0x003A, 0x0202, 0x003B, 0x0102,
+	0x003C, 0x0204, 0x003D, 0x0000, 0x0001, 0x0100, 0x0002, 0x0300,
+	0x0003, 0x5028, 0x0020, 0x00ef, 0x0021, 0x0000, 0x0004, 0x0000,
+	0x0009, 0x0000, 0x000A, 0x0008, 0x000C, 0x0000, 0x000D, 0x0000,
+	0x0015, 0x8000,
+};
+
+static const unsigned short magic2_data[] = {
+	0x0061, 0x0001, 0x0092, 0x0100, 0x0093, 0x0001, 0x0007, 0x0021,
+};
+
+static const unsigned short magic3_data[] = {
+	0x0010, 0x16B0, 0x0011, 0x0111, 0x0007, 0x0061,
+};
+
+int migor_lcd_qvga_setup(void *board_data, void *sohandle,
+			 struct sh_mobile_lcdc_sys_bus_ops *so)
+{
+	unsigned long xres = 320;
+	unsigned long yres = 240;
+	int k;
+
+	reset_lcd_module();
+	migor_lcd_qvga_seq(sohandle, so, sync_data, ARRAY_SIZE(sync_data));
+
+	if (read_reg16(sohandle, so, 0) != 0x1505)
+		return -ENODEV;
+
+	pr_info("Migo-R QVGA LCD Module detected.\n");
+
+	migor_lcd_qvga_seq(sohandle, so, sync_data, ARRAY_SIZE(sync_data));
+	write_reg16(sohandle, so, 0x00A4, 0x0001);
+	mdelay(10);
+
+	migor_lcd_qvga_seq(sohandle, so, magic0_data, ARRAY_SIZE(magic0_data));
+	mdelay(100);
+
+	migor_lcd_qvga_seq(sohandle, so, magic1_data, ARRAY_SIZE(magic1_data));
+	write_reg16(sohandle, so, 0x0050, 0xef - (yres - 1));
+	write_reg16(sohandle, so, 0x0051, 0x00ef);
+	write_reg16(sohandle, so, 0x0052, 0x0000);
+	write_reg16(sohandle, so, 0x0053, xres - 1);
+
+	migor_lcd_qvga_seq(sohandle, so, magic2_data, ARRAY_SIZE(magic2_data));
+	mdelay(10);
+
+	migor_lcd_qvga_seq(sohandle, so, magic3_data, ARRAY_SIZE(magic3_data));
+	mdelay(40);
+
+	/* clear GRAM to avoid displaying garbage */
+
+	write_reg16(sohandle, so, 0x0020, 0x0000); /* horiz addr */
+	write_reg16(sohandle, so, 0x0021, 0x0000); /* vert addr */
+
+	for (k = 0; k < (xres * 256); k++) /* yes, 256 words per line */
+		write_reg16(sohandle, so, 0x0022, 0x0000);
+
+	write_reg16(sohandle, so, 0x0020, 0x0000); /* reset horiz addr */
+	write_reg16(sohandle, so, 0x0021, 0x0000); /* reset vert addr */
+	write_reg16(sohandle, so, 0x0007, 0x0173);
+	mdelay(40);
+
+	/* enable display */
+	write_reg(sohandle, so, 0x00, 0x22);
+	mdelay(100);
+	return 0;
+}
--- 0001/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-07-28 12:20:25.000000000 +0900
@@ -19,6 +19,7 @@
 #include <asm/machvec.h>
 #include <asm/io.h>
 #include <asm/sh_keysc.h>
+#include <asm/sh_mobile_lcdc.h>
 #include <asm/migor.h>
 
 /* Address     IRQ  Size  Bus  Description
@@ -199,9 +200,80 @@ static struct platform_device migor_nand
 	}
 };
 
+static struct sh_mobile_lcdc_info sh_mobile_lcdc_info = {
+#ifdef CONFIG_SH_MIGOR_RTA_WVGA
+	.clock_source = LCDC_CLK_BUS,
+	.ch[0] = {
+		.chan = LCDC_CHAN_MAINLCD,
+		.bpp = 16,
+		.interface_type = RGB16,
+		.clock_divider = 2,
+		.lcd_cfg = {
+			.name = "LB070WV1",
+			.xres = 800,
+			.yres = 480,
+			.left_margin = 64,
+			.right_margin = 16,
+			.hsync_len = 120,
+			.upper_margin = 1,
+			.lower_margin = 17,
+			.vsync_len = 2,
+			.sync = 0,
+		},
+	}
+#endif
+#ifdef CONFIG_SH_MIGOR_QVGA
+	.clock_source = LCDC_CLK_PERIPHERAL,
+	.ch[0] = {
+		.chan = LCDC_CHAN_MAINLCD,
+		.bpp = 16,
+		.interface_type = SYS16A,
+		.clock_divider = 10,
+		.lcd_cfg = {
+			.name = "PH240320T",
+			.xres = 320,
+			.yres = 240,
+			.left_margin = 0,
+			.right_margin = 16,
+			.hsync_len = 8,
+			.upper_margin = 1,
+			.lower_margin = 17,
+			.vsync_len = 2,
+			.sync = FB_SYNC_HOR_HIGH_ACT,
+		},
+		.board_cfg = {
+			.setup_sys = migor_lcd_qvga_setup,
+		},
+		.sys_bus_cfg = {
+			.ldmt2r = 0x06000a09,
+			.ldmt3r = 0x180e3418,
+		},
+	}
+#endif
+};
+
+static struct resource migor_lcdc_resources[] = {
+	[0] = {
+		.name	= "LCDC",
+		.start	= 0xfe940000, /* P4-only space */
+		.end	= 0xfe941fff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device migor_lcdc_device = {
+	.name		= "sh_mobile_lcdc_fb",
+	.num_resources	= ARRAY_SIZE(migor_lcdc_resources),
+	.resource	= migor_lcdc_resources,
+	.dev	= {
+		.platform_data	= &sh_mobile_lcdc_info,
+	},
+};
+
 static struct platform_device *migor_devices[] __initdata = {
 	&smc91x_eth_device,
 	&sh_keysc_device,
+	&migor_lcdc_device,
 	&migor_nor_flash_device,
 	&migor_nand_flash_device,
 };
@@ -219,6 +291,7 @@ static struct i2c_board_info __initdata 
 static int __init migor_devices_setup(void)
 {
 	clk_always_enable("mstp214"); /* KEYSC */
+	clk_always_enable("mstp200"); /* LCDC */
 
 	i2c_register_board_info(0, migor_i2c_devices,
 				ARRAY_SIZE(migor_i2c_devices));
@@ -248,6 +321,29 @@ static void __init migor_setup(char **cm
 	ctrl_outw(ctrl_inw(PORT_PZCR) & ~0xc, PORT_PZCR);
 	ctrl_outw((ctrl_inw(PORT_PSELA) | 0x8000), PORT_PSELA);
 	ctrl_outw((ctrl_inw(PORT_HIZCRC) & ~0x4000), PORT_HIZCRC);
+
+#ifdef CONFIG_SH_MIGOR_RTA_WVGA
+	/* LCDC - WVGA - Enable RGB Interface signals */
+	ctrl_outw(ctrl_inw(PORT_PACR) & ~0x0003, PORT_PACR);
+	ctrl_outw(0x0000, PORT_PHCR);
+	ctrl_outw(0x0000, PORT_PLCR);
+	ctrl_outw(0x0000, PORT_PMCR);
+	ctrl_outw(ctrl_inw(PORT_PRCR) & ~0x000f, PORT_PRCR);
+	ctrl_outw((ctrl_inw(PORT_PSELD) & ~0x000d) | 0x0400, PORT_PSELD);
+	ctrl_outw(ctrl_inw(PORT_MSELCRB) & ~0x0100, PORT_MSELCRB);
+	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x01e0, PORT_HIZCRA);
+#endif
+#ifdef CONFIG_SH_MIGOR_QVGA
+	/* LCDC - QVGA - Enable SYS Interface signals */
+	ctrl_outw(ctrl_inw(PORT_PACR) & ~0x0003, PORT_PACR);
+	ctrl_outw((ctrl_inw(PORT_PHCR) & ~0xcfff) | 0x0010, PORT_PHCR);
+	ctrl_outw(0x0000, PORT_PLCR);
+	ctrl_outw(0x0000, PORT_PMCR);
+	ctrl_outw(ctrl_inw(PORT_PRCR) & ~0x030f, PORT_PRCR);
+	ctrl_outw((ctrl_inw(PORT_PSELD) & ~0x0001) | 0x0420, PORT_PSELD);
+	ctrl_outw(ctrl_inw(PORT_MSELCRB) | 0x0100, PORT_MSELCRB);
+	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x01e0, PORT_HIZCRA);
+#endif
 }
 
 static struct sh_machine_vector mv_migor __initmv = {
--- 0001/include/asm-sh/migor.h
+++ work/include/asm-sh/migor.h	2008-07-28 12:20:25.000000000 +0900
@@ -30,6 +30,7 @@
 #define PORT_PYCR 0xa405014a
 #define PORT_PZCR 0xa405014c
 #define PORT_PADR 0xa4050120
+#define PORT_PHDR 0xa405012e
 #define PORT_PWDR 0xa4050166
 
 #define PORT_HIZCRA 0xa4050158
@@ -51,4 +52,9 @@
 
 #define BSC_CS6ABCR 0xfec1001c
 
+#include <asm/sh_mobile_lcdc.h>
+
+int migor_lcd_qvga_setup(void *board_data, void *sys_ops_handle,
+			 struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
+
 #endif /* __ASM_SH_MIGOR_H */
