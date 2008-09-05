From: Luca Santini <luca.santini@spesonline.com>
Date: Fri, 05 Sep 2008 14:14:20 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <48C13EBC.4020409@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I finally made eth work with these changes...


Paul please check if my changes to setup-sh7760.c are ok,
many thanks to Magnus and Manuel.

Luca Santini





diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index ae19486..8a84c18 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -180,6 +180,13 @@ config SH_SH7763RDP
  	  Select SH7763RDP if configuring for a Renesas SH7763
  	  evaluation board.

+config SH_EDOSK7760
+	bool "EDOSK7760"
+	depends on CPU_SUBTYPE_SH7760
+	help
+	  Select if configuring for a Renesas edosk7760
+	  evaluation board.
+
  config SH_EDOSK7705
  	bool "EDOSK7705"
  	depends on CPU_SUBTYPE_SH7705
diff --git a/arch/sh/boards/Makefile b/arch/sh/boards/Makefile
index 463022c..d9efa39 100644
--- a/arch/sh/boards/Makefile
+++ b/arch/sh/boards/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_SH_MAGIC_PANEL_R2)	+= board-magicpanelr2.o
  obj-$(CONFIG_SH_RSK7203)	+= board-rsk7203.o
  obj-$(CONFIG_SH_SH7785LCR)	+= board-sh7785lcr.o
  obj-$(CONFIG_SH_SHMIN)		+= board-shmin.o
+obj-$(CONFIG_SH_EDOSK7760)	+= board-edosk7760.o
diff --git a/arch/sh/boards/board-edosk7760.c 
b/arch/sh/boards/board-edosk7760.c
new file mode 100644
index 0000000..82f76d1
--- /dev/null
+++ b/arch/sh/boards/board-edosk7760.c
@@ -0,0 +1,184 @@
+/*
+ *
+ * Renesas Europe EDOSK7760 Board Support
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
+ *
+ * Copyright (C) 2008 SPES Societa' Progettazione Elettronica e 
Software Ltd.
+ * Author: Luca Santini <luca.santini@spesonline.com>
+ *
+ */
+
+/* Bus state controller registers for CS4 area */
+#define BSC_CS4BCR    0xA4FD0010
+#define BSC_CS4WCR    0xA4FD0030
+
+#define SMC_IOBASE  0xA2000000
+#define SMC_IO_OFFSET 0x300
+#define SMC_IOADDR	SMC_IOBASE + SMC_IO_OFFSET
+#define ETHERNET_IRQ 5
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <linux/smc91x.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <asm/machvec.h>
+#include <asm/io.h>
+#include <asm/addrspace.h>
+#include <asm/delay.h>
+#include <asm/i2c-sh7760.h>
+
+
+/* i2c initialization functions */
+
+static struct sh7760_i2c_platdata i2c_pd = {
+        .speed_khz      = 400,
+};
+
+static struct resource sh7760_i2c1_res[] = {
+        {
+                .start  = SH7760_I2C1_MMIO,
+                .end    = SH7760_I2C1_MMIOEND,
+                .flags  = IORESOURCE_MEM,
+        },{
+                .start  = SH7760_I2C1_IRQ,
+                .end    = SH7760_I2C1_IRQ,
+                .flags  = IORESOURCE_IRQ,
+        },
+};
+
+static struct platform_device sh7760_i2c1_dev = {
+        .dev    = {
+                .platform_data  = &i2c_pd,
+        },
+        .name           = SH7760_I2C_DEVNAME,
+        .id             = 1,
+        .resource       = sh7760_i2c1_res,
+        .num_resources  = ARRAY_SIZE(sh7760_i2c1_res),
+};
+
+
+static struct resource sh7760_i2c0_res[] = {
+        {
+                .start  = SH7760_I2C0_MMIO,
+                .end    = SH7760_I2C0_MMIOEND,
+                .flags  = IORESOURCE_MEM,
+        },{
+                .start  = SH7760_I2C0_IRQ,
+                .end    = SH7760_I2C0_IRQ,
+                .flags  = IORESOURCE_IRQ,
+        },
+};
+
+static struct platform_device sh7760_i2c0_dev = {
+        .dev    = {
+                .platform_data  = &i2c_pd,
+        },
+        .name           = SH7760_I2C_DEVNAME,
+        .id             = 0,
+        .resource       = sh7760_i2c0_res,
+        .num_resources  = ARRAY_SIZE(sh7760_i2c0_res),
+};
+
+/* eth initialization functions */
+
+static struct smc91x_platdata smc91x_info = {
+	.flags = SMC91X_USE_16BIT | SMC91X_IO_SHIFT_1 | IORESOURCE_IRQ_LOWLEVEL,
+};
+
+static struct resource smc91x_res[] = {
+        [0] = {
+		.start  = SMC_IOADDR,
+		.end    = SMC_IOADDR + 0x1f,
+		.flags  = IORESOURCE_MEM,
+        },
+        [1] = {
+		.start  = ETHERNET_IRQ,
+		.end    = ETHERNET_IRQ,
+		.flags  = IORESOURCE_IRQ ,
+        }
+};
+
+static struct platform_device smc91x_dev = {
+
+        .name           = "smc91x",
+        .id             = -1,
+        .num_resources  = ARRAY_SIZE(smc91x_res),
+        .resource       = smc91x_res,
+		.dev	= {
+			.platform_data	= &smc91x_info,
+		},
+
+};
+
+/* platform init code */
+
+static struct platform_device *edosk7760_devices[] __initdata = {
+	&sh7760_i2c0_dev,
+	&sh7760_i2c1_dev,
+#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
+	&smc91x_dev,
+#endif
+	
+};
+
+static int __init init_edosk7760_devices(void)
+{
+ 	plat_irq_setup_pins(IRQ_MODE_IRQ);
+	return platform_add_devices(edosk7760_devices, 
ARRAY_SIZE(edosk7760_devices));
+}
+__initcall(init_edosk7760_devices);
+
+/*
+ * The Machine Vector
+ */
+struct sh_machine_vector mv_edosk7760 __initmv = {
+	.mv_name	= "EDOSK7760",
+	.mv_nr_irqs	= 128,
+};
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c 
b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
index 254c5c5..cccd9a3 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -9,6 +9,7 @@
   */
  #include <linux/platform_device.h>
  #include <linux/init.h>
+#include <linux/io.h>
  #include <linux/serial.h>
  #include <linux/serial_sci.h>

@@ -178,10 +179,15 @@ static int __init sh7760_devices_setup(void)
  }
  __initcall(sh7760_devices_setup);

+#define INTC_ICR	0xffd00000UL
+#define INTC_ICR_IRLM   (1<<7)
+
+
  void __init plat_irq_setup_pins(int mode)
  {
  	switch (mode) {
  	case IRQ_MODE_IRQ:
+		ctrl_outw(ctrl_inw(INTC_ICR) | INTC_ICR_IRLM, INTC_ICR);
  		register_intc_controller(&intc_desc_irq);
  		break;
  	default:
diff --git a/drivers/net/smc91x.h b/drivers/net/smc91x.h
index 997e7f1..edea073 100644
--- a/drivers/net/smc91x.h
+++ b/drivers/net/smc91x.h
@@ -446,6 +446,8 @@ static inline void LPD7_SMC_outsw (unsigned char* a, 
int r,
  #define SMC_CAN_USE_32BIT	1
  #define SMC_NOWAIT		1

+#define SMC_IO_SHIFT		(lp->io_shift)
+
  #define SMC_inb(a, r)		readb((a) + (r))
  #define SMC_inw(a, r)		readw((a) + (r))
  #define SMC_inl(a, r)		readl((a) + (r))


