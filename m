From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Aug 2009 14:51:30 +0000
Subject: [PATCH] sh: kfr2r09 board support - LCDC panel
Message-Id: <20090806145130.4409.69037.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds support for the WQVGA LCD display used by
the KFR2R09 board. The LCD module is a TX07D34VM0AAA made
by Hitachi, and this module is made up by a R61517 chip
together with a 240x400 pixel display. The screen is
attached to the SuperH Mobile LCDC using a 18-bit SYS bus.

The register settings used by the SYS panel setup code are
based on an out-of-tree driver which apart from duplicating
all LCDC driver code and writing to non-existing hardware
registers also never was posted for upstream merge.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-kfr2r09/Makefile        |    1 
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c     |  332 +++++++++++++++++++++++++++
 arch/sh/boards/mach-kfr2r09/setup.c         |   94 +++++++
 arch/sh/include/mach-kfr2r09/mach/kfr2r09.h |   21 +
 4 files changed, 448 insertions(+)

--- 0001/arch/sh/boards/mach-kfr2r09/Makefile
+++ work/arch/sh/boards/mach-kfr2r09/Makefile	2009-08-06 21:33:53.000000000 +0900
@@ -1 +1,2 @@
 obj-y	 := setup.o
+obj-$(CONFIG_FB_SH_MOBILE_LCDC)	+=  lcd_wqvga.o
--- /dev/null
+++ work/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c	2009-08-06 21:33:53.000000000 +0900
@@ -0,0 +1,332 @@
+/*
+ * KFR2R09 LCD panel support
+ *
+ * Copyright (C) 2009 Magnus Damm
+ *
+ * Register settings based on the out-of-tree t33fb.c driver
+ * Copyright (C) 2008 Lineo Solutions, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <video/sh_mobile_lcdc.h>
+#include <mach/kfr2r09.h>
+#include <cpu/sh7724.h>
+
+/* The on-board LCD module is a Hitachi TX07D34VM0AAA. This module is made
+ * up of a 240x400 LCD hooked up to a R61517 driver IC. The driver IC is
+ * communicating with the main port of the LCDC using an 18-bit SYS interface.
+ *
+ * The device code for this LCD module is 0x01221517.
+ */
+
+static const unsigned char data_frame_if[] = {
+	0x02, /* WEMODE: 1=cont, 0=one-shot */
+	0x00, 0x00,
+	0x00, /* EPF, DFM */
+	0x02, /* RIM[1] : 1 (18bpp) */
+};
+
+static const unsigned char data_panel[] = {
+	0x0b,
+	0x63, /* 400 lines */
+	0x04, 0x00, 0x00, 0x04, 0x11, 0x00, 0x00,
+};
+
+static const unsigned char data_timing[] = {
+	0x00, 0x00, 0x13, 0x08, 0x08,
+};
+
+static const unsigned char data_timing_src[] = {
+	0x11, 0x01, 0x00, 0x01,
+};
+
+static const unsigned char data_gamma[] = {
+	0x01, 0x02, 0x08, 0x23,	0x03, 0x0c, 0x00, 0x06,	0x00, 0x00,
+	0x01, 0x00, 0x0c, 0x23, 0x03, 0x08, 0x02, 0x06, 0x00, 0x00,
+};
+
+static const unsigned char data_power[] = {
+	0x07, 0xc5, 0xdc, 0x02,	0x33, 0x0a,
+};
+
+static unsigned long read_reg(void *sohandle,
+			      struct sh_mobile_lcdc_sys_bus_ops *so)
+{
+	return so->read_data(sohandle);
+}
+
+static void write_reg(void *sohandle,
+		      struct sh_mobile_lcdc_sys_bus_ops *so,
+		      int i, unsigned long v)
+{
+	if (i)
+		so->write_data(sohandle, v); /* PTH4/LCDRS High [param, 17:0] */
+	else
+		so->write_index(sohandle, v); /* PTH4/LCDRS Low [cmd, 7:0] */
+}
+
+static void write_data(void *sohandle,
+		       struct sh_mobile_lcdc_sys_bus_ops *so,
+		       unsigned char const *data, int no_data)
+{
+	int i;
+
+	for (i = 0; i < no_data; i++)
+		write_reg(sohandle, so, 1, data[i]);
+}
+
+static unsigned long read_device_code(void *sohandle,
+				      struct sh_mobile_lcdc_sys_bus_ops *so)
+{
+	unsigned long device_code;
+
+	/* access protect OFF */
+	write_reg(sohandle, so, 0, 0xb0);
+	write_reg(sohandle, so, 1, 0x00);
+
+	/* deep standby OFF */
+	write_reg(sohandle, so, 0, 0xb1);
+	write_reg(sohandle, so, 1, 0x00);
+
+	/* device code command */
+	write_reg(sohandle, so, 0, 0xbf);
+	mdelay(50);
+
+	/* dummy read */
+	read_reg(sohandle, so);
+
+	/* read device code */
+	device_code = ((read_reg(sohandle, so) & 0xff) << 24);
+	device_code |= ((read_reg(sohandle, so) & 0xff) << 16);
+	device_code |= ((read_reg(sohandle, so) & 0xff) << 8);
+	device_code |= (read_reg(sohandle, so) & 0xff);
+
+	return device_code;
+}
+
+static void write_memory_start(void *sohandle,
+			       struct sh_mobile_lcdc_sys_bus_ops *so)
+{
+	write_reg(sohandle, so, 0, 0x2c);
+}
+
+static void clear_memory(void *sohandle,
+			 struct sh_mobile_lcdc_sys_bus_ops *so)
+{
+	int i;
+
+	/* write start */
+	write_memory_start(sohandle, so);
+
+	/* paint it black */
+	for (i = 0; i < (240 * 400); i++)
+		write_reg(sohandle, so, 1, 0x00);
+}
+
+static void display_on(void *sohandle,
+		       struct sh_mobile_lcdc_sys_bus_ops *so)
+{
+	/* access protect off */
+	write_reg(sohandle, so, 0, 0xb0);
+	write_reg(sohandle, so, 1, 0x00);
+
+	/* exit deep standby mode */
+	write_reg(sohandle, so, 0, 0xb1);
+	write_reg(sohandle, so, 1, 0x00);
+
+	/* frame memory I/F */
+	write_reg(sohandle, so, 0, 0xb3);
+	write_data(sohandle, so, data_frame_if, ARRAY_SIZE(data_frame_if));
+
+	/* display mode and frame memory write mode */
+	write_reg(sohandle, so, 0, 0xb4);
+	write_reg(sohandle, so, 1, 0x00); /* DBI, internal clock */
+
+	/* panel */
+	write_reg(sohandle, so, 0, 0xc0);
+	write_data(sohandle, so, data_panel, ARRAY_SIZE(data_panel));
+
+	/* timing (normal) */
+	write_reg(sohandle, so, 0, 0xc1);
+	write_data(sohandle, so, data_timing, ARRAY_SIZE(data_timing));
+
+	/* timing (partial) */
+	write_reg(sohandle, so, 0, 0xc2);
+	write_data(sohandle, so, data_timing, ARRAY_SIZE(data_timing));
+
+	/* timing (idle) */
+	write_reg(sohandle, so, 0, 0xc3);
+	write_data(sohandle, so, data_timing, ARRAY_SIZE(data_timing));
+
+	/* timing (source/VCOM/gate driving) */
+	write_reg(sohandle, so, 0, 0xc4);
+	write_data(sohandle, so, data_timing_src, ARRAY_SIZE(data_timing_src));
+
+	/* gamma (red) */
+	write_reg(sohandle, so, 0, 0xc8);
+	write_data(sohandle, so, data_gamma, ARRAY_SIZE(data_gamma));
+
+	/* gamma (green) */
+	write_reg(sohandle, so, 0, 0xc9);
+	write_data(sohandle, so, data_gamma, ARRAY_SIZE(data_gamma));
+
+	/* gamma (blue) */
+	write_reg(sohandle, so, 0, 0xca);
+	write_data(sohandle, so, data_gamma, ARRAY_SIZE(data_gamma));
+
+	/* power (common) */
+	write_reg(sohandle, so, 0, 0xd0);
+	write_data(sohandle, so, data_power, ARRAY_SIZE(data_power));
+
+	/* VCOM */
+	write_reg(sohandle, so, 0, 0xd1);
+	write_reg(sohandle, so, 1, 0x00);
+	write_reg(sohandle, so, 1, 0x0f);
+	write_reg(sohandle, so, 1, 0x02);
+
+	/* power (normal) */
+	write_reg(sohandle, so, 0, 0xd2);
+	write_reg(sohandle, so, 1, 0x63);
+	write_reg(sohandle, so, 1, 0x24);
+
+	/* power (partial) */
+	write_reg(sohandle, so, 0, 0xd3);
+	write_reg(sohandle, so, 1, 0x63);
+	write_reg(sohandle, so, 1, 0x24);
+
+	/* power (idle) */
+	write_reg(sohandle, so, 0, 0xd4);
+	write_reg(sohandle, so, 1, 0x63);
+	write_reg(sohandle, so, 1, 0x24);
+
+	write_reg(sohandle, so, 0, 0xd8);
+	write_reg(sohandle, so, 1, 0x77);
+	write_reg(sohandle, so, 1, 0x77);
+
+	/* TE signal */
+	write_reg(sohandle, so, 0, 0x35);
+	write_reg(sohandle, so, 1, 0x00);
+
+	/* TE signal line */
+	write_reg(sohandle, so, 0, 0x44);
+	write_reg(sohandle, so, 1, 0x00);
+	write_reg(sohandle, so, 1, 0x00);
+
+	/* column address */
+	write_reg(sohandle, so, 0, 0x2a);
+	write_reg(sohandle, so, 1, 0x00);
+	write_reg(sohandle, so, 1, 0x00);
+	write_reg(sohandle, so, 1, 0x00);
+	write_reg(sohandle, so, 1, 0xef);
+
+	/* page address */
+	write_reg(sohandle, so, 0, 0x2b);
+	write_reg(sohandle, so, 1, 0x00);
+	write_reg(sohandle, so, 1, 0x00);
+	write_reg(sohandle, so, 1, 0x01);
+	write_reg(sohandle, so, 1, 0x8f);
+
+	/* exit sleep mode */
+	write_reg(sohandle, so, 0, 0x11);
+
+	mdelay(120);
+
+	/* clear vram */
+	clear_memory(sohandle, so);
+
+	/* display ON */
+	write_reg(sohandle, so, 0, 0x29);
+	mdelay(1);
+
+	write_memory_start(sohandle, so);
+}
+
+int kfr2r09_lcd_setup(void *board_data, void *sohandle,
+		      struct sh_mobile_lcdc_sys_bus_ops *so)
+{
+	/* power on */
+	gpio_set_value(GPIO_PTF4, 0);  /* PROTECT/ -> L */
+	gpio_set_value(GPIO_PTE4, 0);  /* LCD_RST/ -> L */
+	gpio_set_value(GPIO_PTF4, 1);  /* PROTECT/ -> H */
+	udelay(1100);
+	gpio_set_value(GPIO_PTE4, 1);  /* LCD_RST/ -> H */
+	udelay(10);
+	gpio_set_value(GPIO_PTF4, 0);  /* PROTECT/ -> L */
+	mdelay(20);
+
+	if (read_device_code(sohandle, so) != 0x01221517)
+		return -ENODEV;
+
+	pr_info("KFR2R09 WQVGA LCD Module detected.\n");
+
+	display_on(sohandle, so);
+	return 0;
+}
+
+#define CTRL_CKSW       0x10
+#define CTRL_C10        0x20
+#define CTRL_CPSW       0x80
+#define MAIN_MLED4      0x40
+#define MAIN_MSW        0x80
+
+static int kfr2r09_lcd_backlight(int on)
+{
+	struct i2c_adapter *a;
+	struct i2c_msg msg;
+	unsigned char buf[2];
+	int ret;
+
+	a = i2c_get_adapter(0);
+	if (!a)
+		return -ENODEV;
+
+	buf[0] = 0x00;
+	if (on)
+		buf[1] = CTRL_CPSW | CTRL_C10 | CTRL_CKSW;
+	else
+		buf[1] = 0;
+
+	msg.addr = 0x75;
+	msg.buf = buf;
+	msg.len = 2;
+	msg.flags = 0;
+	ret = i2c_transfer(a, &msg, 1);
+	if (ret != 1)
+		return -ENODEV;
+
+	buf[0] = 0x01;
+	if (on)
+		buf[1] = MAIN_MSW | MAIN_MLED4 | 0x0c;
+	else
+		buf[1] = 0;
+
+	msg.addr = 0x75;
+	msg.buf = buf;
+	msg.len = 2;
+	msg.flags = 0;
+	ret = i2c_transfer(a, &msg, 1);
+	if (ret != 1)
+		return -ENODEV;
+
+	return 0;
+}
+
+void kfr2r09_lcd_on(void *board_data)
+{
+	kfr2r09_lcd_backlight(1);
+}
+
+void kfr2r09_lcd_off(void *board_data)
+{
+	kfr2r09_lcd_backlight(0);
+}
--- 0001/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-08-06 21:33:53.000000000 +0900
@@ -15,11 +15,13 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
+#include <video/sh_mobile_lcdc.h>
 #include <asm/clock.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
 #include <asm/sh_keysc.h>
 #include <cpu/sh7724.h>
+#include <mach/kfr2r09.h>
 
 static struct mtd_partition kfr2r09_nor_flash_partitions[]  {
@@ -97,9 +99,70 @@ static struct platform_device kfr2r09_sh
 	},
 };
 
+static struct sh_mobile_lcdc_info kfr2r09_sh_lcdc_info = {
+	.clock_source = LCDC_CLK_BUS,
+	.ch[0] = {
+		.chan = LCDC_CHAN_MAINLCD,
+		.bpp = 16,
+		.interface_type = SYS18,
+		.clock_divider = 6,
+		.flags = LCDC_FLAGS_DWPOL,
+		.lcd_cfg = {
+			.name = "TX07D34VM0AAA",
+			.xres = 240,
+			.yres = 400,
+			.left_margin = 0,
+			.right_margin = 16,
+			.hsync_len = 8,
+			.upper_margin = 0,
+			.lower_margin = 1,
+			.vsync_len = 1,
+			.sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		},
+		.lcd_size_cfg = {
+			.width = 35,
+			.height = 58,
+		},
+		.board_cfg = {
+			.setup_sys = kfr2r09_lcd_setup,
+			.display_on = kfr2r09_lcd_on,
+			.display_off = kfr2r09_lcd_off,
+		},
+		.sys_bus_cfg = {
+			.ldmt2r = 0x07010904,
+			.ldmt3r = 0x14012914,
+			/* set 1s delay to encourage fsync() */
+			.deferred_io_msec = 1000,
+		},
+	}
+};
+
+static struct resource kfr2r09_sh_lcdc_resources[] = {
+	[0] = {
+		.name	= "LCDC",
+		.start	= 0xfe940000, /* P4-only space */
+		.end	= 0xfe941fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 106,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device kfr2r09_sh_lcdc_device = {
+	.name		= "sh_mobile_lcdc_fb",
+	.num_resources	= ARRAY_SIZE(kfr2r09_sh_lcdc_resources),
+	.resource	= kfr2r09_sh_lcdc_resources,
+	.dev	= {
+		.platform_data	= &kfr2r09_sh_lcdc_info,
+	},
+};
+
 static struct platform_device *kfr2r09_devices[] __initdata = {
 	&kfr2r09_nor_flash_device,
 	&kfr2r09_sh_keysc_device,
+	&kfr2r09_sh_lcdc_device,
 };
 
 #define BSC_CS0BCR 0xfec10004
@@ -128,6 +191,37 @@ static int __init kfr2r09_devices_setup(
 	gpio_request(GPIO_FN_KEYIN4, NULL);
 	gpio_request(GPIO_FN_KEYOUT5_IN5, NULL);
 
+	/* setup LCDC pins for SYS panel */
+	gpio_request(GPIO_FN_LCDD17, NULL);
+	gpio_request(GPIO_FN_LCDD16, NULL);
+	gpio_request(GPIO_FN_LCDD15, NULL);
+	gpio_request(GPIO_FN_LCDD14, NULL);
+	gpio_request(GPIO_FN_LCDD13, NULL);
+	gpio_request(GPIO_FN_LCDD12, NULL);
+	gpio_request(GPIO_FN_LCDD11, NULL);
+	gpio_request(GPIO_FN_LCDD10, NULL);
+	gpio_request(GPIO_FN_LCDD9, NULL);
+	gpio_request(GPIO_FN_LCDD8, NULL);
+	gpio_request(GPIO_FN_LCDD7, NULL);
+	gpio_request(GPIO_FN_LCDD6, NULL);
+	gpio_request(GPIO_FN_LCDD5, NULL);
+	gpio_request(GPIO_FN_LCDD4, NULL);
+	gpio_request(GPIO_FN_LCDD3, NULL);
+	gpio_request(GPIO_FN_LCDD2, NULL);
+	gpio_request(GPIO_FN_LCDD1, NULL);
+	gpio_request(GPIO_FN_LCDD0, NULL);
+	gpio_request(GPIO_FN_LCDRS, NULL); /* LCD_RS */
+	gpio_request(GPIO_FN_LCDCS, NULL); /* LCD_CS/ */
+	gpio_request(GPIO_FN_LCDRD, NULL); /* LCD_RD/ */
+	gpio_request(GPIO_FN_LCDWR, NULL); /* LCD_WR/ */
+	gpio_request(GPIO_FN_LCDVSYN, NULL); /* LCD_VSYNC */
+	gpio_request(GPIO_PTE4, NULL); /* LCD_RST/ */
+	gpio_direction_output(GPIO_PTE4, 1);
+	gpio_request(GPIO_PTF4, NULL); /* PROTECT/ */
+	gpio_direction_output(GPIO_PTF4, 1);
+	gpio_request(GPIO_PTU0, NULL); /* LEDSTDBY/ */
+	gpio_direction_output(GPIO_PTU0, 1);
+
 	return platform_add_devices(kfr2r09_devices,
 				    ARRAY_SIZE(kfr2r09_devices));
 }
--- /dev/null
+++ work/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h	2009-08-06 21:33:53.000000000 +0900
@@ -0,0 +1,21 @@
+#ifndef __ASM_SH_KFR2R09_H
+#define __ASM_SH_KFR2R09_H
+
+#include <video/sh_mobile_lcdc.h>
+
+#ifdef CONFIG_FB_SH_MOBILE_LCDC
+void kfr2r09_lcd_on(void *board_data);
+void kfr2r09_lcd_off(void *board_data);
+int kfr2r09_lcd_setup(void *board_data, void *sys_ops_handle,
+		      struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
+#else
+static inline void kfr2r09_lcd_on(void *board_data) {}
+static inline void kfr2r09_lcd_off(void *board_data) {}
+static inline int kfr2r09_lcd_setup(void *board_data, void *sys_ops_handle,
+				    struct sh_mobile_lcdc_sys_bus_ops *sys_ops)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* __ASM_SH_KFR2R09_H */
