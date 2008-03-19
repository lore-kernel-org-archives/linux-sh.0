From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Wed, 19 Mar 2008 14:16:57 +0000
Subject: [PATCH] sh: Add support for Solution Engine SH7721 board
Message-Id: <47E12059.4020302@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for Solution Engine SH7721 board(MS7721RP01).

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/Kconfig                  |    9
 arch/sh/Makefile                 |    1
 arch/sh/boards/se/7721/Makefile  |   10
 arch/sh/boards/se/7721/io.c      |  223 +++++
 arch/sh/boards/se/7721/irq.c     |   86 ++
 arch/sh/boards/se/7721/setup.c   |  119 +++
 arch/sh/configs/se7721_defconfig | 1086 +++++++++++++++++++++++++++++
 arch/sh/kernel/cf-enabler.c      |    9
 arch/sh/tools/mach-types         |    1
 include/asm-sh/se7721.h          |   71 +
 10 files changed, 1612 insertions(+), 3 deletions(-)

diff -uprN a/arch/sh/boards/se/7721/io.c b/arch/sh/boards/se/7721/io.c
--- a/arch/sh/boards/se/7721/io.c	1970-01-01 09:00:00.000000000 +0900
+++ b/arch/sh/boards/se/7721/io.c	2008-03-19 23:12:00.000000000 +0900
@@ -0,0 +1,223 @@
+/*
+ * I/O routine for SH7721 SolutionEngine.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <asm/se.h>
+#include <asm/io.h>
+
+#define badio(fn, a) panic("bad i/o operation %s for %08lx.", #fn, a)
+
+struct iop {
+	unsigned long base;
+	struct iop *(*check) (struct iop *p, unsigned long port);
+	u8 (*inb) (struct iop *p, unsigned long port);
+	u16 (*inw) (struct iop *p, unsigned long port);
+	void (*outb) (struct iop *p, u8 value, unsigned long port);
+	void (*outw) (struct iop *p, u16 value, unsigned long port);
+};
+
+static struct iop *ide_check(struct iop *p, unsigned long port)
+{
+	if (((PA_MRSHPC_IO + 0x1f0) <= port &&
+	      port < (PA_MRSHPC_IO + 0x1f8)) || port = (PA_MRSHPC_IO + 0x3f6))
+		return p;
+	else
+		return NULL;
+}
+
+u8 pcc_inb(struct iop *p, unsigned long port)
+{
+	return ctrl_inb(p->base + port + 0x40000);
+}
+
+u16 pcc_inw(struct iop *p, unsigned long port)
+{
+	return ctrl_inw(p->base + port);
+}
+
+void pcc_outb(struct iop *p, u8 value, unsigned long port)
+{
+	ctrl_outb(value, p->base + port + 0x40000);
+}
+
+void pcc_outw(struct iop *p, u16 value, unsigned long port)
+{
+	ctrl_outw(value, p->base + port);
+}
+
+static struct iop cfiop = {
+	.base	= 0x00000000,
+	.check	= ide_check,
+	.inb	= pcc_inb,
+	.inw	= pcc_inw,
+	.outb	= pcc_outb,
+	.outw	= pcc_outw,
+};
+
+static struct iop *port2iop(unsigned long port)
+{
+	if (cfiop.check(&cfiop, port))
+		return &cfiop;
+	else
+		return NULL;
+}
+
+u8 se7721_inb(unsigned long port)
+{
+	struct iop *p = port2iop(port);
+
+	if (p)
+		return (p->inb)(p, port);
+	else
+		return ctrl_inb(port);
+}
+
+u8 se7721_inb_p(unsigned long port)
+{
+	u8 v = se7721_inb(port);
+
+	ctrl_delay();
+
+	return v;
+}
+
+u16 se7721_inw(unsigned long port)
+{
+	struct iop *p = port2iop(port);
+
+	if (p)
+		return (p->inw)(p, port);
+	else
+		return ctrl_inw(port);
+}
+
+u32 se7721_inl(unsigned long port)
+{
+	return ctrl_inl(port);
+}
+
+void se7721_outb(u8 value, unsigned long port)
+{
+	struct iop *p = port2iop(port);
+
+	if (p)
+		(p->outb)(p, value, port);
+	else
+		ctrl_outb(value, port);
+}
+
+void se7721_outb_p(u8 value, unsigned long port)
+{
+	se7721_outb(value, port);
+	ctrl_delay();
+}
+
+void se7721_outw(u16 value, unsigned long port)
+{
+	struct iop *p = port2iop(port);
+
+	if (p)
+		(p->outw)(p, value, port);
+	else
+		ctrl_outw(value, port);
+}
+
+void se7721_outl(unsigned int value, unsigned long port)
+{
+	ctrl_outl(value, port);
+}
+
+void se7721_insb(unsigned long port, void *addr, unsigned long count)
+{
+	u8 *a = addr;
+	struct iop *p = port2iop(port);
+
+	if (p) {
+		while (count--)
+			*a++ = (p->inb)(p, port);
+	} else {
+		while (count--)
+			*a++ = ctrl_inb(port);
+	}
+}
+
+void se7721_insw(unsigned long port, void *addr, unsigned long count)
+{
+	u16 *a = addr;
+	struct iop *p = port2iop(port);
+
+	if (p) {
+		while (count--)
+			*a++ = (p->inw)(p, port);
+	} else {
+		while (count--)
+			*a++ = ctrl_inw(port);
+	}
+}
+
+void se7721_insl(unsigned long port, void *addr, unsigned long count)
+{
+	u32 *a = addr;
+
+	while (count--)
+		*a++ = ctrl_inl(port);
+}
+
+void se7721_outsb(unsigned long port, const void *addr, unsigned long count)
+{
+	const u8 *a = (unsigned char *)addr;
+	struct iop *p = port2iop(port);
+
+	if (p) {
+		while (count--)
+			(p->outb)(p, *a++, port);
+	} else {
+		while (count--)
+			ctrl_outb(*a++, port);
+	}
+}
+
+void se7721_outsw(unsigned long port, const void *addr, unsigned long count)
+{
+	const u16 *a = (unsigned short *)addr;
+	struct iop *p = port2iop(port);
+
+	if (p) {
+		while (count--)
+			(p->outw)(p, *a++, port);
+	} else {
+		while (count--)
+			ctrl_outw(*a++, port);
+	}
+}
+
+void se7721_outsl(unsigned long port, const void *addr, unsigned long count)
+{
+	const u32 *a = (u32 *)addr;
+
+	while (count--)
+		ctrl_outl(*a++, port);
+}
+
+u8 se7721_readb(void __iomem *addr)
+{
+	if (((PA_MRSHPC_IO + 0x1f0) <= (unsigned long)addr &&
+	    (unsigned long)addr < (PA_MRSHPC_IO + 0x1f8)) ||
+	    (unsigned long)addr = (PA_MRSHPC_IO + 0x3f6))
+		return se7721_inb((unsigned long)addr);
+	else
+		return ctrl_inb((unsigned long)addr);
+}
+
+void se7721_writeb(u8 b, void __iomem *addr)
+{
+	if (((PA_MRSHPC_IO + 0x1f0) <= (unsigned long)addr &&
+	    (unsigned long)addr < (PA_MRSHPC_IO + 0x1f8)) ||
+	    (unsigned long)addr = (PA_MRSHPC_IO + 0x3f6))
+		se7721_outb(b, (unsigned long)addr);
+	else
+		ctrl_outb(b, (unsigned long)addr);
+}
diff -uprN a/arch/sh/boards/se/7721/irq.c b/arch/sh/boards/se/7721/irq.c
--- a/arch/sh/boards/se/7721/irq.c	1970-01-01 09:00:00.000000000 +0900
+++ b/arch/sh/boards/se/7721/irq.c	2008-03-19 23:12:00.000000000 +0900
@@ -0,0 +1,86 @@
+/*
+ * linux/arch/sh/boards/se/7721/irq.c
+ *
+ * Copyright (C) 2000  Kazumoto Kojima
+ * Copyright (C) 2006  Nobuhiro Iwamatsu
+ * Copyright (C) 2008  Renesas Solutions Corp.
+ *
+ * Hitachi SolutionEngine Support.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/se.h>
+
+static struct ipr_data ipr_irq_table[] = {
+	/*
+	* Super I/O (Just mimic PC):
+	*  1: keyboard
+	*  3: serial 0
+	*  4: serial 1
+	*  5: printer
+	*  6: floppy
+	*  8: rtc
+	* 12: mouse
+	* 14: ide0
+	*/
+	{ 14, 0,  8, 0x0f - 14, },
+	{ 12, 0,  4, 0x0f - 12, },
+	{  8, 1,  4, 0x0f -  8, },
+	{  6, 2, 12, 0x0f -  6, },
+	{  5, 2,  8, 0x0f -  5, },
+	{  4, 2,  4, 0x0f -  4, },
+	{  3, 2,  0, 0x0f -  3, },
+	{  1, 3, 12, 0x0f -  1, },
+	/* MRSHPC IRQs setting */
+	{  0, 4, 12, 0x0f -  0, },	/* PCIRQ3 */
+	{ 11, 4,  8, 0x0f - 11, }, 	/* PCIRQ2 */
+	{  9, 4,  4, 0x0f -  9, }, 	/* PCIRQ1 */
+	{  7, 4,  0, 0x0f -  7, }, 	/* PCIRQ0 */
+	/* #2, #13 are allocated for SLOT IRQ #1 and #2 (for now) */
+	/* NOTE: #2 and #13 are not used on PC */
+	{ 13, 6,  4, 0x0f - 13, }, 	/* SLOTIRQ2 */
+	{  2, 6,  0, 0x0f -  2, }, 	/* SLOTIRQ1 */
+};
+
+static unsigned long ipr_offsets[] = {
+	BCR_ILCRA,
+	BCR_ILCRB,
+	BCR_ILCRC,
+	BCR_ILCRD,
+	BCR_ILCRE,
+	BCR_ILCRF,
+	BCR_ILCRG,
+};
+
+static struct ipr_desc ipr_irq_desc = {
+	.ipr_offsets	= ipr_offsets,
+	.nr_offsets	= ARRAY_SIZE(ipr_offsets),
+
+	.ipr_data	= ipr_irq_table,
+	.nr_irqs	= ARRAY_SIZE(ipr_irq_table),
+	.chip = {
+		.name	= "IPR-se7721",
+	},
+};
+
+/*
+ * Initialize IRQ setting
+ */
+void __init init_se7721_IRQ(void)
+{
+	/* Disable all interrupts */
+	ctrl_outw(0, BCR_ILCRA);
+	ctrl_outw(0, BCR_ILCRB);
+	ctrl_outw(0, BCR_ILCRC);
+	ctrl_outw(0, BCR_ILCRD);
+	ctrl_outw(0, BCR_ILCRE);
+	ctrl_outw(0, BCR_ILCRF);
+	ctrl_outw(0, BCR_ILCRG);
+
+	register_ipr_controller(&ipr_irq_desc);
+}
diff -uprN a/arch/sh/boards/se/7721/Makefile b/arch/sh/boards/se/7721/Makefile
--- a/arch/sh/boards/se/7721/Makefile	1970-01-01 09:00:00.000000000 +0900
+++ b/arch/sh/boards/se/7721/Makefile	2008-03-19 23:12:00.000000000 +0900
@@ -0,0 +1,10 @@
+#
+# Makefile for the HITACHI UL SolutionEngine 7721 specific parts of the kernel
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+#
+
+obj-y	 := setup.o irq.o io.o
diff -uprN a/arch/sh/boards/se/7721/setup.c b/arch/sh/boards/se/7721/setup.c
--- a/arch/sh/boards/se/7721/setup.c	1970-01-01 09:00:00.000000000 +0900
+++ b/arch/sh/boards/se/7721/setup.c	2008-03-19 23:12:00.000000000 +0900
@@ -0,0 +1,119 @@
+/*
+ * linux/arch/sh/boards/se/7721/setup.c
+ *
+ * Copyright (C) 2008 Renesas Solutions Corp.
+ *
+ * Hitachi UL SolutionEngine 7721 Support.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <asm/machvec.h>
+#include <asm/se7721.h>
+#include <asm/io.h>
+#include <asm/heartbeat.h>
+
+static unsigned char heartbeat_bit_pos[] = { 8, 9, 10, 11, 12, 13, 14, 15 };
+
+static struct heartbeat_data heartbeat_data = {
+	.bit_pos	= heartbeat_bit_pos,
+	.nr_bits	= ARRAY_SIZE(heartbeat_bit_pos),
+	.regsize	= 16,
+};
+
+static struct resource heartbeat_resources[] = {
+	[0] = {
+		.start	= PA_LED,
+		.end	= PA_LED,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device heartbeat_device = {
+	.name		= "heartbeat",
+	.id		= -1,
+	.dev	= {
+		.platform_data	= &heartbeat_data,
+	},
+	.num_resources	= ARRAY_SIZE(heartbeat_resources),
+	.resource	= heartbeat_resources,
+};
+
+static struct resource cf_ide_resources[] = {
+	[0] = {
+		.start	= PA_MRSHPC_IO + 0x1f0,
+		.end	= PA_MRSHPC_IO + 0x1f0 + 8 ,
+		.flags	= IORESOURCE_IO,
+	},
+	[1] = {
+		.start	= PA_MRSHPC_IO + 0x1f0 + 0x206,
+		.end	= PA_MRSHPC_IO + 0x1f0 + 8 + 0x206 + 8,
+		.flags	= IORESOURCE_IO,
+	},
+};
+
+static struct platform_device cf_ide_device = {
+	.name		= "pata_platform",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(cf_ide_resources),
+	.resource	= cf_ide_resources,
+};
+
+static struct platform_device *se7721_devices[] __initdata = {
+	&cf_ide_device,
+	&heartbeat_device
+};
+
+static int __init se7721_devices_setup(void)
+{
+	return platform_add_devices(se7721_devices,
+		ARRAY_SIZE(se7721_devices));
+}
+device_initcall(se7721_devices_setup);
+
+static void __init se7721_setup(char **cmdline_p)
+{
+	/* for USB */
+	ctrl_outw(0x0000, 0xA405010C);	/* PGCR */
+	ctrl_outw(0x0000, 0xA405010E);	/* PHCR */
+	ctrl_outw(0x00AA, 0xA4050118);	/* PPCR */
+	ctrl_outw(0x0000, 0xA4050124);	/* PSELA */
+}
+
+/*
+ * The Machine Vector
+ */
+struct sh_machine_vector mv_se7721 __initmv = {
+	.mv_name		= "Solution Engine 7721",
+	.mv_setup		= se7721_setup,
+	.mv_nr_irqs		= 109,
+	.mv_init_irq		= init_se7721_IRQ,
+
+	.mv_inb			= se7721_inb,
+	.mv_inw			= se7721_inw,
+	.mv_inl			= se7721_inl,
+	.mv_outb		= se7721_outb,
+	.mv_outw		= se7721_outw,
+	.mv_outl		= se7721_outl,
+
+	.mv_inb_p		= se7721_inb_p,
+	.mv_inw_p		= se7721_inw,
+	.mv_inl_p		= se7721_inl,
+	.mv_outb_p		= se7721_outb_p,
+	.mv_outw_p		= se7721_outw,
+	.mv_outl_p		= se7721_outl,
+
+	.mv_insb		= se7721_insb,
+	.mv_insw		= se7721_insw,
+	.mv_insl		= se7721_insl,
+	.mv_outsb		= se7721_outsb,
+	.mv_outsw		= se7721_outsw,
+	.mv_outsl		= se7721_outsl,
+
+	.mv_readb		= se7721_readb,
+	.mv_writeb		= se7721_writeb,
+};
diff -uprN a/arch/sh/configs/se7721_defconfig b/arch/sh/configs/se7721_defconfig
--- a/arch/sh/configs/se7721_defconfig	1970-01-01 09:00:00.000000000 +0900
+++ b/arch/sh/configs/se7721_defconfig	2008-03-19 23:11:59.000000000 +0900
@@ -0,0 +1,1086 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.25-rc5
+# Wed Mar 19 22:38:40 2008
+#
+CONFIG_SUPERH=y
+CONFIG_SUPERH32=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_NO_VIRT_TO_BUS=y
+CONFIG_ARCH_SUPPORTS_AOUT=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT2
+CONFIG_LOCALVERSION=""
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT
+# CONFIG_CGROUPS is not set
+CONFIG_GROUP_SCHED=y
+CONFIG_FAIR_GROUP_SCHED=y
+# CONFIG_RT_GROUP_SCHED is not set
+CONFIG_USER_SCHED=y
+# CONFIG_CGROUP_SCHED is not set
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_UID16=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+# CONFIG_BUG is not set
+CONFIG_ELF_CORE=y
+CONFIG_COMPAT_BRK=y
+# CONFIG_BASE_FULL is not set
+CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+# CONFIG_SHMEM is not set
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_HAVE_KPROBES is not set
+# CONFIG_HAVE_KRETPROBES is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_TINY_SHMEM=y
+CONFIG_BASE_SMALL=1
+CONFIG_MODULES=y
+# CONFIG_MODULE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+# CONFIG_KMOD is not set
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
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
+
+#
+# System type
+#
+CONFIG_CPU_SH3=y
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
+CONFIG_CPU_SUBTYPE_SH7721=y
+# CONFIG_CPU_SUBTYPE_SH7750 is not set
+# CONFIG_CPU_SUBTYPE_SH7091 is not set
+# CONFIG_CPU_SUBTYPE_SH7750R is not set
+# CONFIG_CPU_SUBTYPE_SH7750S is not set
+# CONFIG_CPU_SUBTYPE_SH7751 is not set
+# CONFIG_CPU_SUBTYPE_SH7751R is not set
+# CONFIG_CPU_SUBTYPE_SH7760 is not set
+# CONFIG_CPU_SUBTYPE_SH4_202 is not set
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
+CONFIG_MEMORY_START=0x0c000000
+CONFIG_MEMORY_SIZE=0x02000000
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
+# CONFIG_PAGE_SIZE_64KB is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_SPARSEMEM_STATIC=y
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_NR_QUICK=2
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
+# CONFIG_SH_FPU_EMU is not set
+# CONFIG_SH_DSP is not set
+# CONFIG_SH_ADC is not set
+CONFIG_CPU_HAS_INTEVT=y
+CONFIG_CPU_HAS_IPR_IRQ=y
+CONFIG_CPU_HAS_SR_RB=y
+CONFIG_CPU_HAS_DSP=y
+
+#
+# Board support
+#
+CONFIG_SOLUTION_ENGINE=y
+CONFIG_SH_7721_SOLUTION_ENGINE=y
+
+#
+# Timer and clock configuration
+#
+CONFIG_SH_TMU=y
+CONFIG_SH_TIMER_IRQ
+CONFIG_SH_PCLK_FREQ3333333
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
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
+# CONFIG_SH_DMA is not set
+
+#
+# Companion Chips
+#
+
+#
+# Additional SuperH Device Drivers
+#
+CONFIG_HEARTBEAT=y
+# CONFIG_PUSH_SWITCH is not set
+
+#
+# Kernel features
+#
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ%0
+# CONFIG_SCHED_HRTICK is not set
+# CONFIG_KEXEC is not set
+# CONFIG_CRASH_DUMP is not set
+# CONFIG_PREEMPT_NONE is not set
+CONFIG_PREEMPT_VOLUNTARY=y
+# CONFIG_PREEMPT is not set
+CONFIG_GUSA=y
+# CONFIG_GUSA_RB is not set
+
+#
+# Boot options
+#
+CONFIG_ZERO_PAGE_OFFSET=0x00001000
+CONFIG_BOOT_LINK_OFFSET=0x00800000
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttySC0,115200 root=/dev/sda2"
+
+#
+# Bus options
+#
+CONFIG_CF_ENABLER=y
+# CONFIG_CF_AREA5 is not set
+CONFIG_CF_AREA6=y
+CONFIG_CF_BASE_ADDR=0xb8000000
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCCARD is not set
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+
+#
+# Networking
+#
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
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
+CONFIG_NET_KEY=y
+# CONFIG_NET_KEY_MIGRATE is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_ASK_IP_FIB_HASH=y
+# CONFIG_IP_FIB_TRIE is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_MULTIPLE_TABLES=y
+CONFIG_IP_ROUTE_MULTIPATH=y
+CONFIG_IP_ROUTE_VERBOSE=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+CONFIG_INET_AH=y
+CONFIG_INET_ESP=y
+CONFIG_INET_IPCOMP=y
+CONFIG_INET_XFRM_TUNNEL=y
+CONFIG_INET_TUNNEL=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+CONFIG_NET_SCHED=y
+
+#
+# Queueing/Scheduling
+#
+CONFIG_NET_SCH_CBQ=y
+CONFIG_NET_SCH_HTB=y
+CONFIG_NET_SCH_HFSC=y
+CONFIG_NET_SCH_PRIO=y
+# CONFIG_NET_SCH_RR is not set
+CONFIG_NET_SCH_RED=y
+CONFIG_NET_SCH_SFQ=y
+CONFIG_NET_SCH_TEQL=y
+CONFIG_NET_SCH_TBF=y
+CONFIG_NET_SCH_GRED=y
+CONFIG_NET_SCH_DSMARK=y
+CONFIG_NET_SCH_NETEM=y
+
+#
+# Classification
+#
+CONFIG_NET_CLS=y
+# CONFIG_NET_CLS_BASIC is not set
+CONFIG_NET_CLS_TCINDEX=y
+CONFIG_NET_CLS_ROUTE4=y
+CONFIG_NET_CLS_ROUTE=y
+CONFIG_NET_CLS_FW=y
+# CONFIG_NET_CLS_U32 is not set
+# CONFIG_NET_CLS_RSVP is not set
+# CONFIG_NET_CLS_RSVP6 is not set
+# CONFIG_NET_CLS_FLOW is not set
+# CONFIG_NET_EMATCH is not set
+# CONFIG_NET_CLS_ACT is not set
+CONFIG_NET_CLS_IND=y
+CONFIG_NET_SCH_FIFO=y
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+CONFIG_FIB_RULES=y
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
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
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
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
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
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
+# CONFIG_BLK_DEV_LOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_UB is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+CONFIG_HAVE_IDE=y
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_TGT is not set
+# CONFIG_SCSI_NETLINK is not set
+CONFIG_SCSI_PROC_FS=y
+
+#
+# SCSI support type (disk, tape, CD-ROM)
+#
+CONFIG_BLK_DEV_SD=y
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+# CONFIG_CHR_DEV_SG is not set
+# CONFIG_CHR_DEV_SCH is not set
+
+#
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
+#
+CONFIG_SCSI_MULTI_LUN=y
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m
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
+CONFIG_ATA=y
+# CONFIG_ATA_NONSTANDARD is not set
+# CONFIG_SATA_MV is not set
+CONFIG_PATA_PLATFORM=y
+# CONFIG_MD is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_NET_ETHERNET is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_E1000E_ENABLED is not set
+CONFIG_NETDEV_10000=y
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+
+#
+# USB Network Adapters
+#
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NETCONSOLE is not set
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
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X24
+CONFIG_INPUT_MOUSEDEV_SCREEN_Yv8
+# CONFIG_INPUT_JOYDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+# CONFIG_KEYBOARD_SH_KEYSC is not set
+CONFIG_INPUT_MOUSE=y
+# CONFIG_MOUSE_PS2 is not set
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_APPLETOUCH is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
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
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_SH_SCI_NR_UARTS=2
+CONFIG_SERIAL_SH_SCI_CONSOLE=y
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+# CONFIG_I2C is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_DAB is not set
+
+#
+# Graphics support
+#
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+# CONFIG_HIDRAW is not set
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_USB_HIDINPUT_POWERBOOK is not set
+# CONFIG_HID_FF is not set
+# CONFIG_USB_HIDDEV is not set
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
+# CONFIG_USB_DEVICEFS is not set
+CONFIG_USB_DEVICE_CLASS=y
+# CONFIG_USB_DYNAMIC_MINORS is not set
+# CONFIG_USB_OTG is not set
+
+#
+# USB Host Controller Drivers
+#
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
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# may also be needed; see USB_STORAGE Help for more information
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
+# CONFIG_USB_LIBUSUAL is not set
+
+#
+# USB Imaging devices
+#
+# CONFIG_USB_MDC800 is not set
+# CONFIG_USB_MICROTEK is not set
+CONFIG_USB_MON=y
+
+#
+# USB port drivers
+#
+# CONFIG_USB_SERIAL is not set
+
+#
+# USB Miscellaneous drivers
+#
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_AUERSWALD is not set
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
+# CONFIG_USB_GADGET is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+CONFIG_LEDS_TRIGGERS=y
+# CONFIG_LEDS_TRIGGER_TIMER is not set
+# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
+# CONFIG_RTC_CLASS is not set
+
+#
+# Userspace I/O
+#
+# CONFIG_UIO is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT2_FS_SECURITY=y
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=y
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY is not set
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGEC7
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_PROC_KCORE is not set
+CONFIG_PROC_SYSCTL=y
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
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+CONFIG_CRAMFS=y
+# CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+# CONFIG_NETWORK_FILESYSTEMS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
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
+CONFIG_NLS_CODEPAGE_932=y
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=y
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
+# CONFIG_DLM is not set
+
+#
+# Kernel hacking
+#
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_SLAB is not set
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
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+CONFIG_FRAME_POINTER=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
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
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_AEAD=y
+CONFIG_CRYPTO_BLKCIPHER=y
+# CONFIG_CRYPTO_SEQIV is not set
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_HMAC=y
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_SHA1=y
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_ECB is not set
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_XTS is not set
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SALSA20 is not set
+CONFIG_CRYPTO_DEFLATE=y
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_TEST is not set
+CONFIG_CRYPTO_AUTHENC=y
+# CONFIG_CRYPTO_LZO is not set
+CONFIG_CRYPTO_HW=y
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_CRC_CCITT=y
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
diff -uprN a/arch/sh/Kconfig b/arch/sh/Kconfig
--- a/arch/sh/Kconfig	2008-03-19 18:08:07.000000000 +0900
+++ b/arch/sh/Kconfig	2008-03-19 23:12:00.000000000 +0900
@@ -375,6 +375,15 @@ config SH_7619_SOLUTION_ENGINE
 	  Select 7619 SolutionEngine if configuring for a Hitachi SH7619
 	  evaluation board.
 	
+config SH_7721_SOLUTION_ENGINE
+	bool "SolutionEngine7721"
+	select SOLUTION_ENGINE
+	select CPU_HAS_IPR_IRQ
+	depends on CPU_SUBTYPE_SH7721
+	help
+	  Select 7721 SolutionEngine if configuring for a Hitachi SH7721
+	  evaluation board.
+
 config SH_7722_SOLUTION_ENGINE
 	bool "SolutionEngine7722"
 	select SOLUTION_ENGINE
diff -uprN a/arch/sh/kernel/cf-enabler.c b/arch/sh/kernel/cf-enabler.c
--- a/arch/sh/kernel/cf-enabler.c	2008-03-19 18:08:08.000000000 +0900
+++ b/arch/sh/kernel/cf-enabler.c	2008-03-19 23:16:25.000000000 +0900
@@ -83,6 +83,8 @@ static int __init cf_init_default(void)
 #include <asm/se.h>
 #elif defined(CONFIG_SH_7722_SOLUTION_ENGINE)
 #include <asm/se7722.h>
+#elif defined(CONFIG_SH_7721_SOLUTION_ENGINE)
+#include <asm/se7721.h>
 #endif

 /*
@@ -99,7 +101,9 @@ static int __init cf_init_default(void)
  * 0xB0600000 : I/O
  */

-#if defined(CONFIG_SH_SOLUTION_ENGINE) || defined(CONFIG_SH_7722_SOLUTION_ENGINE)
+#if defined(CONFIG_SH_SOLUTION_ENGINE) || \
+    defined(CONFIG_SH_7722_SOLUTION_ENGINE) || \
+    defined(CONFIG_SH_7721_SOLUTION_ENGINE)
 static int __init cf_init_se(void)
 {
 	if ((ctrl_inw(MRSHPC_CSR) & 0x000c) != 0)
@@ -155,9 +159,8 @@ static int __init cf_init_se(void)

 int __init cf_init(void)
 {
-	if( mach_is_se() || mach_is_7722se() ){
+	if (mach_is_se() || mach_is_7722se() || mach_is_7721se())
 		return cf_init_se();
-	}
 	
 	return cf_init_default();
 }
diff -uprN a/arch/sh/Makefile b/arch/sh/Makefile
--- a/arch/sh/Makefile	2008-03-19 18:08:07.000000000 +0900
+++ b/arch/sh/Makefile	2008-03-19 23:12:00.000000000 +0900
@@ -107,6 +107,7 @@ machdir-$(CONFIG_SH_7722_SOLUTION_ENGINE
 machdir-$(CONFIG_SH_7751_SOLUTION_ENGINE)	+= se/7751
 machdir-$(CONFIG_SH_7780_SOLUTION_ENGINE)	+= se/7780
 machdir-$(CONFIG_SH_7343_SOLUTION_ENGINE)	+= se/7343
+machdir-$(CONFIG_SH_7721_SOLUTION_ENGINE)	+= se/7721
 machdir-$(CONFIG_SH_HP6XX)			+= hp6xx
 machdir-$(CONFIG_SH_DREAMCAST)			+= dreamcast
 machdir-$(CONFIG_SH_MPC1211)			+= mpc1211
diff -uprN a/arch/sh/tools/mach-types b/arch/sh/tools/mach-types
--- a/arch/sh/tools/mach-types	2008-03-19 18:08:08.000000000 +0900
+++ b/arch/sh/tools/mach-types	2008-03-19 23:12:00.000000000 +0900
@@ -21,6 +21,7 @@ HD64465			HD64465
 7206SE			SH_7206_SOLUTION_ENGINE
 7343SE			SH_7343_SOLUTION_ENGINE
 7619SE			SH_7619_SOLUTION_ENGINE
+7721SE			SH_7721_SOLUTION_ENGINE		
 7722SE			SH_7722_SOLUTION_ENGINE		
 7751SE			SH_7751_SOLUTION_ENGINE		
 7780SE			SH_7780_SOLUTION_ENGINE
diff -uprN a/include/asm-sh/se7721.h b/include/asm-sh/se7721.h
--- a/include/asm-sh/se7721.h	1970-01-01 09:00:00.000000000 +0900
+++ b/include/asm-sh/se7721.h	2008-03-19 23:12:54.000000000 +0900
@@ -0,0 +1,71 @@
+/*
+ * Copyright (C) 2008 Renesas Solutions Corp.
+ *
+ * Hitachi UL SolutionEngine 7721 Support.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#ifndef __ASM_SH_SE7721_H
+#define __ASM_SH_SE7721_H
+#include <asm/addrspace.h>
+
+/* Box specific addresses. */
+#define SE_AREA0_WIDTH	2		/* Area0: 32bit */
+#define PA_ROM		0xa0000000	/* EPROM */
+#define PA_ROM_SIZE	0x00200000	/* EPROM size 2M byte */
+#define PA_FROM		0xa1000000	/* Flash-ROM */
+#define PA_FROM_SIZE	0x01000000	/* Flash-ROM size 16M byte */
+#define PA_EXT1		0xa4000000
+#define PA_EXT1_SIZE	0x04000000
+#define PA_SDRAM	0xaC000000	/* SDRAM(Area3) 64MB */
+#define PA_SDRAM_SIZE	0x04000000
+
+#define PA_EXT4		0xb0000000
+#define PA_EXT4_SIZE	0x04000000
+
+#define PA_PERIPHERAL	0xB8000000
+
+#define PA_PCIC		PA_PERIPHERAL
+#define PA_MRSHPC	(PA_PERIPHERAL + 0x003fffe0)
+#define PA_MRSHPC_MW1	(PA_PERIPHERAL + 0x00400000)
+#define PA_MRSHPC_MW2	(PA_PERIPHERAL + 0x00500000)
+#define PA_MRSHPC_IO	(PA_PERIPHERAL + 0x00600000)
+#define MRSHPC_OPTION	(PA_MRSHPC + 6)
+#define MRSHPC_CSR	(PA_MRSHPC + 8)
+#define MRSHPC_ISR	(PA_MRSHPC + 10)
+#define MRSHPC_ICR	(PA_MRSHPC + 12)
+#define MRSHPC_CPWCR	(PA_MRSHPC + 14)
+#define MRSHPC_MW0CR1	(PA_MRSHPC + 16)
+#define MRSHPC_MW1CR1	(PA_MRSHPC + 18)
+#define MRSHPC_IOWCR1	(PA_MRSHPC + 20)
+#define MRSHPC_MW0CR2	(PA_MRSHPC + 22)
+#define MRSHPC_MW1CR2	(PA_MRSHPC + 24)
+#define MRSHPC_IOWCR2	(PA_MRSHPC + 26)
+#define MRSHPC_CDCR	(PA_MRSHPC + 28)
+#define MRSHPC_PCIC_INFO	(PA_MRSHPC + 30)
+
+#define PA_LED		0xB6800000	/* 8bit LED */
+#define PA_FPGA		0xB7000000 	/* FPGA base address */
+
+#define MRSHPC_IRQ0	14
+
+#define FPGA_ILSR1	(PA_FPGA + 0x02)
+#define FPGA_ILSR2	(PA_FPGA + 0x03)
+#define FPGA_ILSR3	(PA_FPGA + 0x04)
+#define FPGA_ILSR4	(PA_FPGA + 0x05)
+#define FPGA_ILSR5	(PA_FPGA + 0x06)
+#define FPGA_ILSR6	(PA_FPGA + 0x07)
+#define FPGA_ILSR7	(PA_FPGA + 0x08)
+#define FPGA_ILSR8	(PA_FPGA + 0x09)
+
+void init_se7721_IRQ(void);
+int se7721_irq_demux(int);
+
+#define __IO_PREFIX		se7721
+#include <asm/io_generic.h>
+
+#endif  /* __ASM_SH_SE7721_H */
