From: Dale <dlarson42@gmail.com>
Date: Sat, 01 May 2010 14:45:03 +0000
Subject: Re: Hi guys, does any of you have experience with touchscreen controllers?
Message-Id: <4BDC3E6F.7030003@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080909080505000108090306"
List-Id: <linux-sh.vger.kernel.org>
References: <201004222004.38724.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004222004.38724.fabio.giovagnini@aurion-tech.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------080909080505000108090306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fabio Giovagnini wrote:
> Hi Dale, 

Hi Fabio,

Sorry for the delay in responding. I was at the ESC conference this week.

> maybe I need to be more clear about my condition.
> 1) I connected the ads7843 to general I/O ports because the SPIs available on 
> sh2a7203 have been be used for other functions;
> 2) My real problem is the following: I wrote an ADS7843 device driver as a 
> button driver of the input subsystem. I configured the ads7843 with INT 

You wrote the driver? I just used the existing one in the 2.6.28.2 kernel.

> enabled; so when the touch is pressed I have a burst of IRQ. The IRQ handler 
> read the ads7843 and return to the input subsystem the abs values of the 
> touchscreen.

I seem to recall you need disable the interrupt upon #PENIRQ and allow the
polling code to do the job of determining the pen up event.

> The user program open the file /dev/input/event0 and with the select waits for 
> data; what I see is: during all the time I have a finger on the touch only IRQ 
> handler is exeuted and no action is done in the user program. I tried also 
> opening /dev/input/event0 with O_NONBLOCK flag but nothing changes.

The existing driver uses the event system. The easiest way to see what I did
is to unpack a 2.6.28.2 linux tarball and apply the patch I've attached to this post.

Dale Larson
Johnson Controls, Inc


--------------080909080505000108090306
Content-Type: text/plain;
 name="jcinap_linux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jcinap_linux.patch"

diff -ruN linux-2.6.28.2-orig/arch/sh/boards/board-jcinap7760.c linux-2.6.28.2/arch/sh/boards/board-jcinap7760.c
--- linux-2.6.28.2-orig/arch/sh/boards/board-jcinap7760.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.28.2/arch/sh/boards/board-jcinap7760.c	2009-05-02 09:52:58.000000000 -0500
@@ -0,0 +1,554 @@
+/*
+ * Johnson Controls NAP7760 (N40) Board Support
+ * (Based on Renesas Europe EDOSK7760 Board Support)
+ *
+ * Copyright (C) 2008 SPES Societa' Progettazione Elettronica e Software Ltd.
+ * Author: Luca Santini <luca.santini@spesonline.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/smc91x.h>
+#include <linux/interrupt.h>
+//#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/mtd/physmap.h>
+#include <linux/serial_8250.h>
+#include <linux/leds.h>
+#include <linux/i2c/pca953x.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
+#include <asm/spi.h>
+#include <asm/machvec.h>
+#include <asm/io.h>
+#include <asm/addrspace.h>
+#include <asm/delay.h>
+#include <asm/i2c-sh7760.h>
+#include <asm/sizes.h>
+#include <linux/fb.h>
+#include <asm/sh7760fb.h>
+
+#define SMC_IOADDR        0x10000300
+#define SMC_IRQ           2       /* IRL0# on JCI NAP */
+
+#define DUART_A_IOADDR    0x18000008
+#define DUART_A_IRQ       5       /* IRL2# on JCI NAP */
+
+#define DUART_B_IOADDR    0x18000000
+#define DUART_B_IRQ       8       /* IRL1# on JCI NAP */
+
+#define IPSELR  0xFE400034
+
+#define PBCR    0xFE400004
+#define PCCR    0xFE400008
+#define PDCR    0xFE40000C
+#define PECR    0xFE400010
+#define PFCR    0xFE400014
+#define PGCR    0xFE400018
+
+#define PBDR    0xFE400044
+#define PGDR    0xFE400058
+
+#define PTB5    0x20
+
+#define DMARSRA 0xFE090000
+#define DMARSRB 0xFE090004
+#define DMATCR0 0xFFA00008
+#define DMAOR   0xFFA00040
+
+#define BKLIGHT_MASK        0x20     /* Pin assigned to backlight */
+#define BKLIGHT_CTRL_MASK   0x0C00   /* Control bits for backlight pin */
+#define BKLIGHT_CTRL_VALUE  0x0400   /* Set pin to output mode */
+#define IPSELR_LCDC_MASK    0x0203
+
+/* NOR flash */
+static struct mtd_partition jcinap7760_nor_flash_partitions[] = {
+    {
+        .name = "bootloader",
+        .offset = 0,
+        .size = 512 * 1024,
+        .mask_flags = MTD_WRITEABLE,    /* Read-only */
+    }, {
+        .name = "turboboot",
+        .offset = MTDPART_OFS_APPEND,
+        .size = 6 * 256 * 1024,         /* Six more blocks for linux kernel */
+    }, {
+        .name = "linux",
+        .offset = MTDPART_OFS_APPEND,
+        .size = 4 * 1024 * 1024,        /* 4 MB for linux kernel */
+    }, {
+        .name = "jffs2",
+        .offset = MTDPART_OFS_APPEND,
+        .size = 110 * 1024 * 1024,      /* JFFS2 is 110MB for now */
+    }, {
+        .name = "tbparttbl",
+        .offset = MTDPART_OFS_APPEND,
+        .size = MTDPART_SIZ_FULL,
+        .mask_flags = MTD_WRITEABLE,    /* Read-only */
+    },
+};
+
+static struct physmap_flash_data jcinap7760_nor_flash_data = {
+    .width      = 4,
+    .parts      = jcinap7760_nor_flash_partitions,
+    .nr_parts   = ARRAY_SIZE(jcinap7760_nor_flash_partitions),
+};
+
+static struct resource jcinap7760_nor_flash_resources[] = {
+    [0] = {
+        .name   = "NAP-NOR-Flash",
+        .start  = 0x00000000,
+        .end    = 0x00000000 + SZ_128M - 1,
+        .flags  = IORESOURCE_MEM,
+    }
+};
+
+static struct platform_device jcinap7760_nor_flash_device = {
+    .name       = "physmap-flash",
+    .resource   = jcinap7760_nor_flash_resources,
+    .num_resources  = ARRAY_SIZE(jcinap7760_nor_flash_resources),
+    .dev        = {
+        .platform_data = &jcinap7760_nor_flash_data,
+    },
+};
+
+/* i2c initialization functions */
+static struct sh7760_i2c_platdata i2c_pd = {
+    .speed_khz  = 400,
+};
+
+static struct resource sh7760_i2c1_res[] = {
+    {
+        .start  = SH7760_I2C1_MMIO,
+        .end    = SH7760_I2C1_MMIOEND,
+        .flags  = IORESOURCE_MEM,
+    },{
+        .start  = SH7760_I2C1_IRQ,
+        .end    = SH7760_I2C1_IRQ,
+        .flags  = IORESOURCE_IRQ,
+    },
+};
+
+static struct platform_device sh7760_i2c1_dev = {
+    .dev    = {
+        .platform_data  = &i2c_pd,
+    },
+
+    .name       = SH7760_I2C_DEVNAME,
+    .id         = 1,
+    .resource   = sh7760_i2c1_res,
+    .num_resources  = ARRAY_SIZE(sh7760_i2c1_res),
+};
+
+static struct resource sh7760_i2c0_res[] = {
+    {
+        .start  = SH7760_I2C0_MMIO,
+        .end    = SH7760_I2C0_MMIOEND,
+        .flags  = IORESOURCE_MEM,
+    }, {
+        .start  = SH7760_I2C0_IRQ,
+        .end    = SH7760_I2C0_IRQ,
+        .flags  = IORESOURCE_IRQ,
+    },
+};
+
+static struct platform_device sh7760_i2c0_dev = {
+    .dev    = {
+        .platform_data  = &i2c_pd,
+    },
+    .name           = SH7760_I2C_DEVNAME,
+    .id             = 0,
+    .resource       = sh7760_i2c0_res,
+    .num_resources  = ARRAY_SIZE(sh7760_i2c0_res),
+};
+
+static struct led_info jcinap7760_led_info[] = {
+    { .name = "peer_com" },
+    { .name = "run" },
+    { .name = "gen_fault" },
+    { .name = "bat_fault" },
+    { .name = "eth_10" },
+    { .name = "bat_chg_n" },    /* Used as binary (low active) output */
+    { .name = "bat_load_n" },   /* Used as binary (low active) output */
+    { .name = "bo_on_n" },      /* Used as binary (low active) output */
+};
+
+static struct led_platform_data jcinap7760_led_platform_data = {
+    .num_leds = 8,
+    .leds = jcinap7760_led_info,
+};
+
+static struct i2c_board_info __initdata sh7760_i2c0_devices[] = {
+    {
+        I2C_BOARD_INFO("pca9551", 0x60),    /* Use 7-bit addresses */
+        .platform_data = &jcinap7760_led_platform_data,
+    },
+};
+
+static struct pca953x_platform_data jcinap_ccs_gpio_pdata = {
+    .gpio_base = 0,
+};
+
+static struct i2c_board_info __initdata sh7760_ccs_i2c0_devices[] = {
+    {
+        I2C_BOARD_INFO("pca9539", 0x77),    /* Use 7-bit addresses */
+        .platform_data = &jcinap_ccs_gpio_pdata,
+    },
+};
+
+static struct i2c_board_info __initdata sh7760_i2c1_devices[] = {
+    {
+        I2C_BOARD_INFO("rx8581", 0x51),    /* Use 7-bit addresses */
+    },
+};
+
+/* Ethernet initialization functions */
+
+static struct smc91x_platdata smc91x_info = {
+    .flags = SMC91X_USE_16BIT | SMC91X_IO_SHIFT_0 | IORESOURCE_IRQ_LOWLEVEL,
+};
+
+static struct resource smc91x_res[] = {
+    [0] = {
+        .start  = SMC_IOADDR,
+        .end    = SMC_IOADDR + SZ_32 - 1,
+        .flags  = IORESOURCE_MEM,
+    },
+    [1] = {
+        .start  = SMC_IRQ,
+        .end    = SMC_IRQ,
+        .flags  = IORESOURCE_IRQ ,
+    }
+};
+
+static struct platform_device smc91x_dev = {
+    .name       = "smc91x",
+    .id     = -1,
+    .num_resources  = ARRAY_SIZE(smc91x_res),
+    .resource   = smc91x_res,
+
+    .dev    = {
+        .platform_data  = &smc91x_info,
+    },
+};
+
+/* DUART */
+static struct plat_serial8250_port serial_platform_data[] = {
+    {
+        .mapbase    = DUART_A_IOADDR,
+        .irq        = DUART_A_IRQ,
+        .uartclk    = 3686400,
+        .regshift   = 0,
+        .iotype     = UPIO_MEM,
+        .flags      = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_SKIP_TEST,
+    },
+    {
+        .mapbase    = DUART_B_IOADDR,
+        .irq        = DUART_B_IRQ,
+        .uartclk    = 3686400,
+        .regshift   = 0,
+        .iotype     = UPIO_MEM,
+        .flags      = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_SKIP_TEST,
+    },
+    { },
+};
+
+static struct platform_device serial_devices = {
+    .name           = "serial8250",
+    .id             = PLAT8250_DEV_PLATFORM,
+    .dev            = {
+        .platform_data  = serial_platform_data,
+    },
+};
+
+/* SH7760 LCDC */
+static struct resource sh7760_fb_resources[] = {
+   [0] = {
+           .start  = 0xFE300800,
+           .end    = 0xFE300CFF,
+           .flags  = IORESOURCE_MEM,
+   },
+   [1] = {
+           .start  = 65,
+           .end    = 65,
+           .flags  = IORESOURCE_IRQ,
+   },
+};
+
+static struct fb_videomode sh7760_fb_videomode = {
+    .name = "XVGA Monitor",
+    .xres = 800,
+    .yres = 480,
+    .pixclock = 30066,  /* pico seconds */
+    .left_margin = 288,
+    .right_margin = 64,
+    .upper_margin = 33,
+    .lower_margin = 4,
+    .hsync_len = 88,
+    .vsync_len = 6,
+    .sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+    .vmode = FB_VMODE_NONINTERLACED,
+    .flag = 0,
+};
+
+static struct sh7760fb_platdata sh7760_fb_def_pdata = {
+    .def_mode = &sh7760_fb_videomode,
+    .ldickr = 0x1111,
+    .ldmtr = 0xC42B,        /* was...(LDMTR_TFT_COLOR_16|LDMTR_MCNT),*/
+    .lddfr = LDDFR_8BPP,
+    .ldpmmr = 0x0070,
+    .ldpspr = 0xF66F,
+    .ldaclnr = 0x000C,
+    .rotate = 0,
+    .novsync = 1,
+    .blank = NULL,
+};
+
+static struct platform_device sh7760_fb_device = {
+    .name       = "sh7760-lcdc",
+    .resource   = sh7760_fb_resources,
+    .num_resources = ARRAY_SIZE(sh7760_fb_resources),
+    .dev = {
+        .platform_data = &sh7760_fb_def_pdata,
+    },
+};
+
+/* USB Host Controller */
+static struct resource usb_host_resources[] = {
+    [0] = {
+        .start  = 0xfe340000,
+        .end    = 0xfe342fff,
+        .flags  = IORESOURCE_MEM,
+    },
+    [1] = {
+        .start  = 64,
+        .end    = 64,
+        .flags  = IORESOURCE_IRQ,
+    },
+};
+
+static struct platform_device usb_host_device = {
+    .name           = "sh_ohci",
+    .id             = -1,
+    .num_resources  = ARRAY_SIZE(usb_host_resources),
+    .resource       = usb_host_resources,
+}; 
+
+/* SPI devices - Touch Screen (CCS only) */
+
+static int ads7843_pendown_state(void)
+{
+	return (ctrl_inb(PGDR) & 0x40) ? 0 : 1;
+}
+
+static struct ads7846_platform_data ads_info = {
+    .model              = 7843,
+    .x_min              = 150,
+    .x_max              = 3830,
+    .y_min              = 190,
+    .y_max              = 3830,
+    .vref_delay_usecs   = 100,
+    .keep_vref_on       = 1,        /* To match CCS WinCE impl. */
+    .x_plate_ohms       = 576,
+    .y_plate_ohms       = 366,
+    .pressure_max       = 15000,    /* Generally nonsense on the 7843 */
+    .debounce_max       = 1,
+    .debounce_rep       = 0,
+    .debounce_tol       = (~0),
+    .get_pendown_state  = ads7843_pendown_state,
+};
+
+static struct spi_board_info jcinap_spi_devices[] = {
+    {   
+        /* Touchscreen controller */
+        .modalias       = "ads7846",
+        .chip_select    = 0,
+        .bus_num        = 0,
+        .max_speed_hz   = 1000000,   /* 1Mhz */
+        .platform_data  = &ads_info,
+        .irq            = 11
+    },
+};
+
+/* SPI Interface */
+
+static struct resource spi_res[] = {
+    [0] = {
+        .start  = 0xFE180000,
+        .end    = 0xFE180013,
+        .flags  = IORESOURCE_MEM,
+    },
+    [1] = { 
+        .start  = 84,
+        .end    = 84,
+        .flags  = IORESOURCE_IRQ ,
+    }
+};
+
+static struct platform_device spi_dev = {
+    .name       = "spi_hspi",
+    .id         = 0,
+    .num_resources = ARRAY_SIZE(spi_res),
+    .resource   = spi_res,
+};
+
+/* Platform init code */
+static struct platform_device *jcinap7760_devices[] __initdata = {
+    &serial_devices,
+    &smc91x_dev, 
+    &jcinap7760_nor_flash_device,
+    &usb_host_device,
+};
+
+static struct platform_device *jcinap7760_ccs_devices[] __initdata = {
+    &serial_devices,
+	&spi_dev,
+    &smc91x_dev, 
+    &jcinap7760_nor_flash_device,
+    &usb_host_device,
+    &sh7760_fb_device,
+};
+
+
+/* NAP's watchdog control option */
+static int jciwatchdog = 1;     // On by default
+static int __init jciwatchdogoff(char *str) {
+    jciwatchdog = 0;
+    return 0;
+}
+
+early_param("jciwatchdogoff", jciwatchdogoff);
+
+/* Identify NAP CCS variation. */
+
+#define NAP_FACTORY_DATA_ADDRESS (0xA0080000 - 1) /* accessing via in P2 region */
+
+typedef struct _NAP_FACTORY_DATA {
+    u8 MinorVer;         /* Minor Version */
+    u8 MajorVer;         /* Major Version */
+
+    union {
+        struct {
+            u16    Day     : 5;    /* 4:0 Day of Month. */
+            u16    Month   : 4;    /* 8:5 Month of Year */
+            u16    Year    : 7;    /* 15:9 Year */
+        };
+        u16    wDate;
+    };
+
+    u8  MAC[6];          /* MAC Address */
+    u8  ProductCode[32]; /* Product Codes */
+    u16 wBattDeltaRes;   /* Battery Delta Resolution */
+    u16 wBattDeltaOff;   /* Battery Delta Offset */
+    u16 wBattVoltRes;    /* Battery Volt Resolution */
+    u16 wBattVoltOff;    /* Battery Volt Offset */
+} NAP_FACTORY_DATA;
+
+static int __init is_ccs_nap(void)
+{
+    NAP_FACTORY_DATA* fdata_ptr;
+    u8* ptr = (u8*)NAP_FACTORY_DATA_ADDRESS - 1;
+    
+    if (memcmp(ptr, "JC", 2) == 0) {
+        ptr -= 2;
+        /* Subtract offset from offset's addr to get factory data structure address */
+        ptr = ptr - *(u16*)(ptr);
+        fdata_ptr = (NAP_FACTORY_DATA*)ptr;
+        return memcmp(fdata_ptr->ProductCode, "YK", 2) == 0 || memcmp(fdata_ptr->ProductCode, "LC", 2) == 0;
+    }
+    else
+        return 0;
+}
+
+/**** Platform device initialization. *****/
+
+static int __init init_jcinap7760_devices(void)
+{
+    int is_ccs = is_ccs_nap();
+
+    if (is_ccs) {
+        /* Enable LCDC function pins */
+        ctrl_outw(0, PCCR);
+        ctrl_outw(0, PDCR);
+        ctrl_outw(0, PECR);
+        ctrl_outw(ctrl_inw(IPSELR) & ~IPSELR_LCDC_MASK, IPSELR);
+
+        /* Set up DMA for the LCDC */
+        ctrl_outl(0x94808080, DMARSRA);
+        ctrl_outl(0x80808080, DMARSRB);
+        ctrl_outl(0, DMATCR0);
+        ctrl_outl(0x0000C001, DMAOR);       /* DMABRG | DME */
+
+        /* Set up and (for now) turn on the LCD backlight. */
+        if ((ctrl_inw(PGCR) & BKLIGHT_CTRL_MASK) != BKLIGHT_CTRL_VALUE) {
+            /* We don't mess with PFC for GPIO G if it has already been initialized properly */
+            ctrl_outw((ctrl_inw(PGCR) & ~BKLIGHT_CTRL_MASK) | BKLIGHT_CTRL_VALUE, PGCR);
+        }
+        /* Turn on the LCD backlight TODO: Hook into standard Linux backlight control */
+        ctrl_outb(ctrl_inb(PGDR) | BKLIGHT_MASK, PGDR); 
+
+        /* Enable Pen input GPIO PTG6 */
+        ctrl_outw(ctrl_inw(PGCR) | 0x3000, PGCR);
+
+        /* Register the SPI devices */
+        spi_register_board_info(jcinap_spi_devices, ARRAY_SIZE(jcinap_spi_devices));
+
+         /* Now set up the our board's other devices. */
+        platform_add_devices(jcinap7760_ccs_devices, ARRAY_SIZE(jcinap7760_ccs_devices));
+    }
+    else {
+        /* Now set up the our board's other devices. */
+        platform_add_devices(jcinap7760_devices, ARRAY_SIZE(jcinap7760_devices));
+    }
+
+    /* I2C Based devices are last. */
+    if (is_ccs)
+        i2c_register_board_info(0, sh7760_ccs_i2c0_devices, ARRAY_SIZE(sh7760_ccs_i2c0_devices));
+    else
+        i2c_register_board_info(0, sh7760_i2c0_devices, ARRAY_SIZE(sh7760_i2c0_devices));
+
+    platform_device_register(&sh7760_i2c0_dev);
+
+    i2c_register_board_info(1, sh7760_i2c1_devices, ARRAY_SIZE(sh7760_i2c1_devices));
+    platform_device_register(&sh7760_i2c1_dev);
+
+    return 0;
+}
+__initcall(init_jcinap7760_devices);
+
+static void __init init_jcinap7760_irqs(void)
+{
+    plat_irq_setup_pins(IRQ_MODE_IRQ);
+    if (jciwatchdog) {
+        /* Enable PORTB Bit 5 as output and drive high. Timer interrupt toggles bit. */
+        ctrl_outb(ctrl_inb(PBDR) | PTB5, PBDR); // First set as high
+        ctrl_outw((ctrl_inw(PBCR) & 0xF3FF) | 0x0400, PBCR);
+    }
+    else {
+        /* Cobra's watchdog defeat is wired so ensure PORTB bit 5 is an input. */
+        ctrl_outw((ctrl_inw(PBCR) & 0xF3FF) | 0x0800, PBCR);
+    }
+}
+
+/*
+ * The Machine Vector
+ */
+struct sh_machine_vector mv_jcinap7760 __initmv = {
+    .mv_name    = "JCINAP7760",
+    .mv_nr_irqs = 128,
+    .mv_init_irq = &init_jcinap7760_irqs,
+};
diff -ruN linux-2.6.28.2-orig/arch/sh/boards/Kconfig linux-2.6.28.2/arch/sh/boards/Kconfig
--- linux-2.6.28.2-orig/arch/sh/boards/Kconfig	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/arch/sh/boards/Kconfig	2009-05-02 09:52:58.000000000 -0500
@@ -194,6 +194,12 @@
 	  Select if configuring for a Renesas EDOSK7760
 	  evaluation board.
 
+config SH_JCINAP7760
+	bool "JCINAP7760"
+	depends on CPU_SUBTYPE_SH7760
+	help
+	  Select if configuring for a Johnson Controls NAP (SH7760) N40 Platform.
+
 config SH_SH4202_MICRODEV
 	bool "SH4-202 MicroDev"
 	depends on CPU_SUBTYPE_SH4_202
diff -ruN linux-2.6.28.2-orig/arch/sh/boards/Makefile linux-2.6.28.2/arch/sh/boards/Makefile
--- linux-2.6.28.2-orig/arch/sh/boards/Makefile	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/arch/sh/boards/Makefile	2009-05-02 09:52:58.000000000 -0500
@@ -7,3 +7,4 @@
 obj-$(CONFIG_SH_SH7785LCR)	+= board-sh7785lcr.o
 obj-$(CONFIG_SH_SHMIN)		+= board-shmin.o
 obj-$(CONFIG_SH_EDOSK7760)	+= board-edosk7760.o
+obj-$(CONFIG_SH_JCINAP7760)	+= board-jcinap7760.o
diff -ruN linux-2.6.28.2-orig/arch/sh/boot/compressed/head_32.S linux-2.6.28.2/arch/sh/boot/compressed/head_32.S
--- linux-2.6.28.2-orig/arch/sh/boot/compressed/head_32.S	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/arch/sh/boot/compressed/head_32.S	2009-05-02 09:52:58.000000000 -0500
@@ -80,6 +80,12 @@
 	jsr	@r0
 	nop
 
+#ifdef CONFIG_SH_JCINAP7760
+	/* Copy the TurboBoot kernel parameters to actual kernel address. */
+	mov.l	copy_turboboot_kernel_parameters_addr, r0
+	jsr	@r0
+	 nop
+#endif
 	/* Jump to the start of the decompressed kernel */
 	mov.l	kernel_start_addr, r0
 	jmp	@r0
@@ -98,7 +104,10 @@
 	.long	decompress_kernel
 kernel_start_addr:
 	.long	_text+PAGE_SIZE
-
+#ifdef CONFIG_SH_JCINAP7760
+copy_turboboot_kernel_parameters_addr:
+	.long	copy_turboboot_kernel_parameters
+#endif
 	.align	9
 fake_headers_as_bzImage:
 	.word	0
diff -ruN linux-2.6.28.2-orig/arch/sh/boot/compressed/misc_32.c linux-2.6.28.2/arch/sh/boot/compressed/misc_32.c
--- linux-2.6.28.2-orig/arch/sh/boot/compressed/misc_32.c	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/arch/sh/boot/compressed/misc_32.c	2009-05-02 09:52:58.000000000 -0500
@@ -95,6 +95,25 @@
 
 #include "../../../../lib/inflate.c"
 
+void* memset(void* s, int c, size_t n)
+{
+	int i;
+	char *ss = (char*)s;
+
+	for (i=0;i<n;i++) ss[i] = c;
+	return s;
+}
+
+void* memcpy(void* __dest, __const void* __src,
+			    size_t __n)
+{
+	int i;
+	char *d = (char *)__dest, *s = (char *)__src;
+
+	for (i=0;i<__n;i++) d[i] = s[i];
+	return __dest;
+}
+
 #ifdef CONFIG_SH_STANDARD_BIOS
 size_t strlen(const char *s)
 {
@@ -111,32 +130,103 @@
 	sh_bios_console_write(s, len);
 	return len;
 }
-#else
-int puts(const char *s)
+
+#elif CONFIG_SH_JCINAP7760
+/* Console routines for the JCI Cobra boot loader. */
+
+#define BSC_BCR2 0xFF800004
+#define BOOT_FLASH_IS_32BIT() (0xC000 == ((*(volatile unsigned short *)BSC_BCR2) & 0xC000))
+#define UART_BASE (BOOT_FLASH_IS_32BIT() ? 0xB8000008 : 0xA4000008)
+
+#define FFTHR 0x00
+#define FFLSR 0x05
+
+#define PBCR 0xFE400004
+#define PBDR 0xFE400044
+#define PTB5 0x20
+
+#define INTC_ICR	  0xFFD00000UL
+#define INTC_ICR_IRLM (1 << 7)
+
+static inline void jci_init_irqs(void)
 {
-	/* This should be updated to use the sh-sci routines */
-	return 0;
+    *(volatile unsigned short *)INTC_ICR = (*(volatile unsigned short *)INTC_ICR) | INTC_ICR_IRLM;   /* Force IRL pins to independent mode. */
 }
-#endif
 
-void* memset(void* s, int c, size_t n)
+static inline void jci_toggle_watchdog(void)
 {
-	int i;
-	char *ss = (char*)s;
+    /* Check if the Cobra watchdog bit is set as an output. If not don't toggle the line. */
+    if (((*(volatile unsigned short *)PBCR) & 0x0C00) == 0x0400) {
+        (*(volatile unsigned char *)PBDR) = (*(volatile unsigned char *)PBDR) ^ PTB5;   /* Toggle watchdog bit. */
+    }
+}
 
-	for (i=0;i<n;i++) ss[i] = c;
-	return s;
+size_t strlen(const char *s)
+{
+    int i = 0;
+
+    while (*s++)
+        i++;
+    return i;
 }
 
-void* memcpy(void* __dest, __const void* __src,
-			    size_t __n)
+static inline int putDebugCharReady(void)
 {
-	int i;
-	char *d = (char *)__dest, *s = (char *)__src;
+	return ((*(volatile u8 *)(UART_BASE + FFLSR) & 0x20) != 0);
+}
 
-	for (i=0;i<__n;i++) d[i] = s[i];
-	return __dest;
+void putDebugChar(char ch)
+{
+    while (!putDebugCharReady()) {}
+    *(volatile u8 *)(UART_BASE + FFTHR) = ((u8)ch);
+}
+
+void putDebugString(const char *str)
+{
+    const char *p;
+    
+    for (p = str; *p; p++)
+    {
+        if (*p == '\n')
+            putDebugChar ('\r');
+        putDebugChar (*p);
+    }
+}
+
+void putn(int n)
+{
+    int cnt = 8;
+    putDebugString("0x");
+    while (cnt--)
+    {
+        int hexdigit = ((n & 0xF0000000) >> 28);
+        char ch = hexdigit >= 10 ? 'a' + (hexdigit - 10) : '0' + hexdigit;
+        putDebugChar(ch);
+        n <<= 4;
+    }
+}
+
+int puts(const char *s)
+{
+    int len = strlen(s);
+    putDebugString(s);
+    return len;
+}
+
+void copy_turboboot_kernel_parameters(void)
+{
+    unsigned long linux_param_ptr = PHYSADDR((unsigned long)&_text);
+    unsigned long tb_param_ptr = 0xAC001000;    /* Hard coded address in TurboBoot. */
+    memcpy((void*)linux_param_ptr, (void*)tb_param_ptr, 512);
+}
+
+#else
+int puts(const char *s)
+{
+	/* This should be updated to use the sh-sci routines */
+	return 0;
 }
+#endif
 
 /* ===========================================================================
  * Fill the input buffer. This is called only when the buffer is empty
@@ -151,6 +241,7 @@
 	inbuf = input_data;
 	insize = input_len;
 	inptr = 1;
+	
 	return inbuf[0];
 }
 
@@ -163,6 +254,11 @@
     ulg c = crc;         /* temporary variable */
     unsigned n;
     uch *in, *out, ch;
+    
+#ifdef CONFIG_SH_JCINAP7760
+    jci_toggle_watchdog();
+    putDebugChar('.');
+#endif
 
     in = window;
     out = &output_data[output_ptr];
@@ -191,6 +287,9 @@
 
 void decompress_kernel(void)
 {
+#ifdef CONFIG_SH_JCINAP7760
+    jci_init_irqs();
+#endif
 	output_data = NULL;
 	output_ptr = PHYSADDR((unsigned long)&_text+PAGE_SIZE);
 #ifdef CONFIG_29BIT
@@ -200,7 +299,7 @@
 	free_mem_end_ptr = free_mem_ptr + HEAP_SIZE;
 
 	makecrc();
-	puts("Uncompressing Linux... ");
+	puts("Decompressing Linux... ");
 	gunzip();
 	puts("Ok, booting the kernel.\n");
 }
diff -ruN linux-2.6.28.2-orig/arch/sh/configs/jcinap7760_defconfig linux-2.6.28.2/arch/sh/configs/jcinap7760_defconfig
--- linux-2.6.28.2-orig/arch/sh/configs/jcinap7760_defconfig	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.28.2/arch/sh/configs/jcinap7760_defconfig	2009-05-02 16:16:35.000000000 -0500
@@ -0,0 +1,1332 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.28.2
+# Sat May  2 16:05:40 2009
+#
+CONFIG_SUPERH=y
+CONFIG_SUPERH32=y
+CONFIG_ARCH_DEFCONFIG="arch/sh/configs/shx3_defconfig"
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_BUG=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_GENERIC_IRQ_PROBE=y
+# CONFIG_GENERIC_GPIO is not set
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_HAVE_LATENCYTOP_SUPPORT=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_NO_VIRT_TO_BUS=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+# CONFIG_EXPERIMENTAL is not set
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION="nappylinux"
+CONFIG_LOCALVERSION_AUTO=y
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=17
+# CONFIG_CGROUPS is not set
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+# CONFIG_UID16 is not set
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+# CONFIG_ELF_CORE is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+# CONFIG_SHMEM is not set
+CONFIG_AIO=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+CONFIG_HAVE_IOREMAP_PROT=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_ARCH_TRACEHOOK=y
+CONFIG_HAVE_CLK=y
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_RT_MUTEXES=y
+CONFIG_TINY_SHMEM=y
+CONFIG_BASE_SMALL=0
+# CONFIG_MODULES is not set
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+CONFIG_CLASSIC_RCU=y
+# CONFIG_FREEZER is not set
+
+#
+# System type
+#
+CONFIG_CPU_SH4=y
+# CONFIG_CPU_SUBTYPE_SH7619 is not set
+# CONFIG_CPU_SUBTYPE_SH7203 is not set
+# CONFIG_CPU_SUBTYPE_SH7206 is not set
+# CONFIG_CPU_SUBTYPE_SH7263 is not set
+# CONFIG_CPU_SUBTYPE_MXG is not set
+# CONFIG_CPU_SUBTYPE_SH7705 is not set
+# CONFIG_CPU_SUBTYPE_SH7706 is not set
+# CONFIG_CPU_SUBTYPE_SH7707 is not set
+# CONFIG_CPU_SUBTYPE_SH7708 is not set
+# CONFIG_CPU_SUBTYPE_SH7709 is not set
+# CONFIG_CPU_SUBTYPE_SH7710 is not set
+# CONFIG_CPU_SUBTYPE_SH7712 is not set
+# CONFIG_CPU_SUBTYPE_SH7720 is not set
+# CONFIG_CPU_SUBTYPE_SH7721 is not set
+# CONFIG_CPU_SUBTYPE_SH7750 is not set
+# CONFIG_CPU_SUBTYPE_SH7091 is not set
+# CONFIG_CPU_SUBTYPE_SH7750R is not set
+# CONFIG_CPU_SUBTYPE_SH7750S is not set
+# CONFIG_CPU_SUBTYPE_SH7751 is not set
+# CONFIG_CPU_SUBTYPE_SH7751R is not set
+CONFIG_CPU_SUBTYPE_SH7760=y
+# CONFIG_CPU_SUBTYPE_SH4_202 is not set
+# CONFIG_CPU_SUBTYPE_SH7723 is not set
+# CONFIG_CPU_SUBTYPE_SH7763 is not set
+# CONFIG_CPU_SUBTYPE_SH7770 is not set
+# CONFIG_CPU_SUBTYPE_SH7780 is not set
+# CONFIG_CPU_SUBTYPE_SH7785 is not set
+# CONFIG_CPU_SUBTYPE_SHX3 is not set
+# CONFIG_CPU_SUBTYPE_SH7343 is not set
+# CONFIG_CPU_SUBTYPE_SH7722 is not set
+# CONFIG_CPU_SUBTYPE_SH7366 is not set
+# CONFIG_CPU_SUBTYPE_SH5_101 is not set
+# CONFIG_CPU_SUBTYPE_SH5_103 is not set
+
+#
+# Memory management options
+#
+CONFIG_QUICKLIST=y
+CONFIG_MMU=y
+CONFIG_PAGE_OFFSET=0x80000000
+CONFIG_MEMORY_START=0x08000000
+CONFIG_MEMORY_SIZE=0x08000000
+CONFIG_29BIT=y
+CONFIG_VSYSCALL=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_SPARSEMEM_ENABLE=y
+CONFIG_ARCH_SPARSEMEM_DEFAULT=y
+CONFIG_MAX_ACTIVE_REGIONS=1
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_ARCH_SELECT_MEMORY_MODEL=y
+CONFIG_PAGE_SIZE_4KB=y
+# CONFIG_PAGE_SIZE_8KB is not set
+# CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_64KB is not set
+CONFIG_ENTRY_OFFSET=0x00001000
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_SPARSEMEM_STATIC=y
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_NR_QUICK=2
+# CONFIG_UNEVICTABLE_LRU is not set
+
+#
+# Cache configuration
+#
+# CONFIG_SH_DIRECT_MAPPED is not set
+CONFIG_CACHE_WRITEBACK=y
+# CONFIG_CACHE_WRITETHROUGH is not set
+# CONFIG_CACHE_OFF is not set
+
+#
+# Processor features
+#
+CONFIG_CPU_LITTLE_ENDIAN=y
+# CONFIG_CPU_BIG_ENDIAN is not set
+CONFIG_SH_FPU=y
+CONFIG_SH_STORE_QUEUES=y
+CONFIG_CPU_HAS_INTEVT=y
+CONFIG_CPU_HAS_SR_RB=y
+CONFIG_CPU_HAS_PTEA=y
+CONFIG_CPU_HAS_FPU=y
+
+#
+# Board support
+#
+# CONFIG_SH_EDOSK7760 is not set
+CONFIG_SH_JCINAP7760=y
+
+#
+# Timer and clock configuration
+#
+CONFIG_SH_TMU=y
+CONFIG_SH_TIMER_IRQ=16
+CONFIG_SH_PCLK_FREQ=32000000
+CONFIG_TICK_ONESHOT=y
+# CONFIG_NO_HZ is not set
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+
+#
+# CPU Frequency scaling
+#
+# CONFIG_CPU_FREQ is not set
+
+#
+# DMA support
+#
+CONFIG_SH_DMA_API=y
+CONFIG_SH_DMA=y
+CONFIG_NR_ONCHIP_DMA_CHANNELS=4
+# CONFIG_NR_DMA_CHANNELS_BOOL is not set
+CONFIG_SH_DMABRG=y
+
+#
+# Companion Chips
+#
+
+#
+# Additional SuperH Device Drivers
+#
+# CONFIG_HEARTBEAT is not set
+# CONFIG_PUSH_SWITCH is not set
+
+#
+# Kernel features
+#
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_SCHED_HRTICK=y
+# CONFIG_SECCOMP is not set
+# CONFIG_PREEMPT_NONE is not set
+# CONFIG_PREEMPT_VOLUNTARY is not set
+CONFIG_PREEMPT=y
+# CONFIG_PREEMPT_RCU is not set
+CONFIG_GUSA=y
+# CONFIG_GUSA_RB is not set
+
+#
+# Boot options
+#
+CONFIG_ZERO_PAGE_OFFSET=0x00001000
+CONFIG_BOOT_LINK_OFFSET=0x00800000
+# CONFIG_UBC_WAKEUP is not set
+# CONFIG_CMDLINE_BOOL is not set
+
+#
+# Bus options
+#
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCCARD is not set
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+CONFIG_INET_TUNNEL=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+CONFIG_IPV6=y
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+CONFIG_INET6_XFRM_MODE_TRANSPORT=y
+CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+CONFIG_IPV6_SIT=y
+CONFIG_IPV6_NDISC_NODETYPE=y
+# CONFIG_IPV6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_PHONET is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_RFKILL is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_STANDALONE=y
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+CONFIG_DEBUG_DRIVER=y
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
+CONFIG_MTD_CFI_GEOMETRY=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+CONFIG_MTD_CFI_I4=y
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_OTP is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+CONFIG_MTD_COMPLEX_MAPPINGS=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0x0
+CONFIG_MTD_PHYSMAP_LEN=0x0
+CONFIG_MTD_PHYSMAP_BANKWIDTH=4
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_UB is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=4096
+# CONFIG_BLK_DEV_XIP is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_NETLINK is not set
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+CONFIG_BLK_DEV_SR=y
+CONFIG_BLK_DEV_SR_VENDOR=y
+# CONFIG_CHR_DEV_SG is not set
+# CONFIG_CHR_DEV_SCH is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+# CONFIG_SCSI_MULTI_LUN is not set
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+
+#
+# SCSI Transports
+#
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+# CONFIG_SCSI_LOWLEVEL is not set
+# CONFIG_SCSI_DH is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+CONFIG_SMSC_PHY=y
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
+# CONFIG_STNIC is not set
+CONFIG_SMC91X=y
+# CONFIG_SMC911X is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_B44 is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ADS7846=y
+# CONFIG_TOUCHSCREEN_FUJITSU is not set
+# CONFIG_TOUCHSCREEN_GUNZE is not set
+# CONFIG_TOUCHSCREEN_ELO is not set
+# CONFIG_TOUCHSCREEN_MTOUCH is not set
+# CONFIG_TOUCHSCREEN_INEXIO is not set
+# CONFIG_TOUCHSCREEN_MK712 is not set
+# CONFIG_TOUCHSCREEN_PENMOUNT is not set
+# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
+# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
+# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
+# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+CONFIG_DEVKMEM=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_SH_SCI is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_HELPER_AUTO=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+CONFIG_I2C_SH7760=y
+# CONFIG_I2C_SH_MOBILE is not set
+# CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TINY_USB is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_PCF8575 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+CONFIG_SPI_BITBANG=y
+CONFIG_SPI_HSPI=y
+# CONFIG_SPI_SH_SCI is not set
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_AT25 is not set
+# CONFIG_SPI_TLE62X0 is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+CONFIG_THERMAL_HWMON=y
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_REGULATOR is not set
+
+#
+# Multimedia devices
+#
+
+#
+# Multimedia core support
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_VIDEO_MEDIA is not set
+
+#
+# Multimedia drivers
+#
+# CONFIG_DAB is not set
+
+#
+# Graphics support
+#
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_SH_MOBILE_LCDC is not set
+CONFIG_FB_SH7760=y
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+# CONFIG_LCD_CLASS_DEVICE is not set
+# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_LOGO_LINUX_CLUT224=y
+# CONFIG_LOGO_SUPERH_MONO is not set
+# CONFIG_LOGO_SUPERH_VGA16 is not set
+CONFIG_LOGO_SUPERH_CLUT224=y
+# CONFIG_SOUND is not set
+# CONFIG_HID_SUPPORT is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
+
+#
+# Miscellaneous USB options
+#
+CONFIG_USB_DEVICEFS=y
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+CONFIG_USB_MON=y
+# CONFIG_USB_WUSB_CBAF is not set
+
+#
+# USB Host Controller Drivers
+#
+# CONFIG_USB_C67X00_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+
+#
+# USB Device Class drivers
+#
+CONFIG_USB_ACM=y
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed;
+#
+
+#
+# see USB_STORAGE Help for more information
+#
+CONFIG_USB_STORAGE=y
+# CONFIG_USB_STORAGE_DEBUG is not set
+# CONFIG_USB_STORAGE_DATAFAB is not set
+# CONFIG_USB_STORAGE_FREECOM is not set
+# CONFIG_USB_STORAGE_ISD200 is not set
+# CONFIG_USB_STORAGE_DPCM is not set
+# CONFIG_USB_STORAGE_USBAT is not set
+# CONFIG_USB_STORAGE_SDDR09 is not set
+# CONFIG_USB_STORAGE_SDDR55 is not set
+# CONFIG_USB_STORAGE_JUMPSHOT is not set
+# CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
+# CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+
+#
+# USB port drivers
+#
+CONFIG_USB_SERIAL=y
+# CONFIG_USB_SERIAL_CONSOLE is not set
+# CONFIG_USB_EZUSB is not set
+# CONFIG_USB_SERIAL_GENERIC is not set
+# CONFIG_USB_SERIAL_AIRCABLE is not set
+# CONFIG_USB_SERIAL_ARK3116 is not set
+# CONFIG_USB_SERIAL_BELKIN is not set
+# CONFIG_USB_SERIAL_CH341 is not set
+# CONFIG_USB_SERIAL_WHITEHEAT is not set
+# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
+# CONFIG_USB_SERIAL_CP2101 is not set
+# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
+# CONFIG_USB_SERIAL_EMPEG is not set
+# CONFIG_USB_SERIAL_FTDI_SIO is not set
+# CONFIG_USB_SERIAL_FUNSOFT is not set
+# CONFIG_USB_SERIAL_VISOR is not set
+# CONFIG_USB_SERIAL_IPAQ is not set
+# CONFIG_USB_SERIAL_IR is not set
+# CONFIG_USB_SERIAL_EDGEPORT is not set
+# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
+# CONFIG_USB_SERIAL_GARMIN is not set
+# CONFIG_USB_SERIAL_IPW is not set
+# CONFIG_USB_SERIAL_IUU is not set
+# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
+# CONFIG_USB_SERIAL_KEYSPAN is not set
+# CONFIG_USB_SERIAL_KLSI is not set
+# CONFIG_USB_SERIAL_KOBIL_SCT is not set
+# CONFIG_USB_SERIAL_MCT_U232 is not set
+# CONFIG_USB_SERIAL_MOS7720 is not set
+# CONFIG_USB_SERIAL_MOS7840 is not set
+# CONFIG_USB_SERIAL_MOTOROLA is not set
+# CONFIG_USB_SERIAL_NAVMAN is not set
+# CONFIG_USB_SERIAL_PL2303 is not set
+# CONFIG_USB_SERIAL_OTI6858 is not set
+# CONFIG_USB_SERIAL_SPCP8X5 is not set
+# CONFIG_USB_SERIAL_HP4X is not set
+# CONFIG_USB_SERIAL_SAFE is not set
+# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
+# CONFIG_USB_SERIAL_TI is not set
+# CONFIG_USB_SERIAL_CYBERJACK is not set
+# CONFIG_USB_SERIAL_XIRCOM is not set
+# CONFIG_USB_SERIAL_OPTION is not set
+# CONFIG_USB_SERIAL_OMNINET is not set
+# CONFIG_USB_SERIAL_DEBUG is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_SEVSEG is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_PHIDGET is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
+# CONFIG_USB_GADGET is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+#
+# LED drivers
+#
+CONFIG_LEDS_PCA955X=y
+
+#
+# LED Triggers
+#
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_BACKLIGHT=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+# CONFIG_ACCESSIBILITY is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+CONFIG_RTC_DRV_RX8581=y
+
+#
+# SPI RTC drivers
+#
+# CONFIG_RTC_DRV_M41T94 is not set
+# CONFIG_RTC_DRV_DS1305 is not set
+# CONFIG_RTC_DRV_DS1390 is not set
+# CONFIG_RTC_DRV_MAX6902 is not set
+# CONFIG_RTC_DRV_R9701 is not set
+# CONFIG_RTC_DRV_RS5C348 is not set
+# CONFIG_RTC_DRV_DS3234 is not set
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_DS1286 is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+# CONFIG_RTC_DRV_SH is not set
+CONFIG_DMADEVICES=y
+
+#
+# DMA Devices
+#
+# CONFIG_UIO is not set
+# CONFIG_STAGING is not set
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY is not set
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=y
+CONFIG_FUSE_FS=y
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=y
+CONFIG_UDF_NLS=y
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLBFS is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_HFSPLUS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RTIME=y
+CONFIG_JFFS2_RUBIN=y
+# CONFIG_JFFS2_CMODE_NONE is not set
+# CONFIG_JFFS2_CMODE_PRIORITY is not set
+# CONFIG_JFFS2_CMODE_SIZE is not set
+CONFIG_JFFS2_CMODE_FAVOURLZO=y
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="cp437"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Kernel hacking
+#
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_PRINTK_TIME=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_FRAME_WARN=1024
+# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_UNUSED_SYMBOLS=y
+CONFIG_DEBUG_FS=y
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+CONFIG_DEBUG_OBJECTS=y
+# CONFIG_DEBUG_OBJECTS_SELFTEST is not set
+# CONFIG_DEBUG_OBJECTS_FREE is not set
+# CONFIG_DEBUG_OBJECTS_TIMERS is not set
+CONFIG_DEBUG_PREEMPT=y
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_FRAME_POINTER is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_LATENCYTOP is not set
+CONFIG_HAVE_FUNCTION_TRACER=y
+
+#
+# Tracers
+#
+# CONFIG_FUNCTION_TRACER is not set
+# CONFIG_IRQSOFF_TRACER is not set
+# CONFIG_PREEMPT_TRACER is not set
+# CONFIG_SCHED_TRACER is not set
+# CONFIG_CONTEXT_SWITCH_TRACER is not set
+# CONFIG_BOOT_TRACER is not set
+# CONFIG_STACK_TRACER is not set
+CONFIG_DYNAMIC_PRINTK_DEBUG=y
+# CONFIG_SAMPLES is not set
+# CONFIG_SH_STANDARD_BIOS is not set
+# CONFIG_EARLY_SCIF_CONSOLE is not set
+# CONFIG_DEBUG_BOOTMEM is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_4KSTACKS is not set
+# CONFIG_IRQSTACKS is not set
+# CONFIG_SH_KGDB is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITYFS is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+# CONFIG_CRYPTO_FIPS is not set
+# CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_MANAGER2 is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+# CONFIG_CRYPTO_CBC is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_PCBC is not set
+
+#
+# Hash modes
+#
+# CONFIG_CRYPTO_HMAC is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_MD4 is not set
+# CONFIG_CRYPTO_MD5 is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_RMD128 is not set
+# CONFIG_CRYPTO_RMD160 is not set
+# CONFIG_CRYPTO_RMD256 is not set
+# CONFIG_CRYPTO_RMD320 is not set
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_LZO is not set
+
+#
+# Random Number Generation
+#
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_HW is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+CONFIG_LIBCRC32C=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
diff -ruN linux-2.6.28.2-orig/arch/sh/include/asm/serial.h linux-2.6.28.2/arch/sh/include/asm/serial.h
--- linux-2.6.28.2-orig/arch/sh/include/asm/serial.h	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/arch/sh/include/asm/serial.h	2009-05-02 09:52:58.000000000 -0500
@@ -7,6 +7,10 @@
 #ifndef _ASM_SERIAL_H
 #define _ASM_SERIAL_H
 
+#ifdef CONFIG_SH_JCINAP7760
+/* This is the crystal frequency of the Cobra board's DUART */
+#define BASE_BAUD ( 3686400 / 16 )
+#else
 /*
  * This assumes you have a 1.8432 MHz clock for your UART.
  *
@@ -15,5 +19,6 @@
  * megabits/second; but this requires the faster clock.
  */
 #define BASE_BAUD ( 1843200 / 16 )
+#endif
 
 #endif /* _ASM_SERIAL_H */
diff -ruN linux-2.6.28.2-orig/arch/sh/Kconfig linux-2.6.28.2/arch/sh/Kconfig
--- linux-2.6.28.2-orig/arch/sh/Kconfig	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/arch/sh/Kconfig	2009-05-02 09:52:58.000000000 -0500
@@ -299,6 +299,7 @@
 config CPU_SUBTYPE_SH7760
 	bool "Support SH7760 processor"
 	select CPU_SH4
+#    select ARCH_REQUIRE_GPIOLIB
 
 config CPU_SUBTYPE_SH4_202
 	bool "Support SH4-202 processor"
diff -ruN linux-2.6.28.2-orig/arch/sh/kernel/cpu/sh4/softfloat.c linux-2.6.28.2/arch/sh/kernel/cpu/sh4/softfloat.c
--- linux-2.6.28.2-orig/arch/sh/kernel/cpu/sh4/softfloat.c	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/arch/sh/kernel/cpu/sh4/softfloat.c	2009-05-02 09:52:58.000000000 -0500
@@ -652,27 +652,6 @@
 	*z0Ptr = a0 - b0 - (a1 < b1);
 }
 
-static bits64 estimateDiv128To64(bits64 a0, bits64 a1, bits64 b)
-{
-	bits64 b0, b1;
-	bits64 rem0, rem1, term0, term1;
-	bits64 z;
-	if (b <= a0)
-		return LIT64(0xFFFFFFFFFFFFFFFF);
-	b0 = b >> 32;
-	z = (b0 << 32 <= a0) ? LIT64(0xFFFFFFFF00000000) : (a0 / b0) << 32;
-	mul64To128(b, z, &term0, &term1);
-	sub128(a0, a1, term0, term1, &rem0, &rem1);
-	while (((sbits64) rem0) < 0) {
-		z -= LIT64(0x100000000);
-		b1 = b << 32;
-		add128(rem0, rem1, b0, b1, &rem0, &rem1);
-	}
-	rem0 = (rem0 << 32) | (rem1 >> 32);
-	z |= (b0 << 32 <= rem0) ? 0xFFFFFFFF : rem0 / b0;
-	return z;
-}
-
 inline void mul64To128(bits64 a, bits64 b, bits64 * z0Ptr, bits64 * z1Ptr)
 {
 	bits32 aHigh, aLow, bHigh, bLow;
@@ -696,6 +675,27 @@
 
 }
 
+static bits64 estimateDiv128To64(bits64 a0, bits64 a1, bits64 b)
+{
+	bits64 b0, b1;
+	bits64 rem0, rem1, term0, term1;
+	bits64 z;
+	if (b <= a0)
+		return LIT64(0xFFFFFFFFFFFFFFFF);
+	b0 = b >> 32;
+	z = (b0 << 32 <= a0) ? LIT64(0xFFFFFFFF00000000) : (a0 / b0) << 32;
+	mul64To128(b, z, &term0, &term1);
+	sub128(a0, a1, term0, term1, &rem0, &rem1);
+	while (((sbits64) rem0) < 0) {
+		z -= LIT64(0x100000000);
+		b1 = b << 32;
+		add128(rem0, rem1, b0, b1, &rem0, &rem1);
+	}
+	rem0 = (rem0 << 32) | (rem1 >> 32);
+	z |= (b0 << 32 <= rem0) ? 0xFFFFFFFF : rem0 / b0;
+	return z;
+}
+
 static void normalizeFloat32Subnormal(bits32 aSig, int16 * zExpPtr,
 				      bits32 * zSigPtr)
 {
diff -ruN linux-2.6.28.2-orig/arch/sh/kernel/Makefile_32 linux-2.6.28.2/arch/sh/kernel/Makefile_32
--- linux-2.6.28.2-orig/arch/sh/kernel/Makefile_32	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/arch/sh/kernel/Makefile_32	2009-05-02 09:52:58.000000000 -0500
@@ -23,6 +23,10 @@
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_IO_TRAPPED)	+= io_trapped.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
+
+ifneq ($(CONFIG_SH_JCINAP7760),y)
 obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
+endif
 
 EXTRA_CFLAGS += -Werror
+
diff -ruN linux-2.6.28.2-orig/arch/sh/kernel/timers/timer-tmu.c linux-2.6.28.2/arch/sh/kernel/timers/timer-tmu.c
--- linux-2.6.28.2-orig/arch/sh/kernel/timers/timer-tmu.c	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/arch/sh/kernel/timers/timer-tmu.c	2009-05-02 09:52:58.000000000 -0500
@@ -146,6 +146,16 @@
 	_tmu_clear_status(TMU0);
 	_tmu_set_irq(TMU0,tmu0_clockevent.mode != CLOCK_EVT_MODE_ONESHOT);
 
+#ifdef CONFIG_SH_JCINAP7760
+#define PBCR 0xFE400004
+#define PBDR 0xFE400044
+#define PTB5 0x20
+    /* Check if the Cobra watchdog bit is set as an output. If not don't toggle the line. */
+    if ((ctrl_inw(PBCR) & 0x0C00) == 0x0400) {
+        ctrl_outb(ctrl_inb(PBDR) ^ PTB5, PBDR);   /* Toggle watchdog bit. */
+    }
+#endif
+
 	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
diff -ruN linux-2.6.28.2-orig/arch/sh/tools/mach-types linux-2.6.28.2/arch/sh/tools/mach-types
--- linux-2.6.28.2-orig/arch/sh/tools/mach-types	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/arch/sh/tools/mach-types	2009-05-02 09:52:58.000000000 -0500
@@ -30,6 +30,7 @@
 SNAPGEAR		SH_SECUREEDGE5410
 EDOSK7705		SH_EDOSK7705
 EDOSK7760		SH_EDOSK7760
+JCINAP7760		SH_JCINAP7760
 SH4202_MICRODEV		SH_SH4202_MICRODEV
 SH03			SH_SH03
 LANDISK			SH_LANDISK
diff -ruN linux-2.6.28.2-orig/drivers/input/touchscreen/ads7846.c linux-2.6.28.2/drivers/input/touchscreen/ads7846.c
--- linux-2.6.28.2-orig/drivers/input/touchscreen/ads7846.c	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/drivers/input/touchscreen/ads7846.c	2009-05-02 09:52:58.000000000 -0500
@@ -29,7 +29,7 @@
 #include <linux/spi/ads7846.h>
 #include <asm/irq.h>
 
-
+#define VERBOSE 1   /* DLL20090427 */
 /*
  * This code has been heavily tested on a Nokia 770, and lightly
  * tested on other ads7846 devices (OSK/Mistral, Lubbock).
@@ -953,7 +953,7 @@
 	input_dev->phys = ts->phys;
 	input_dev->dev.parent = &spi->dev;
 
-	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS) | BIT_MASK(EV_SYN);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 	input_set_abs_params(input_dev, ABS_X,
 			pdata->x_min ? : 0,
diff -ruN linux-2.6.28.2-orig/drivers/spi/Kconfig linux-2.6.28.2/drivers/spi/Kconfig
--- linux-2.6.28.2-orig/drivers/spi/Kconfig	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/drivers/spi/Kconfig	2009-05-02 09:52:58.000000000 -0500
@@ -100,6 +100,14 @@
 	  inexpensive battery powered microcontroller evaluation board.
 	  This same cable can be used to flash new firmware.
 
+config SPI_HSPI
+	tristate "SuperH on-chip HSPI controller"
+	depends on SPI_MASTER && SUPERH
+	select SPI_BITBANG
+	help
+	  Driver for the Hitachi HSPI controller core found on various
+	  SuperH processors.
+
 config SPI_IMX
 	tristate "Freescale iMX SPI controller"
 	depends on ARCH_IMX && EXPERIMENTAL
diff -ruN linux-2.6.28.2-orig/drivers/spi/Makefile linux-2.6.28.2/drivers/spi/Makefile
--- linux-2.6.28.2-orig/drivers/spi/Makefile	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/drivers/spi/Makefile	2009-05-02 09:52:58.000000000 -0500
@@ -29,6 +29,7 @@
 obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
 obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
 obj-$(CONFIG_SPI_SH_SCI)		+= spi_sh_sci.o
+obj-$(CONFIG_SPI_HSPI)			+= spi_hspi.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
diff -ruN linux-2.6.28.2-orig/drivers/spi/spi_hspi.c linux-2.6.28.2/drivers/spi/spi_hspi.c
--- linux-2.6.28.2-orig/drivers/spi/spi_hspi.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.28.2/drivers/spi/spi_hspi.c	2009-05-02 09:52:58.000000000 -0500
@@ -0,0 +1,434 @@
+/*
+ * SuperH on-chip SPI (HSPI) controller driver.
+ *
+ * (c) 2008 Manuel Lauss <mano <at> roarinelk.homelinux.net>
+ *
+ * largely based on spi_s3c24xx.
+ *
+ * This program is licensed under the terms outlined in the file COPYING
+ * in the root of this archive.
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+
+#include <asm/clock.h>
+#include <asm/spi_hspi.h>
+
+#define SPCR	0x00			/* control */
+#define SPSR	0x04			/* status */
+#define SPSCR	0x08			/* sys control */
+#define SPTBR	0x0c			/* tx fifo port */
+#define SPRBR	0x10			/* rx fifo port */
+
+#define SPCR_FBS	(1 << 7)	/* CPHA */
+#define SPCR_CLKP	(1 << 6)	/* CPOL */
+#define SPCR_IDIV	(1 << 5)	/* clock prescaler: 4, 32*/
+#define SPCR_CLKMASK	0x1f
+
+#define SPSR_TXFU	(1 << 10)	/* tx fifo full */
+#define SPSR_TXHA	(1 << 9)	/* tx fifo half */
+#define SPSR_TXEM	(1 << 8)	/* tx fifo empty */
+#define SPSR_RXFU	(1 << 7)	/* rx fifo full */
+#define SPSR_RXHA	(1 << 6)	/* rx fifo half */
+#define SPSR_RXEM	(1 << 5)	/* rx fifo empty */
+#define SPSR_RXOO	(1 << 4)	/* rx overrun */
+#define SPSR_RXOW	(1 << 3)	/* rx overrun warning */
+#define SPSR_RXFL	(1 << 2)	/* new rx byte */
+#define SPSR_TXFN	(1 << 1)	/* tx complete */
+#define SPSR_TXFL	(1 << 0)	/* tx buffer not empty */
+
+#define SPSCR_TEIE	(1 << 13)	/* tx fifo empty */
+#define SPSCR_THIE	(1 << 12)	/* tx fifo half full */
+#define SPSCR_RNIE	(1 << 11)	/* rx fifo not-empty */
+#define SPSCR_RHIE	(1 << 10)	/* rx fifo half full */
+#define SPSCR_RFIE	(1 << 9)	/* rx fifo full */
+#define SPSCR_FFEN	(1 << 8)	/* fifo enable */
+#define SPSCR_LMSB	(1 << 7)	/* MSB/LSB first */
+#define SPSCR_CSV	(1 << 6)	/* CS pin polarity */
+#define SPSCR_CSA	(1 << 5)	/* auto CS control enable */
+#define SPSCR_TFIE	(1 << 4)	/* 1-byte-tx'ed int */
+#define SPSCR_ROIE	(1 << 3)	/* rx overflow ints */
+#define SPSCR_RXDE	(1 << 2)	/* rx dma enable */
+#define SPSCR_TXDE	(1 << 1)	/* tx dma enable */
+#define SPSCR_MASL	(1 << 0)	/* master(1) / slave(0) select */
+
+#define SPSCR_IMASK (SPSCR_TEIE | SPSCR_THIE | SPSCR_RNIE | SPSCR_RHIE | \
+		     SPSCR_RFIE | SPSCR_TFIE | SPSCR_ROIE)
+
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST)
+
+#define FIFO_SIZE	8
+
+struct hspi_priv {
+	struct spi_bitbang bitbang;
+	void __iomem *io;
+
+	/* data buffers */
+	const unsigned char	*tx;
+	unsigned char		*rx;
+	int			 len;
+	int			 count;
+
+	unsigned long spcr;
+	unsigned long spscr;
+
+	struct completion done;
+
+	int irq;
+
+	struct device *dev;
+	struct resource *ioarea;
+	struct spi_master *master;
+	struct hspi_platdata *pd;
+};
+
+static inline void hspi_platcs(struct hspi_priv *priv, int cs, int pol)
+{
+	if (priv->pd && priv->pd->set_cs)
+		priv->pd->set_cs(priv->pd, cs, pol);
+}
+
+static inline struct hspi_priv *to_priv(struct spi_device *sdev)
+{
+	return spi_master_get_devdata(sdev->master);
+}
+
+static void hspi_chipsel(struct spi_device *spi, int value)
+{
+	struct hspi_priv *priv = to_priv(spi);
+	unsigned int cspol = spi->mode & SPI_CS_HIGH ? 1 : 0;
+
+	if (cspol)
+		priv->spscr |= SPSCR_CSV;
+	else
+		priv->spscr &= ~SPSCR_CSV;
+
+	switch (value) {
+	case BITBANG_CS_INACTIVE:
+		if (cspol^1)
+			priv->spscr |= SPSCR_CSV;
+		else
+			priv->spscr &= ~SPSCR_CSV;
+
+		hspi_platcs(priv, spi->chip_select, cspol^1);
+		break;
+
+	case BITBANG_CS_ACTIVE:
+		if (spi->mode & SPI_CPHA)
+			priv->spcr |= SPCR_FBS;
+		else
+			priv->spcr &= ~SPCR_FBS;
+
+		if (spi->mode & SPI_CPOL)
+			priv->spcr |= SPCR_CLKP;
+		else
+			priv->spcr &= ~SPCR_CLKP;
+
+		if (spi->mode & SPI_LSB_FIRST)
+			priv->spscr |= SPSCR_LMSB;
+		else
+			priv->spscr &= ~SPSCR_LMSB;
+
+		hspi_platcs(priv, spi->chip_select, cspol);
+
+		if (cspol)
+			priv->spscr |= SPSCR_CSV;
+		else
+			priv->spscr &= ~SPSCR_CSV;
+
+		break;
+	}
+	priv->spscr |= SPSCR_CSA;		/* DLL20090419 */
+	iowrite32(priv->spcr, priv->io + SPCR);
+	iowrite32(priv->spscr, priv->io + SPSCR);
+}
+
+static int hspi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct hspi_priv *priv = to_priv(spi);
+	struct clk *clk;
+	unsigned int bpw, hz, div;
+
+	bpw = t ? t->bits_per_word : spi->bits_per_word;
+	hz  = t ? t->speed_hz : spi->max_speed_hz;
+
+	if (bpw != 8) {
+		dev_err(&spi->dev, "invalid bits-per-word (%d)\n", bpw);
+		return -EINVAL;
+	}
+
+	clk = clk_get(NULL, "module_clk");
+	if (!clk)
+		return -EINVAL;
+
+    /* HSPI peripheral clock is module_clk divided by 4 or 32;
+	 * SPI bus clock is HSPI clock prescaled by 2..64.
+	 * spiclk = (module_clk / 4) / (2 .. 64) or
+	 * spiclk = (module_clk / 32) / (2 .. 64)
+	 */
+	div = (clk->rate / 4) / hz;
+	priv->spcr &= ~(SPCR_IDIV | SPCR_CLKMASK);
+
+	if (div < 2)
+		div = 2;
+	if (div > 512)
+		div = 512;	/* hmm, maybe warn? */
+
+	if (div >= 64) {
+		priv->spcr |= SPCR_IDIV;	/* pclk/32 instead of 4 */
+		div /= 8;
+	}
+
+	priv->spcr |= ((div >> 1) - 1) & SPCR_CLKMASK;
+
+	dev_dbg(&spi->dev, "mclk %lu hz %d spcr %08lux\n", clk->rate, hz,
+		priv->spcr);
+
+	clk_put(clk);
+
+	iowrite32(priv->spcr, priv->io + SPCR);
+
+	spin_lock(&priv->bitbang.lock);
+	if (!priv->bitbang.busy) {
+		priv->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
+		/* need to ndelay for 0.5 clocktick ? */
+	}
+	spin_unlock(&priv->bitbang.lock);
+
+	return 0;
+}
+
+static int hspi_setup(struct spi_device *spi)
+{
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	if (spi->mode & ~MODEBITS) {
+		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
+		return -EINVAL;
+	}
+
+	return hspi_setupxfer(spi, NULL);
+}
+
+static inline unsigned int priv_txbyte(struct hspi_priv *priv, int count)
+{
+	return priv->tx ? priv->tx[count] : 0;
+}
+
+static int hspi_txrx(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct hspi_priv *priv = to_priv(spi);
+
+	priv->tx = t->tx_buf;
+	priv->rx = t->rx_buf;
+	priv->len = t->len;
+	priv->count = 0;
+
+	/* master mode, FIFO enabled +  some interesting IRQs */	
+	priv->spscr |= SPSCR_FFEN | SPSCR_RNIE | SPSCR_ROIE | SPSCR_MASL;
+	iowrite32(priv->spscr, priv->io + SPSCR);
+
+	/* change the SPCR register contents to trigger a FIFO reset */
+	iowrite32(priv->spcr & ~SPCR_CLKMASK, priv->io + SPCR);
+	iowrite32(priv->spcr, priv->io + SPCR);
+
+	init_completion(&priv->done);
+
+	/* write first byte in TX fifo */
+	iowrite32(priv_txbyte(priv, priv->count), priv->io + SPTBR);
+
+	wait_for_completion(&priv->done);
+
+	priv->spscr = SPSCR_FFEN | SPSCR_CSA | SPSCR_MASL;        /* Was set to zero - DLL20090419 */
+	iowrite32(priv->spscr, priv->io + SPSCR);
+
+	return priv->count;
+}
+
+static irqreturn_t hspi_master_irq(int irq, void *data)
+{
+	struct hspi_priv *priv = data;
+	unsigned long spsr = ioread32(priv->io + SPSR);
+	unsigned int count = priv->count;
+	unsigned char bucket;
+
+	dev_dbg(priv->dev, "spsr %08lux len %d count %d\n", spsr,
+		priv->len, priv->count);
+
+	if (spsr & SPSR_RXOO) {
+		dev_dbg(priv->dev, "RX overrun\n");
+		goto out;
+	}
+
+	if (spsr & SPSR_RXOW)
+		dev_dbg(priv->dev, "RX overrun warning!!\n");
+
+	/* then it's RNIE: RX fifo not empty */
+	priv->count++;
+	if (priv->rx)
+		priv->rx[count] = ioread32(priv->io + SPRBR);
+    else
+        bucket = ioread32(priv->io + SPRBR);     /* Just eat the value */
+
+	count++;
+	if (count < priv->len)
+		iowrite32(priv_txbyte(priv, count), priv->io + SPTBR);
+	else {
+out:
+		priv->spscr &= ~SPSCR_IMASK;
+		iowrite32(priv->spscr, priv->io + SPSCR);
+		complete(&priv->done);
+	}
+
+	iowrite32(0, priv->io + SPSR);		/* ack RXOs */
+	return IRQ_HANDLED;
+}
+
+static int __devinit hspi_probe(struct platform_device *pdev)
+{
+	struct hspi_priv *priv;
+	struct resource *r;
+	struct spi_master *master;
+	int ret;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(&pdev->dev, "No MMIO\n");
+		ret = -ENODEV;
+		goto out0;
+	}
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct hspi_priv));
+	if (!master) {
+		dev_err(&pdev->dev, "No memory for spi_master\n");
+		ret = -ENOMEM;
+		goto out0;
+	}
+
+	priv = spi_master_get_devdata(master);
+	memset(priv, 0, sizeof(struct hspi_priv));
+
+	priv->master = master;
+	priv->dev = &pdev->dev;
+	priv->pd = pdev->dev.platform_data;
+
+	priv->irq = platform_get_irq(pdev, 0);
+	if (priv->irq < 0) {
+		dev_err(&pdev->dev, "No IRQ\n");
+		ret = -ENODEV;
+		goto out1;
+	}
+
+	priv->ioarea = request_mem_region(r->start, r->end - r->start,
+					  pdev->name);
+	if (!priv->ioarea) {
+		dev_err(&pdev->dev, "MMIO alread in use\n");
+		ret = -EBUSY;
+		goto out1;
+	}
+
+	priv->io = ioremap(r->start, r->end - r->start + 1);
+	if (!priv->io) {
+		dev_err(&pdev->dev, "cannot ioremap mmio\n");
+		ret = -EBUSY;
+		goto out2;
+	}
+
+	iowrite32(0, priv->io + SPCR);
+	iowrite32(SPSCR_CSA, priv->io + SPSCR);	/* Was set to zero - DLL20090419 */
+	iowrite32(0, priv->io + SPSR);
+
+	ret = request_irq(priv->irq, hspi_master_irq, 0, pdev->name, priv);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot grab IRQ\n");
+		goto out3;
+	}
+
+	master->num_chipselect = priv->pd ? priv->pd->num_cs : 1;
+	master->bus_num = pdev->id;
+	master->setup = hspi_setup;
+
+	priv->bitbang.master = master;
+	priv->bitbang.setup_transfer = hspi_setupxfer;
+	priv->bitbang.chipselect = hspi_chipsel;
+	priv->bitbang.txrx_bufs = hspi_txrx;
+
+	ret = spi_bitbang_start(&priv->bitbang);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register SPI master\n");
+		goto out4;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+out4:
+	free_irq(priv->irq, priv);
+out3:
+	iounmap(priv->io);
+out2:
+	release_resource(priv->ioarea);
+	kfree(priv->ioarea);
+out1:
+	spi_master_put(priv->master);
+out0:
+	return ret;
+}
+
+static int __devexit hspi_remove(struct platform_device *pdev)
+{
+	struct hspi_priv *priv = platform_get_drvdata(pdev);
+
+	spi_bitbang_stop(&priv->bitbang);
+	iowrite32(0, priv->io + SPCR);
+	iowrite32(0, priv->io + SPSCR);
+	iowrite32(0, priv->io + SPSR);
+	free_irq(priv->irq, priv);
+	iounmap(priv->io);
+	release_resource(priv->ioarea);
+	kfree(priv->ioarea);
+	spi_master_put(priv->master);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver hspi_driver = {
+	.driver = {
+		.name	= "spi_hspi",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= hspi_probe,
+	.remove		= hspi_remove,
+};
+
+static int __init hspi_init(void)
+{
+	return platform_driver_register(&hspi_driver);
+}
+
+static void __exit hspi_exit(void)
+{
+	platform_driver_unregister(&hspi_driver);
+}
+
+module_init(hspi_init);
+module_exit(hspi_exit);
+
+MODULE_AUTHOR("Manuel Lauss");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SuperH on-chip SPI (HSPI) Controller driver");
+MODULE_ALIAS("platform:spi_hspi");
diff -ruN linux-2.6.28.2-orig/drivers/usb/host/ohci-hcd.c linux-2.6.28.2/drivers/usb/host/ohci-hcd.c
--- linux-2.6.28.2-orig/drivers/usb/host/ohci-hcd.c	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/drivers/usb/host/ohci-hcd.c	2009-05-02 09:52:58.000000000 -0500
@@ -1049,6 +1049,7 @@
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7760) || \
     defined(CONFIG_CPU_SUBTYPE_SH7763)
 #include "ohci-sh.c"
 #define PLATFORM_DRIVER		ohci_hcd_sh_driver
diff -ruN linux-2.6.28.2-orig/drivers/usb/host/ohci-sh.c linux-2.6.28.2/drivers/usb/host/ohci-sh.c
--- linux-2.6.28.2-orig/drivers/usb/host/ohci-sh.c	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/drivers/usb/host/ohci-sh.c	2009-05-02 09:52:58.000000000 -0500
@@ -26,6 +26,11 @@
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
 
+#ifdef CONFIG_CPU_SUBTYPE_SH7760
+    dma_declare_coherent_memory(hcd->self.controller, (dma_addr_t)0xfe341000, 
+        (dma_addr_t)0x0, 0x2000, DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+#endif
+
 	ohci_hcd_init(ohci);
 	ohci_init(ohci);
 	ohci_run(ohci);
@@ -42,8 +47,11 @@
 	 * generic hardware linkage
 	 */
 	.irq =			ohci_irq,
+#ifndef CONFIG_CPU_SUBTYPE_SH7760
 	.flags =		HCD_USB11 | HCD_MEMORY,
-
+#else
+    .flags =		HCD_USB11 | HCD_MEMORY | HCD_LOCAL_MEM,
+#endif
 	/*
 	 * basic lifecycle operations
 	 */
diff -ruN linux-2.6.28.2-orig/drivers/usb/Kconfig linux-2.6.28.2/drivers/usb/Kconfig
--- linux-2.6.28.2-orig/drivers/usb/Kconfig	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/drivers/usb/Kconfig	2009-05-02 09:52:58.000000000 -0500
@@ -46,6 +46,7 @@
 	# SH:
 	default y if CPU_SUBTYPE_SH7720
 	default y if CPU_SUBTYPE_SH7721
+	default y if CPU_SUBTYPE_SH7760
 	default y if CPU_SUBTYPE_SH7763
 	# more:
 	default PCI
diff -ruN linux-2.6.28.2-orig/drivers/video/sh7760fb.c linux-2.6.28.2/drivers/video/sh7760fb.c
--- linux-2.6.28.2-orig/drivers/video/sh7760fb.c	2009-01-24 18:42:07.000000000 -0600
+++ linux-2.6.28.2/drivers/video/sh7760fb.c	2009-05-02 16:04:11.000000000 -0500
@@ -148,12 +148,16 @@
 	}
 
 	while (l && (s < 256)) {
+#ifdef CONFIG_SH_JCINAP7760
+		/* The JCI NAP platform (used by CCS) has weird wiring at the LCD panel. */
+		col = (((*r >> 8) >> 3) & 0x18) |	(((*g >> 8) << 5) & 0x1c00) | ((*b >> 8) & 0xe0);
+#else
 		col = ((*r) & 0xff) << 16;
 		col |= ((*g) & 0xff) << 8;
 		col |= ((*b) & 0xff);
+#endif
 		col &= SH7760FB_PALETTE_MASK;
 		iowrite32(col, par->base + LDPR(s));
-
 		if (s < 16)
 			((u32 *) (info->pseudo_palette))[s] = s;
 
@@ -487,6 +491,24 @@
 	return 0;
 }
 
+#ifdef CONFIG_SH_JCINAP7760
+/*
+ * This routine takes an 8 bit color channel value and transforms it       
+ * to match the color that will electronically result at the LCCS 1.0 LCD  
+ * panel. In this way the palette's colors will exactly match what you will
+ * see at the hardware.                                                    
+ */
+inline u16 adjust_for_NAP_palette_wiring(u16 color, int using_3_bits)
+{
+    u16 adj_color = color;
+    if (color & 0x80)
+        adj_color |= (using_3_bits ? 0x0A : 0x2A);
+    if (color & 0x40)
+        adj_color |= 0x15;
+    return adj_color;
+}
+#endif
+
 static int __devinit sh7760fb_probe(struct platform_device *pdev)
 {
 	struct fb_info *info;
@@ -579,7 +601,32 @@
 		dev_dbg(info->dev, "Unable to allocate cmap memory\n");
 		goto out_mem;
 	}
-
+#ifdef CONFIG_SH_JCINAP7760
+	/* We need a special palette tuned to the weird NAP panel wiring. */
+	{
+		int i;
+		for (i=0; i < info->cmap.len; i++) {
+			u16 red=0, green=0, blue=0;
+			/* Isolating 3 bits for Blue */
+			blue = i & 0xE0;
+			/* Isolating 3 bits for green */
+			green = i & 0x1C;
+			green = (green << 3);
+			/* Isolating 2 bits for red */
+			red = i & 0x03;
+			red = (red << 6);
+
+			blue = adjust_for_NAP_palette_wiring(blue, 1);
+			green = adjust_for_NAP_palette_wiring(green, 1);
+			red = adjust_for_NAP_palette_wiring(red, 0);
+
+			/* Final adjustments to Linux's fb palette 16 bit color values. */
+			info->cmap.red[i] = red << 8;
+			info->cmap.green[i] = green << 8;
+			info->cmap.blue[i] = blue << 8;
+		}
+	}
+#endif
 	ret = register_framebuffer(info);
 	if (ret < 0) {
 		dev_dbg(info->dev, "cannot register fb!\n");
diff -ruN linux-2.6.28.2-orig/include/asm-sh/spi_hspi.h linux-2.6.28.2/include/asm-sh/spi_hspi.h
--- linux-2.6.28.2-orig/include/asm-sh/spi_hspi.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.28.2/include/asm-sh/spi_hspi.h	2009-05-02 09:52:58.000000000 -0500
@@ -0,0 +1,13 @@
+/*
+ * platform data for spi_hspi driver.
+ */
+
+#ifndef _SPI_HSPI_H_
+#define _SPI_HSPI_H_
+
+struct hspi_platdata {
+	int num_cs;
+	void(*set_cs)(struct hspi_platdata *pd, int cs, int pol);
+};
+
+#endif

--------------080909080505000108090306--
