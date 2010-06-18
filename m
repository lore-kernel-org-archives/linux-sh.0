From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Date: Fri, 18 Jun 2010 11:01:12 +0000
Subject: [PATCH v4 1/4] Add the directory mach-sh2007 for SH-2007 board support
Message-Id: <1276858875-10548-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds directory for SH-2007 support and modify tools/mach-types.
mach-sh2007/setup.c ... Setup platform devices and provide machine vector.
tools/mach-types ... Added entry of SH2007 for mach_is_sh2007()

v2:
 * Pending onboardio.c, for dip switch reading and LED manipulating.
   Because these deviced should be treated in more unified way
   such as LED device class. Creating /dev/dipsw is dirty.
   But the LED device is not physical device, it exists logicaly.
   I'm pending my decision about treating dip switch and logical LED temporary.
 * Cleaning. setup.c of v1 did lots of non board specific
   (processor specific) things. According to Paul's advice, I reduced them.
   And sh2007_init_irq() uses interrupt setting of 7780 specific.

v3:
 * According to Magnus's advice, removed meaningless function release_platform_dev()
   and #if 0 ... #endif for IDE support.
 * This patch contains Nobuhiro-san's one to generate mach_is_sh2007() in include/generated/machtypes.h

v4:
 * My plan to obtain IDE cable for 2.5 inch IDE is failed,
   I cannot predict when I can test IDE disk support of SH-2007.
   So I disabled IDE support with #if ... #endif.

Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
---
 arch/sh/boards/mach-sh2007/Makefile |    1 +
 arch/sh/boards/mach-sh2007/setup.c  |  317 +++++++++++++++++++++++++++++++++++
 arch/sh/tools/mach-types            |    1 +
 3 files changed, 319 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/boards/mach-sh2007/Makefile
 create mode 100644 arch/sh/boards/mach-sh2007/setup.c

diff --git a/arch/sh/boards/mach-sh2007/Makefile b/arch/sh/boards/mach-sh2007/Makefile
new file mode 100644
index 0000000..2b9dba4
--- /dev/null
+++ b/arch/sh/boards/mach-sh2007/Makefile
@@ -0,0 +1 @@
+obj-y += setup.o
diff --git a/arch/sh/boards/mach-sh2007/setup.c b/arch/sh/boards/mach-sh2007/setup.c
new file mode 100644
index 0000000..72bd51b
--- /dev/null
+++ b/arch/sh/boards/mach-sh2007/setup.c
@@ -0,0 +1,317 @@
+/*
+ * linux/arch/sh/kernel/setup_sh2007.c
+ *
+ * Copyright (C) 2003,2004 SUGIOKA Toshinobu
+ * Ported to Linux 2.6.34 by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/ide.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/smsc911x.h>
+#include <linux/platform_device.h>
+#include <linux/ata_platform.h>
+
+#include <asm/io.h>
+#include <asm/machvec.h>
+#include <asm/rtc.h>
+#include <asm/cacheflush.h>
+#include <asm/addrspace.h>
+
+#include "../../drivers/pci/pci-sh7780.h"
+
+#define INTEVT		0xff000028
+#define CPUOPM		0xff2f0000
+#define IRMCR		0xff000078
+#define CS5BCR		0xff802050
+#define CS5WCR		0xff802058
+#define CS5PCR		0xff802070
+
+#define BUS_SZ8		1
+#define BUS_SZ16	2
+#define BUS_SZ32	3
+
+#define PCMCIA_IODYN	1
+#define PCMCIA_ATA	0
+#define PCMCIA_IO8	2
+#define PCMCIA_IO16	3
+#define PCMCIA_COMM8	4
+#define PCMCIA_COMM16	5
+#define PCMCIA_ATTR8	6
+#define PCMCIA_ATTR16	7
+
+#define TYPE_SRAM	0
+#define TYPE_PCMCIA	4
+
+/* write-read/write-write delay (0-7:0,1,2,3,4,5,6,7) */
+#define IWW5		0
+#define IWW6		3
+/* different area, read-write delay (0-7:0,1,2,3,4,5,6,7) */
+#define IWRWD5		2
+#define IWRWD6		2
+/* same area, read-write delay (0-7:0,1,2,3,4,5,6,7) */
+#define IWRWS5		2
+#define IWRWS6		2
+/* different area, read-read delay (0-7:0,1,2,3,4,5,6,7) */
+#define IWRRD5		2
+#define IWRRD6		2
+/* same area, read-read delay (0-7:0,1,2,3,4,5,6,7) */
+#define IWRRS5		0
+#define IWRRS6		2
+/* burst count (0-3:4,8,16,32) */
+#define BST5		0
+#define BST6		0
+/* bus size */
+#define SZ5		BUS_SZ16
+#define SZ6		BUS_SZ16
+/* RD hold for SRAM (0-1:0,1) */
+#define RDSPL5		0
+#define RDSPL6		0
+/* Burst pitch (0-7:0,1,2,3,4,5,6,7) */
+#define BW5		0
+#define BW6		0
+/* Multiplex (0-1:0,1) */
+#define MPX5		0
+#define MPX6		0
+/* device type */
+#define TYPE5		TYPE_PCMCIA
+#define TYPE6		TYPE_PCMCIA
+/* address setup before assert CSn for SRAM (0-7:0,1,2,3,4,5,6,7) */
+#define ADS5		0
+#define ADS6		0
+/* address hold after negate CSn for SRAM (0-7:0,1,2,3,4,5,6,7) */
+#define ADH5		0
+#define ADH6		0
+/* CSn assert to RD assert delay for SRAM (0-7:0,1,2,3,4,5,6,7) */
+#define RDS5		0
+#define RDS6		0
+/* RD negate to CSn negate delay for SRAM (0-7:0,1,2,3,4,5,6,7) */
+#define RDH5		0
+#define RDH6		0
+/* CSn assert to WE assert delay for SRAM (0-7:0,1,2,3,4,5,6,7) */
+#define WTS5		0
+#define WTS6		0
+/* WE negate to CSn negate delay for SRAM (0-7:0,1,2,3,4,5,6,7) */
+#define WTH5		0
+#define WTH6		0
+/* BS hold (0-1:1,2) */
+#define BSH5		0
+#define BSH6		0
+/* wait cycle (0-15:0,1,2,3,4,5,6,7,8,9,11,13,15,17,21,25) */
+#define IW5		6	/* 60ns PIO mode 4 */
+#define IW6		15	/* 250ns */
+
+#define SAA5		PCMCIA_IODYN	/* IDE area b4000000-b5ffffff */
+#define SAB5		PCMCIA_IODYN	/* CF  area b6000000-b7ffffff */
+#define PCWA5		0	/* additional wait A (0-3:0,15,30,50) */
+#define PCWB5		0	/* additional wait B (0-3:0,15,30,50) */
+/* wait B (0-15:0,1,2,3,4,5,6,7,8,9,11,13,15,17,21,25) */
+#define PCIW5		12
+/* Address->OE/WE assert delay A (0-7:0,1,2,3,6,9,12,15) */
+#define TEDA5		2
+/* Address->OE/WE assert delay B (0-7:0,1,2,3,6,9,12,15) */
+#define TEDB5		4
+/* OE/WE negate->Address delay A (0-7:0,1,2,3,6,9,12,15) */
+#define TEHA5		2
+/* OE/WE negate->Address delay B (0-7:0,1,2,3,6,9,12,15) */
+#define TEHB5		3
+
+#define CS5BCR_D	((IWW5<<28)|(IWRWD5<<24)|(IWRWS5<<20)|		\
+			(IWRRD5<<16)|(IWRRS5<<12)|(BST5<<10)|		\
+			(SZ5<<8)|(RDSPL5<<7)|(BW5<<4)|(MPX5<<3)|TYPE5)
+#define CS5WCR_D	((ADS5<<28)|(ADH5<<24)|(RDS5<<20)|	\
+			(RDH5<<16)|(WTS5<<12)|(WTH5<<8)|(BSH5<<4)|IW5)
+#define CS5PCR_D	((SAA5<<28)|(SAB5<<24)|(PCWA5<<22)|		\
+			(PCWB5<<20)|(PCIW5<<16)|(TEDA5<<12)|		\
+			(TEDB5<<8)|(TEHA5<<4)|TEHB5)
+
+#define SMC0_BASE       0xb0800000      /* eth0 */
+#define SMC1_BASE       0xb0900000      /* eth1 */
+#define CF_BASE         0xb6100000      /* Compact Flash (I/O area) */
+#define IDE_BASE        0xb4000000      /* IDE */
+#define PC104_IO_BASE   0xb8000000
+#define PC104_MEM_BASE  0xba000000
+#define SMC_IO_SIZE     0x100
+
+#define CF_OFFSET       0x1f0
+#define IDE_OFFSET      0x170
+
+struct smsc911x_platform_config smc911x_info = {
+	.flags		= SMSC911X_USE_32BIT,
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
+};
+
+static struct resource smsc9118_0_resources[] = {
+	[0] = {
+		.start	= SMC0_BASE,
+		.end	= SMC0_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x240),
+		.end	= evt2irq(0x240),
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct resource smsc9118_1_resources[] = {
+	[0] = {
+		.start	= SMC1_BASE,
+		.end	= SMC1_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x280),
+		.end	= evt2irq(0x280),
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device smsc9118_0_device = {
+	.name		= "smsc911x",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(smsc9118_0_resources),
+	.resource	= smsc9118_0_resources,
+	.dev = {
+		.platform_data = &smc911x_info,
+	},
+};
+
+static struct platform_device smsc9118_1_device = {
+	.name		= "smsc911x",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(smsc9118_1_resources),
+	.resource	= smsc9118_1_resources,
+	.dev = {
+		.platform_data = &smc911x_info,
+	},
+};
+
+static struct resource cf_resources[] = {
+	[0] = {
+		.start	= CF_BASE + CF_OFFSET,
+		.end	= CF_BASE + CF_OFFSET + 0x0f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= CF_BASE + CF_OFFSET + 0x206,
+		.end	= CF_BASE + CF_OFFSET + 0x20f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= evt2irq(0x2c0),
+		.end	= evt2irq(0x2c0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct pata_platform_info cf_info = {
+};
+
+static struct platform_device cf_device  = {
+	.name		= "pata_platform",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(cf_resources),
+	.resource	= cf_resources,
+	.dev = {
+		.platform_data = &cf_info,
+	},
+};
+
+/*
+ * FIXME:
+ * I cannot test IDE of SH-2007.
+ * If you have SH-2007 and can test IDE,
+ * please define IDE_TESTED as 1.
+ *
+ * And if your SH-2007 can treat IDE disk well,
+ * please email to mitake@dcl.info.waseda.ac.jp and linux-sh@vger.kernel.org
+ */
+
+#define IDE_TESTED 0
+#if IDE_TESTED
+static struct resource ide_resources[] = {
+	[0] = {
+		.start	= IDE_BASE + IDE_OFFSET,
+		.end	= IDE_BASE + IDE_OFFSET + 0x0f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IDE_BASE + IDE_OFFSET + 0x206,
+		.end	= IDE_BASE + IDE_OFFSET + 0x20f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= evt2irq(0x300),
+		.end	= evt2irq(0x300),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+
+static struct pata_platform_info ide_info = {
+};
+
+static struct platform_device ide_device  = {
+	.name		= "pata_platform",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(ide_resources),
+	.resource	= ide_resources,
+	.dev = {
+		.platform_data = &ide_info,
+	},
+};
+#endif
+
+static struct platform_device *sh2007_devices[] __initdata = {
+	&smsc9118_0_device,
+	&smsc9118_1_device,
+	&cf_device,
+#if IDE_TESTED
+	&ide_device,
+#endif
+};
+
+static int __init sh2007_io_init(void)
+{
+	platform_add_devices(sh2007_devices, ARRAY_SIZE(sh2007_devices));
+	return 0;
+}
+subsys_initcall(sh2007_io_init);
+
+static void __init sh2007_init_irq(void)
+{
+	plat_irq_setup_pins(IRQ_MODE_IRQ);
+}
+
+/*
+ * Initialize the board
+ */
+static void __init sh2007_setup(char **cmdline_p)
+{
+	printk(KERN_INFO "SH-2007 Setup...");
+
+	/* setup wait control registers for area 5 */
+	__raw_writel(CS5BCR_D, CS5BCR);
+	__raw_writel(CS5WCR_D, CS5WCR);
+	__raw_writel(CS5PCR_D, CS5PCR);
+
+	printk(KERN_INFO " done.\n");
+}
+
+/*
+ * The Machine Vector
+ */
+struct sh_machine_vector mv_sh2007 __initmv = {
+	.mv_setup		= sh2007_setup,
+	.mv_name		= "sh2007",
+	.mv_init_irq		= sh2007_init_irq,
+};
diff --git a/arch/sh/tools/mach-types b/arch/sh/tools/mach-types
index b25aa55..9504d74 100644
--- a/arch/sh/tools/mach-types
+++ b/arch/sh/tools/mach-types
@@ -60,3 +60,4 @@ ESPT			SH_ESPT
 POLARIS			SH_POLARIS
 KFR2R09			SH_KFR2R09
 ECOVEC			SH_ECOVEC
+SH2007			SH_SH2007
-- 
1.6.5.2

