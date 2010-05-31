From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Date: Mon, 31 May 2010 07:59:53 +0000
Subject: [PATCH 1/4] Add the directory mach-sh2007 for SH-2007 board support
Message-Id: <1275292796-26602-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds files for SH-2007 support.
onboardio.c ... Create /dev/dipsw. This file is for reading state of dip switch
	    	and writing power and error LED.
		(LEDs are pseudo things.)
setup.c	    ... Setup platform devices and provide machine vector.

Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
---
 arch/sh/boards/mach-sh2007/Makefile    |    1 +
 arch/sh/boards/mach-sh2007/onboardio.c |  156 +++++++++++
 arch/sh/boards/mach-sh2007/setup.c     |  477 ++++++++++++++++++++++++++++++++
 3 files changed, 634 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/boards/mach-sh2007/Makefile
 create mode 100644 arch/sh/boards/mach-sh2007/onboardio.c
 create mode 100644 arch/sh/boards/mach-sh2007/setup.c

diff --git a/arch/sh/boards/mach-sh2007/Makefile b/arch/sh/boards/mach-sh2007/Makefile
new file mode 100644
index 0000000..714b6e8
--- /dev/null
+++ b/arch/sh/boards/mach-sh2007/Makefile
@@ -0,0 +1 @@
+obj-y += setup.o onboardio.o
diff --git a/arch/sh/boards/mach-sh2007/onboardio.c b/arch/sh/boards/mach-sh2007/onboardio.c
new file mode 100644
index 0000000..3ac242a
--- /dev/null
+++ b/arch/sh/boards/mach-sh2007/onboardio.c
@@ -0,0 +1,156 @@
+/*
+ * SH-2007 onboard IO interface for Linux
+ *
+ * Copyright (C) 2007 Nakamura Soichiro
+ * Ported to Linux 2.6.34 by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
+ *
+ */
+
+#define PIO_IO_EXTENT	  0x8
+#define ONBOARDIO_VERSION "1.0"
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/ioport.h>
+#include <linux/fcntl.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+#define PIO_READ		0xc001
+#define PIO_WRITE		0xc002
+#define	ONBOARD_IO_MINOR	100
+
+#define	DIPSW	0xb0000000
+#define	PWRLED	0xb0300000
+#define	ERRLED	0xb0400000
+
+#define ONBOARD_IO_IS_OPEN	0	/* means /dev/pio is in use	*/
+
+static unsigned long pio_status;
+static unsigned long pio_open_c;
+
+static int pio_ioctl(struct inode *inode, struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	u32 val, addr;
+
+	switch (cmd) {
+	case PIO_READ:	/* Read the value */
+		if (copy_from_user(&addr, (void *)arg, sizeof(unsigned long)))
+			return -EFAULT;
+		val = readl(DIPSW);
+		if (copy_to_user((void *)arg, &val, sizeof(u32)))
+			return -EFAULT;
+		break;
+	case PIO_WRITE:	/* Store a value into the PIO */
+		if (copy_from_user(&val, (void *)arg, sizeof(unsigned long)))
+			return -EFAULT;
+		if (val & 0x100)
+			writel(val & 1, ERRLED);
+		else
+			writel(val & 1, PWRLED);
+		break;
+	default:
+		return -EINVAL;
+		break;
+	}
+	return 0;
+}
+
+static int pio_open(struct inode *inode, struct file *file)
+{
+	int flg;
+
+	if (!pio_open_c) {
+		flg = test_and_set_bit(ONBOARD_IO_IS_OPEN, &pio_status) ?
+			-EBUSY : 0;
+		if (!flg)
+			pio_open_c++;
+		return flg;
+	} else {
+		pio_open_c++;
+		return 0;
+	}
+}
+
+static int pio_release(struct inode *inode, struct file *file)
+{
+	if (--pio_open_c)
+		return 0;
+
+	clear_bit(ONBOARD_IO_IS_OPEN, &pio_status);
+	return 0;
+}
+
+/*
+ *	The various file operations we support.
+ */
+static const struct file_operations pio_fops = {
+	.owner = THIS_MODULE,
+	.ioctl = pio_ioctl,
+	.open = pio_open,
+	.release = pio_release,
+};
+
+static struct miscdevice pio_dev = {
+	ONBOARD_IO_MINOR,
+	"dipsw",
+	&pio_fops
+};
+
+static int __init pio_init(void)
+{
+	printk(KERN_INFO "SH2007 PIO Driver v" ONBOARDIO_VERSION "\n");
+	misc_register(&pio_dev);
+	return 0;
+}
+
+static void __exit pio_exit(void)
+{
+	misc_deregister(&pio_dev);
+}
+
+module_init(pio_init);
+module_exit(pio_exit);
+MODULE_LICENSE("GPL");
+
+#if 0
+
+/* Dip switch reader */
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/fcntl.h>
+
+#include <assert.h>
+
+#define PIO_READ		0xc001
+#define PIO_WRITE		0xc002
+
+int main(void)
+{
+	int dipfd;
+	int i, val;
+
+	dipfd = open("/dev/dipsw", O_RDWR);
+	assert(dipfd > 0);
+
+	ioctl(dipfd, PIO_READ, &val);
+	printf("Dip switch: ");
+	for (i = 0; i < 8; i++)
+		printf("%d", (val >> i) & 1);
+	printf("\n");
+
+	return 0;
+}
+
+#endif
diff --git a/arch/sh/boards/mach-sh2007/setup.c b/arch/sh/boards/mach-sh2007/setup.c
new file mode 100644
index 0000000..1f21a17
--- /dev/null
+++ b/arch/sh/boards/mach-sh2007/setup.c
@@ -0,0 +1,477 @@
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
+#define BUS_SZ8		1
+#define BUS_SZ16	2
+#define BUS_SZ32	3
+#define TYPE_SRAM	0
+#define TYPE_PCMCIA	4
+#define PCMCIA_ATA	0
+#define PCMCIA_IODYN	1
+#define PCMCIA_IO8	2
+#define PCMCIA_IO16	3
+#define PCMCIA_COMM8	4
+#define PCMCIA_COMM16	5
+#define PCMCIA_ATTR8	6
+#define PCMCIA_ATTR16	7
+
+#define INTC_BASE	0xffd00000
+#define INTC_ICR0	(INTC_BASE+0x0)
+#define INTC_ICR1	(INTC_BASE+0x1c)
+#define INTC_INTPRI	(INTC_BASE+0x10)
+#define INTC_INTREQ	(INTC_BASE+0x24)
+#define INTC_INTMSK0	(INTC_BASE+0x44)
+#define INTC_INTMSK1	(INTC_BASE+0x48)
+#define INTC_INTMSK2	(INTC_BASE+0x40080)
+#define INTC_INTMSKCLR0	(INTC_BASE+0x64)
+#define INTC_INTMSKCLR1	(INTC_BASE+0x68)
+#define INTC_INTMSKCLR2	(INTC_BASE+0x40084)
+#define INTC_NMIFCR	(INTC_BASE+0xc0)
+#define INTC_USERIMASK	(INTC_BASE+0x30000)
+
+#define	INTC_INT2PRI0	(INTC_BASE+0x40000)
+#define	INTC_INT2PRI1	(INTC_BASE+0x40004)
+#define	INTC_INT2PRI2	(INTC_BASE+0x40008)
+#define	INTC_INT2PRI3	(INTC_BASE+0x4000c)
+#define	INTC_INT2PRI4	(INTC_BASE+0x40010)
+#define	INTC_INT2PRI5	(INTC_BASE+0x40014)
+#define	INTC_INT2PRI6	(INTC_BASE+0x40018)
+#define	INTC_INT2PRI7	(INTC_BASE+0x4001c)
+#define	INTC_INT2A0	(INTC_BASE+0x40030)
+#define	INTC_INT2A1	(INTC_BASE+0x40034)
+#define	INTC_INT2MSKR	(INTC_BASE+0x40038)
+#define	INTC_INT2MSKCR	(INTC_BASE+0x4003c)
+#define	INTC_INT2B0	(INTC_BASE+0x40040)
+#define	INTC_INT2B1	(INTC_BASE+0x40044)
+#define	INTC_INT2B2	(INTC_BASE+0x40048)
+#define	INTC_INT2B3	(INTC_BASE+0x4004c)
+#define	INTC_INT2B4	(INTC_BASE+0x40050)
+#define	INTC_INT2B5	(INTC_BASE+0x40054)
+#define	INTC_INT2B6	(INTC_BASE+0x40058)
+#define	INTC_INT2B7	(INTC_BASE+0x4005c)
+#define	INTC_INT2GPIC	(INTC_BASE+0x40090)
+
+#define FALLING_EDGE	0
+#define RISING_EDGE	1
+#define LOW_LEVEL	2
+#define HIGH_LEVEL	3
+#define IRQ0S		HIGH_LEVEL	/* LAN */
+#define IRQ1S		HIGH_LEVEL	/* LAN */
+#define IRQ2S		HIGH_LEVEL	/* CF */
+#define IRQ3S		HIGH_LEVEL	/* IDE */
+#define IRQ4S		RISING_EDGE	/* EXT IRQ3 */
+#define IRQ5S		RISING_EDGE	/* EXT IRQ4 */
+#define IRQ6S		RISING_EDGE	/* EXT IRQ5 */
+#define IRQ7S		RISING_EDGE	/* EXT IRQ7 */
+#define	ICR1_DATA	((IRQ0S<<30)|(IRQ1S<<28)|(IRQ2S<<26)|	\
+			(IRQ3S<<24)|(IRQ4S<<22)|(IRQ5S<<20)|	\
+			(IRQ6S<<18)|(IRQ7S<<16))
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
+#define IRQ_SMC0        12
+#define IRQ_SMC1        13
+#define IRQ_CFCARD      14
+#define IRQ_IDE         15
+
+#define WTCNT           0xffc00008
+#define WTCSR           0xffc0000c
+#define WTCNT_HIGH      0x5a00
+#define WTCSR_HIGH      0xa500
+
+#define WTCSR_TME       0x80
+#define WTCSR_WT        0x40
+#define WTCSR_RSTS      0x20
+#define WTCSR_WOVF      0x10
+#define WTCSR_IOVF      0x08
+#define WTCSR_CKS2      0x04
+#define WTCSR_CKS1      0x02
+#define WTCSR_CKS0      0x01
+
+static void release_platform_dev(struct device *dev)
+{
+	dev->parent = NULL;
+}
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
+		.start	= IRQ_SMC0,
+		.end	= IRQ_SMC0,
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
+		.start	= IRQ_SMC1,
+		.end	= IRQ_SMC1,
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
+		.release       = release_platform_dev,
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
+		.release       = release_platform_dev,
+		.platform_data = &smc911x_info,
+	},
+};
+
+static struct resource cf_resources[] = {
+	[0] = {
+		.start	= CF_OFFSET,
+		.end	= CF_OFFSET + 0x0f,
+		.flags	= IORESOURCE_IO,
+	},
+	[1] = {
+		.start	= CF_OFFSET + 0x206,
+		.end	= CF_OFFSET + 0x20f,
+		.flags	= IORESOURCE_IO,
+	},
+	[2] = {
+		.start	= IRQ_CFCARD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct pata_platform_info cf_info = {
+	.ioport_shift	= 0,
+};
+
+static struct platform_device cf_device  = {
+	.name		= "pata_platform",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(cf_resources),
+	.resource	= cf_resources,
+	.dev	= {
+		.platform_data	= &cf_info,
+	},
+};
+
+static struct resource ide_resources[] = {
+	[0] = {
+		.start	= IDE_OFFSET,
+		.end	= IDE_OFFSET + 0x0f,
+		.flags	= IORESOURCE_IO,
+	},
+	[1] = {
+		.start	= IDE_OFFSET + 0x206,
+		.end	= IDE_OFFSET + 0x20f,
+		.flags	= IORESOURCE_IO,
+	},
+	[2] = {
+		.start	= IRQ_IDE,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct pata_platform_info ide_info = {
+	.ioport_shift	= 0,
+};
+
+static struct platform_device ide_device  = {
+	.name		= "pata_platform",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(ide_resources),
+	.resource	= ide_resources,
+	.dev	= {
+		.platform_data	= &ide_info,
+	},
+};
+
+static struct platform_device *sh2007_devices[] __initdata = {
+	&smsc9118_0_device,
+	&smsc9118_1_device,
+	&cf_device,
+	&ide_device,
+};
+
+int __init sh2007_io_init(void)
+{
+	platform_add_devices(sh2007_devices, ARRAY_SIZE(sh2007_devices));
+	return 0;
+}
+subsys_initcall(sh2007_io_init);
+
+#define CF_PORT(x)	((x & ~0xffff020f) = CF_OFFSET)
+#define IDE_PORT(x)	((x & ~0xffff020f) = IDE_OFFSET)
+#define PCI_PORT(x)	(x >= 0xfe000000 && x < 0xfe400000)
+
+static void __iomem *sh2007_ioport_map(unsigned long offset, unsigned int size)
+{
+	if (PCI_PORT(offset))
+		return (void __iomem *)offset;
+	if (IDE_PORT(offset))	/* IDE (160-16f, 360-36f) */
+		return (void __iomem *)(IDE_BASE + (offset & 0xffff));
+	if (CF_PORT(offset))	/* Compact Flash (1f0-1ff, 3f0-3ff) */
+		return (void __iomem *)(CF_BASE + (offset & 0xffff));
+	offset &= 0x01ffffff;
+	return (void __iomem *)(PC104_IO_BASE + offset);
+}
+
+#define IODELAY()	ndelay(200)
+
+static int sh2007_irq_remap[] = {
+	IRQ_SMC0,	/* nIRL0 */
+	IRQ_SMC1,	/* nIRL1 */
+	IRQ_CFCARD,	/* nIRL2 */
+	IRQ_IDE,	/* nIRL3 */
+	3,		 /* nIRL4 (PC104 IRQ3) */
+	4,		/* nIRL5 (PC104 IRQ4) */
+	5,		/* nIRL6 (PC104 IRQ5) */
+	7,		/* nIRL7 (PC104 IRQ7) */
+};
+
+static int sh2007_irq_demux(int irq)
+{
+	if ((unsigned int)irq < 15) {
+		irq = ((irq>>1)-1) & 7;
+		irq = sh2007_irq_remap[irq];
+	}
+	return irq;
+}
+
+/* Support for external interrupt pins in IRQ mode */
+enum {IRQ0 = 1, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7};
+static struct intc_vect irq_vectors[] __initdata = {
+	INTC_IRQ(IRQ0, IRQ_SMC0),
+	INTC_IRQ(IRQ1, IRQ_SMC1),
+	INTC_IRQ(IRQ2, IRQ_CFCARD),
+	INTC_IRQ(IRQ3, IRQ_IDE),
+	INTC_IRQ(IRQ4, 3),
+	INTC_IRQ(IRQ5, 4),
+	INTC_IRQ(IRQ6, 5),
+	INTC_IRQ(IRQ7, 7),
+};
+
+static struct intc_mask_reg irq_mask_registers[] __initdata = {
+	{ INTC_INTMSK0, INTC_INTMSKCLR0, 32,
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static struct intc_prio_reg irq_prio_registers[] __initdata = {
+	{ INTC_INTPRI, 0, 32, 4,
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static struct intc_sense_reg irq_sense_registers[] __initdata = {
+	{ INTC_ICR1, 32, 2,
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static struct intc_mask_reg irq_ack_registers[] __initdata = {
+	{ INTC_INTREQ, 0, 32,
+	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
+};
+
+static DECLARE_INTC_DESC_ACK(intc_irq_desc, "sh7780-irq", irq_vectors,
+			NULL, irq_mask_registers, irq_prio_registers,
+			irq_sense_registers, irq_ack_registers);
+
+static void __init sh2007_init_irq(void)
+{
+	/* INTC SH-4 compatible Mode */
+	ctrl_outl(0x00e00000, INTC_ICR0);
+	/* individual interrupt level sense type */
+	ctrl_outl(ICR1_DATA, INTC_ICR1);
+	/* mask IRL0-7 individual Interrupt */
+	ctrl_outl(0xff000000, INTC_INTMSK0);
+	/* mask IRL4-7 encoded interrupt */
+	ctrl_outl(0xff000000, INTC_INTMSK1);
+	/* mask IRL0-7 encoded interrupt */
+	ctrl_outl(0xfffefffe, INTC_INTMSK2);
+	ctrl_inl(INTC_INTREQ);
+	/* clear all edge sense interrupt request */
+	ctrl_outl(0x00000000, INTC_INTREQ);
+
+	register_intc_controller(&intc_irq_desc);
+}
+
+/*
+ * Initialize the board
+ */
+static void __init sh2007_setup(char **cmdline_p)
+{
+	printk(KERN_INFO "SH-2007 Setup...");
+	/* clear user interrupt mask */
+	ctrl_outl(0x00000000, INTC_USERIMASK);
+	/* disable all module interrupt */
+	ctrl_outl(0xffffffff, INTC_INT2MSKR);
+
+	/* setup wait control registers for area 5 */
+	ctrl_outl(CS5BCR_D, CS5BCR);
+	ctrl_outl(CS5WCR_D, CS5WCR);
+	ctrl_outl(CS5PCR_D, CS5PCR);
+
+	ctrl_outl(ctrl_inl(CPUOPM) & ~0x20, CPUOPM);	/* drop RABD bit */
+	ctrl_outl(0, IRMCR);
+	asm volatile ("icbi @%0" : : "r"(0xa0000000));
+	printk(KERN_INFO "done.\n");
+}
+
+/*
+ * The Machine Vector
+ */
+struct sh_machine_vector mv_sh2007 __initmv = {
+	.mv_setup		= sh2007_setup,
+	.mv_name		= "sh2007",
+	.mv_nr_irqs		= NR_IRQS,
+
+	.mv_init_irq		= sh2007_init_irq,
+	.mv_irq_demux		= sh2007_irq_demux,
+	.mv_ioport_map		= sh2007_ioport_map,
+};
-- 
1.6.5.2

