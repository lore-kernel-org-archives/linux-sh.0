From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Dec 2009 12:30:14 +0000
Subject: [PATCH 04/07] sh: sh4 scif pdata (sh7750/sh7760/sh4-202)
Message-Id: <20091214123014.10707.47411.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch breaks out the sh4 scif serial port platform
data from a shared platform device to one platform
device per port. Also, add serial ports to the list of
early platform devices.

While at it, get rid of the R2D ifdef in the processor
code and adjust the defconfigs to use ttySC1.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/configs/rts7751r2d1_defconfig    |    2 
 arch/sh/configs/rts7751r2dplus_defconfig |    2 
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c   |   23 +++----
 arch/sh/kernel/cpu/sh4/setup-sh7750.c    |   47 +++++++++------
 arch/sh/kernel/cpu/sh4/setup-sh7760.c    |   89 ++++++++++++++++++++----------
 5 files changed, 100 insertions(+), 63 deletions(-)

--- 0001/arch/sh/configs/rts7751r2d1_defconfig
+++ work/arch/sh/configs/rts7751r2d1_defconfig	2009-12-14 20:37:06.000000000 +0900
@@ -324,7 +324,7 @@ CONFIG_ENTRY_OFFSET=0x00001000
 # CONFIG_UBC_WAKEUP is not set
 CONFIG_CMDLINE_OVERWRITE=y
 # CONFIG_CMDLINE_EXTEND is not set
-CONFIG_CMDLINE="console=tty0 console=ttySC0,115200 root=/dev/sda1 earlyprintk=serial"
+CONFIG_CMDLINE="console=tty0 console=ttySC1,115200 root=/dev/sda1"
 
 #
 # Bus options
--- 0001/arch/sh/configs/rts7751r2dplus_defconfig
+++ work/arch/sh/configs/rts7751r2dplus_defconfig	2009-12-14 20:37:25.000000000 +0900
@@ -324,7 +324,7 @@ CONFIG_ENTRY_OFFSET=0x00001000
 # CONFIG_UBC_WAKEUP is not set
 CONFIG_CMDLINE_OVERWRITE=y
 # CONFIG_CMDLINE_EXTEND is not set
-CONFIG_CMDLINE="console=tty0 console=ttySC0,115200 root=/dev/sda1 earlyprintk=serial"
+CONFIG_CMDLINE="console=tty0 console=ttySC1,115200 root=/dev/sda1"
 
 #
 # Bus options
--- 0001/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh4-202.c	2009-12-14 20:43:37.000000000 +0900
@@ -15,22 +15,18 @@
 #include <linux/sh_timer.h>
 #include <linux/io.h>
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffe80000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 40, 41, 43, 42 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe80000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 40, 41, 43, 42 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif0_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 0,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif0_platform_data,
 	},
 };
 
@@ -127,7 +123,7 @@ static struct platform_device tmu2_devic
 };
 
 static struct platform_device *sh4202_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
@@ -141,6 +137,7 @@ static int __init sh4202_devices_setup(v
 arch_initcall(sh4202_devices_setup);
 
 static struct platform_device *sh4202_early_devices[] __initdata = {
+	&scif0_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
--- 0001/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh7750.c	2009-12-14 20:38:40.000000000 +0900
@@ -35,29 +35,33 @@ static struct platform_device rtc_device
 	.resource	= rtc_resources,
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-#ifndef CONFIG_SH_RTS7751R2D
-		.mapbase	= 0xffe00000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCI,
-		.irqs		= { 23, 23, 23, 0 },
-	}, {
-#endif
-		.mapbase	= 0xffe80000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 40, 40, 40, 40 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe00000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCI,
+	.irqs		= { 23, 23, 23, 0 },
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
+	},
 };
 
-static struct platform_device sci_device = {
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xffe80000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 40, 40, 40, 40 },
+};
+
+static struct platform_device scif1_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 1,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif1_platform_data,
 	},
 };
 
@@ -221,8 +225,9 @@ static struct platform_device tmu4_devic
 #endif
 
 static struct platform_device *sh7750_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
 	&rtc_device,
-	&sci_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
@@ -242,6 +247,8 @@ static int __init sh7750_devices_setup(v
 arch_initcall(sh7750_devices_setup);
 
 static struct platform_device *sh7750_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
--- 0001/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh7760.c	2009-12-14 20:42:23.000000000 +0900
@@ -126,37 +126,63 @@ static struct intc_vect vectors_irq[] __
 static DECLARE_INTC_DESC(intc_desc_irq, "sh7760-irq", vectors_irq, groups,
 			 mask_registers, prio_registers, NULL);
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xfe600000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 52, 53, 55, 54 },
-	}, {
-		.mapbase	= 0xfe610000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 72, 73, 75, 74 },
-	}, {
-		.mapbase	= 0xfe620000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 76, 77, 79, 78 },
-	}, {
-		.mapbase	= 0xfe480000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCI,
-		.irqs		= { 80, 81, 82, 0 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xfe600000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 52, 53, 55, 54 },
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
+	},
+};
+
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xfe610000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 72, 73, 75, 74 },
+};
+
+static struct platform_device scif1_device = {
+	.name		= "sh-sci",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &scif1_platform_data,
+	},
+};
+
+static struct plat_sci_port scif2_platform_data = {
+	.mapbase	= 0xfe620000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 76, 77, 79, 78 },
+};
+
+static struct platform_device scif2_device = {
+	.name		= "sh-sci",
+	.id		= 2,
+	.dev		= {
+		.platform_data	= &scif2_platform_data,
+	},
+};
+
+static struct plat_sci_port scif3_platform_data = {
+	.mapbase	= 0xfe480000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCI,
+	.irqs		= { 80, 81, 82, 0 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif3_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 3,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif3_platform_data,
 	},
 };
 
@@ -254,7 +280,10 @@ static struct platform_device tmu2_devic
 
 
 static struct platform_device *sh7760_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
@@ -268,6 +297,10 @@ static int __init sh7760_devices_setup(v
 arch_initcall(sh7760_devices_setup);
 
 static struct platform_device *sh7760_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
