From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Mon, 07 Jul 2008 12:11:54 +0000
Subject: [PATCH 2/2] sh: update Solution Engine 7343
Message-Id: <4872080A.6010200@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

updated the following codes for Solution Endine 7343:
 - fix compile error in arch/sh/boards/se/7343/irq.c
 - add nor flash physmaps
 - update defconfig

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/boards/se/7343/irq.c     |  232 +++---------
 arch/sh/boards/se/7343/setup.c   |   74 ++++-
 arch/sh/configs/se7343_defconfig |  735 ++++++++++++++++++--------------------
 include/asm-sh/se7343.h          |   97 +++++-
 4 files changed, 561 insertions(+), 577 deletions(-)


diff --git a/arch/sh/boards/se/7343/irq.c b/arch/sh/boards/se/7343/irq.c
index 763f6de..1112e86 100644
--- a/arch/sh/boards/se/7343/irq.c
+++ b/arch/sh/boards/se/7343/irq.c
@@ -1,202 +1,80 @@
 /*
- * arch/sh/boards/se/7343/irq.c
+ * linux/arch/sh/boards/se/7343/irq.c
  *
+ * Copyright (C) 2008  Yoshihiro Shimoda
+ *
+ * Based on linux/arch/sh/boards/se/7722/irq.c
+ * Copyright (C) 2007  Nobuhiro Iwamatsu
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
  */
 #include <linux/init.h>
-#include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/mach/se7343.h>
+#include <asm/se7343.h>

-static void
-disable_intreq_irq(unsigned int irq)
+static void disable_se7343_irq(unsigned int irq)
 {
-	int bit = irq - OFFCHIP_IRQ_BASE;
-	u16 val;
-
-	val = ctrl_inw(PA_CPLD_IMSK);
-	val |= 1 << bit;
-	ctrl_outw(val, PA_CPLD_IMSK);
+	unsigned int bit = irq - SE7343_FPGA_IRQ_BASE;
+	ctrl_outw(ctrl_inw(PA_CPLD_IMSK) | 1 << bit, PA_CPLD_IMSK);
 }

-static void
-enable_intreq_irq(unsigned int irq)
+static void enable_se7343_irq(unsigned int irq)
 {
-	int bit = irq - OFFCHIP_IRQ_BASE;
-	u16 val;
-
-	val = ctrl_inw(PA_CPLD_IMSK);
-	val &= ~(1 << bit);
-	ctrl_outw(val, PA_CPLD_IMSK);
+	unsigned int bit = irq - SE7343_FPGA_IRQ_BASE;
+	ctrl_outw(ctrl_inw(PA_CPLD_IMSK) & ~(1 << bit), PA_CPLD_IMSK);
 }

-static void
-mask_and_ack_intreq_irq(unsigned int irq)
-{
-	disable_intreq_irq(irq);
-}
-
-static unsigned int
-startup_intreq_irq(unsigned int irq)
-{
-	enable_intreq_irq(irq);
-	return 0;
-}
-
-static void
-shutdown_intreq_irq(unsigned int irq)
-{
-	disable_intreq_irq(irq);
-}
-
-static void
-end_intreq_irq(unsigned int irq)
-{
-	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-		enable_intreq_irq(irq);
-}
-
-static struct hw_interrupt_type intreq_irq_type = {
-	.typename = "FPGA-IRQ",
-	.startup = startup_intreq_irq,
-	.shutdown = shutdown_intreq_irq,
-	.enable = enable_intreq_irq,
-	.disable = disable_intreq_irq,
-	.ack = mask_and_ack_intreq_irq,
-	.end = end_intreq_irq
+static struct irq_chip se7343_irq_chip __read_mostly = {
+	.name           = "SE7343-FPGA",
+	.mask           = disable_se7343_irq,
+	.unmask         = enable_se7343_irq,
+	.mask_ack       = disable_se7343_irq,
 };

-static void
-make_intreq_irq(unsigned int irq)
-{
-	disable_irq_nosync(irq);
-	irq_desc[irq].chip = &intreq_irq_type;
-	disable_intreq_irq(irq);
-}
-
-int
-shmse_irq_demux(int irq)
+static void se7343_irq_demux(unsigned int irq, struct irq_desc *desc)
 {
-	int bit;
-	volatile u16 val;
-
-	if (irq = IRQ5_IRQ) {
-		/* Read status Register */
-		val = ctrl_inw(PA_CPLD_ST);
-		bit = ffs(val);
-		if (bit != 0)
-			return OFFCHIP_IRQ_BASE + bit - 1;
+	unsigned short intv = ctrl_inw(PA_CPLD_ST);
+	struct irq_desc *ext_desc;
+	unsigned int ext_irq = SE7343_FPGA_IRQ_BASE;
+
+	intv &= (1 << SE7343_FPGA_IRQ_NR) - 1;
+
+	while (intv) {
+		if (intv & 1) {
+			ext_desc = irq_desc + ext_irq;
+			handle_level_irq(ext_irq, ext_desc);
+		}
+		intv >>= 1;
+		ext_irq++;
 	}
-	return irq;
 }

-/* IRQ5 is multiplexed between the following sources:
- * 1. PC Card socket
- * 2. Extension slot
- * 3. USB Controller
- * 4. Serial Controller
- *
- * We configure IRQ5 as a cascade IRQ.
- */
-static struct irqaction irq5 = {
-	.handler = no_action,
-	.mask = CPU_MASK_NONE,
-	.name = "IRQ5-cascade",
-};
-
-static struct ipr_data se7343_irq5_ipr_map[] = {
-	{ IRQ5_IRQ, IRQ5_IPR_ADDR+2, IRQ5_IPR_POS, IRQ5_PRIORITY },
-};
-static struct ipr_data se7343_siof0_vpu_ipr_map[] = {
-	{ SIOF0_IRQ, SIOF0_IPR_ADDR, SIOF0_IPR_POS, SIOF0_PRIORITY },
-	{ VPU_IRQ, VPU_IPR_ADDR, VPU_IPR_POS, 8 },
-};
-static struct ipr_data se7343_other_ipr_map[] = {
-	{ DMTE0_IRQ, DMA1_IPR_ADDR, DMA1_IPR_POS, DMA1_PRIORITY },
-	{ DMTE1_IRQ, DMA1_IPR_ADDR, DMA1_IPR_POS, DMA1_PRIORITY },
-	{ DMTE2_IRQ, DMA1_IPR_ADDR, DMA1_IPR_POS, DMA1_PRIORITY },
-	{ DMTE3_IRQ, DMA1_IPR_ADDR, DMA1_IPR_POS, DMA1_PRIORITY },
-	{ DMTE4_IRQ, DMA2_IPR_ADDR, DMA2_IPR_POS, DMA2_PRIORITY },
-	{ DMTE5_IRQ, DMA2_IPR_ADDR, DMA2_IPR_POS, DMA2_PRIORITY },
-
-	/* I2C block */
-	{ IIC0_ALI_IRQ, IIC0_IPR_ADDR, IIC0_IPR_POS, IIC0_PRIORITY },
-	{ IIC0_TACKI_IRQ, IIC0_IPR_ADDR, IIC0_IPR_POS, IIC0_PRIORITY },
-	{ IIC0_WAITI_IRQ, IIC0_IPR_ADDR, IIC0_IPR_POS, IIC0_PRIORITY },
-	{ IIC0_DTEI_IRQ, IIC0_IPR_ADDR, IIC0_IPR_POS, IIC0_PRIORITY },
-
-	{ IIC1_ALI_IRQ, IIC1_IPR_ADDR, IIC1_IPR_POS, IIC1_PRIORITY },
-	{ IIC1_TACKI_IRQ, IIC1_IPR_ADDR, IIC1_IPR_POS, IIC1_PRIORITY },
-	{ IIC1_WAITI_IRQ, IIC1_IPR_ADDR, IIC1_IPR_POS, IIC1_PRIORITY },
-	{ IIC1_DTEI_IRQ, IIC1_IPR_ADDR, IIC1_IPR_POS, IIC1_PRIORITY },
-
-	/* SIOF */
-	{ SIOF0_IRQ, SIOF0_IPR_ADDR, SIOF0_IPR_POS, SIOF0_PRIORITY },
-
-	/* SIU */
-	{ SIU_IRQ, SIU_IPR_ADDR, SIU_IPR_POS, SIU_PRIORITY },
-
-	/* VIO interrupt */
-	{ CEU_IRQ, VIO_IPR_ADDR, VIO_IPR_POS, VIO_PRIORITY },
-	{ BEU_IRQ, VIO_IPR_ADDR, VIO_IPR_POS, VIO_PRIORITY },
-	{ VEU_IRQ, VIO_IPR_ADDR, VIO_IPR_POS, VIO_PRIORITY },
-
-	/*MFI interrupt*/
-
-	{ MFI_IRQ, MFI_IPR_ADDR, MFI_IPR_POS, MFI_PRIORITY },
-
-	/* LCD controller */
-	{ LCDC_IRQ, LCDC_IPR_ADDR, LCDC_IPR_POS, LCDC_PRIORITY },
-};
-
 /*
  * Initialize IRQ setting
  */
-void __init
-init_7343se_IRQ(void)
+void __init init_7343se_IRQ(void)
 {
-	/* Setup Multiplexed interrupts */
-	ctrl_outw(8, PA_CPLD_MODESET);	/* Set all CPLD interrupts to active
-					 * low.
-					 */
-	/* Mask all CPLD controller interrupts */
-	ctrl_outw(0x0fff, PA_CPLD_IMSK);
-
-	/* PC Card interrupts */
-	make_intreq_irq(PC_IRQ0);
-	make_intreq_irq(PC_IRQ1);
-	make_intreq_irq(PC_IRQ2);
-	make_intreq_irq(PC_IRQ3);
-
-	/* Extension Slot Interrupts */
-	make_intreq_irq(EXT_IRQ0);
-	make_intreq_irq(EXT_IRQ1);
-	make_intreq_irq(EXT_IRQ2);
-	make_intreq_irq(EXT_IRQ3);
-
-	/* USB Controller interrupts */
-	make_intreq_irq(USB_IRQ0);
-	make_intreq_irq(USB_IRQ1);
-
-	/* Serial Controller interrupts */
-	make_intreq_irq(UART_IRQ0);
-	make_intreq_irq(UART_IRQ1);
-
-	/* Setup all external interrupts to be active low */
-	ctrl_outw(0xaaaa, INTC_ICR1);
-
-	make_ipr_irq(se7343_irq5_ipr_map, ARRAY_SIZE(se7343_irq5_ipr_map));
-
-	setup_irq(IRQ5_IRQ, &irq5);
-	/* Set port control to use IRQ5 */
-	*(u16 *)0xA4050108 &= ~0xc;
-
-	make_ipr_irq(se7343_siof0_vpu_ipr_map, ARRAY_SIZE(se7343_siof0_vpu_ipr_map));
-
-	ctrl_outb(0x0f, INTC_IMCR5);	/* enable SCIF IRQ */
-
-	make_ipr_irq(se7343_other_ipr_map, ARRAY_SIZE(se7343_other_ipr_map));
-
-	ctrl_outw(0x2000, PA_MRSHPC + 0x0c);	/* mrshpc irq enable */
+	int i;
+
+	ctrl_outw(0, PA_CPLD_IMSK);	/* disable all irqs */
+	ctrl_outw(0x2000, 0xb03fffec);	/* mrshpc irq enable */
+
+	for (i = 0; i < SE7343_FPGA_IRQ_NR; i++)
+		set_irq_chip_and_handler_name(SE7343_FPGA_IRQ_BASE + i,
+					      &se7343_irq_chip,
+					      handle_level_irq, "level");
+
+	set_irq_chained_handler(IRQ0_IRQ, se7343_irq_demux);
+	set_irq_type(IRQ0_IRQ, IRQ_TYPE_LEVEL_LOW);
+	set_irq_chained_handler(IRQ1_IRQ, se7343_irq_demux);
+	set_irq_type(IRQ1_IRQ, IRQ_TYPE_LEVEL_LOW);
+	set_irq_chained_handler(IRQ4_IRQ, se7343_irq_demux);
+	set_irq_type(IRQ4_IRQ, IRQ_TYPE_LEVEL_LOW);
+	set_irq_chained_handler(IRQ5_IRQ, se7343_irq_demux);
+	set_irq_type(IRQ5_IRQ, IRQ_TYPE_LEVEL_LOW);
 }
diff --git a/arch/sh/boards/se/7343/setup.c b/arch/sh/boards/se/7343/setup.c
index c9431b3..59d8d94 100644
--- a/arch/sh/boards/se/7343/setup.c
+++ b/arch/sh/boards/se/7343/setup.c
@@ -1,10 +1,11 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
 #include <asm/machvec.h>
 #include <asm/mach/se7343.h>
+#include <asm/heartbeat.h>
 #include <asm/irq.h>
-
-void init_7343se_IRQ(void);
+#include <asm/io.h>

 static struct resource smc91x_resources[] = {
 	[0] = {
@@ -17,8 +18,8 @@ static struct resource smc91x_resources[] = {
 		 * shared with other devices via externel
 		 * interrupt controller in FPGA...
 		 */
-		.start	= EXT_IRQ2,
-		.end	= EXT_IRQ2,
+		.start	= SMC_IRQ,
+		.end	= SMC_IRQ,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -38,16 +39,65 @@ static struct resource heartbeat_resources[] = {
 	},
 };

+static struct heartbeat_data heartbeat_data = {
+	.regsize = 16,
+};
+
 static struct platform_device heartbeat_device = {
 	.name		= "heartbeat",
 	.id		= -1,
+	.dev = {
+		.platform_data = &heartbeat_data,
+	},
 	.num_resources	= ARRAY_SIZE(heartbeat_resources),
 	.resource	= heartbeat_resources,
 };

+static struct mtd_partition nor_flash_partitions[] = {
+	{
+		.name		= "loader",
+		.offset		= 0x00000000,
+		.size		= 128 * 1024,
+	},
+	{
+		.name		= "rootfs",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= 31 * 1024 * 1024,
+	},
+	{
+		.name		= "data",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct physmap_flash_data nor_flash_data = {
+	.width		= 2,
+	.parts		= nor_flash_partitions,
+	.nr_parts	= ARRAY_SIZE(nor_flash_partitions),
+};
+
+static struct resource nor_flash_resources[] = {
+	[0]	= {
+		.start	= 0x00000000,
+		.end	= 0x01ffffff,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device nor_flash_device = {
+	.name		= "physmap-flash",
+	.dev		= {
+		.platform_data	= &nor_flash_data,
+	},
+	.num_resources	= ARRAY_SIZE(nor_flash_resources),
+	.resource	= nor_flash_resources,
+};
+
 static struct platform_device *sh7343se_platform_devices[] __initdata = {
 	&smc91x_device,
 	&heartbeat_device,
+	&nor_flash_device,
 };

 static int __init sh7343se_devices_setup(void)
@@ -55,10 +105,23 @@ static int __init sh7343se_devices_setup(void)
 	return platform_add_devices(sh7343se_platform_devices,
 				    ARRAY_SIZE(sh7343se_platform_devices));
 }
+device_initcall(sh7343se_devices_setup);

+/*
+ * Initialize the board
+ */
 static void __init sh7343se_setup(char **cmdline_p)
 {
-	device_initcall(sh7343se_devices_setup);
+	ctrl_outw(0xf900, FPGA_OUT);	/* FPGA */
+
+	ctrl_outl(0x00001001, MSTPCR0);
+	ctrl_outl(0x00000000, MSTPCR1);
+	ctrl_outl(0xffffbfC0, MSTPCR2);	/* LCDC, BEU, CEU, VEU, KEYSC */
+
+	ctrl_outw(0x0002, PORT_PECR);	/* PORT E 1 = IRQ5 */
+	ctrl_outw(0x0020, PORT_PSELD);
+
+	printk(KERN_INFO "MS7343CP01 Setup...done\n");
 }

 /*
@@ -90,5 +153,4 @@ static struct sh_machine_vector mv_7343se __initmv = {
 	.mv_outsl = sh7343se_outsl,

 	.mv_init_irq = init_7343se_IRQ,
-	.mv_irq_demux = shmse_irq_demux,
 };
diff --git a/arch/sh/configs/se7343_defconfig b/arch/sh/configs/se7343_defconfig
index 84c0075..7b72736 100644
--- a/arch/sh/configs/se7343_defconfig
+++ b/arch/sh/configs/se7343_defconfig
@@ -1,40 +1,55 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18
-# Tue Oct  3 11:46:17 2006
+# Linux kernel version: 2.6.26-rc8
+# Mon Jul  7 13:12:45 2008
 #
 CONFIG_SUPERH=y
+CONFIG_SUPERH32=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_GENERIC_BUG=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_NO_VIRT_TO_BUS=y
+CONFIG_ARCH_SUPPORTS_AOUT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT2
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT
+# CONFIG_CGROUPS is not set
+CONFIG_GROUP_SCHED=y
+CONFIG_FAIR_GROUP_SCHED=y
+# CONFIG_RT_GROUP_SCHED is not set
+CONFIG_USER_SCHED=y
+# CONFIG_CGROUP_SCHED is not set
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
 # CONFIG_RELAY is not set
-CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
@@ -46,33 +61,41 @@ CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+CONFIG_COMPAT_BRK=y
 CONFIG_BASE_FULL=y
 # CONFIG_FUTEX is not set
+CONFIG_ANON_INODES=y
 # CONFIG_EPOLL is not set
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 # CONFIG_SHMEM is not set
-CONFIG_SLAB=y
 CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_HAVE_KPROBES is not set
+# CONFIG_HAVE_KRETPROBES is not set
+# CONFIG_HAVE_DMA_ATTRS is not set
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SLABINFO=y
 CONFIG_TINY_SHMEM=y
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_MODVERSIONS is not set
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 # CONFIG_KMOD is not set
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
 # CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set

 #
 # IO Schedulers
@@ -86,62 +109,28 @@ CONFIG_DEFAULT_DEADLINE=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="deadline"
+CONFIG_CLASSIC_RCU=y

 #
 # System type
 #
-CONFIG_SOLUTION_ENGINE=y
-# CONFIG_SH_SOLUTION_ENGINE is not set
-# CONFIG_SH_7751_SOLUTION_ENGINE is not set
-# CONFIG_SH_7300_SOLUTION_ENGINE is not set
-CONFIG_SH_7343_SOLUTION_ENGINE=y
-# CONFIG_SH_73180_SOLUTION_ENGINE is not set
-# CONFIG_SH_7751_SYSTEMH is not set
-# CONFIG_SH_HP6XX is not set
-# CONFIG_SH_EC3104 is not set
-# CONFIG_SH_SATURN is not set
-# CONFIG_SH_DREAMCAST is not set
-# CONFIG_SH_BIGSUR is not set
-# CONFIG_SH_MPC1211 is not set
-# CONFIG_SH_SH03 is not set
-# CONFIG_SH_SECUREEDGE5410 is not set
-# CONFIG_SH_HS7751RVOIP is not set
-# CONFIG_SH_7710VOIPGW is not set
-# CONFIG_SH_RTS7751R2D is not set
-# CONFIG_SH_R7780RP is not set
-# CONFIG_SH_EDOSK7705 is not set
-# CONFIG_SH_SH4202_MICRODEV is not set
-# CONFIG_SH_LANDISK is not set
-# CONFIG_SH_TITAN is not set
-# CONFIG_SH_SHMIN is not set
-# CONFIG_SH_UNKNOWN is not set
-
-#
-# Processor selection
-#
 CONFIG_CPU_SH4=y
 CONFIG_CPU_SH4A=y
 CONFIG_CPU_SH4AL_DSP=y
-
-#
-# SH-2 Processor Support
-#
-# CONFIG_CPU_SUBTYPE_SH7604 is not set
-
-#
-# SH-3 Processor Support
-#
-# CONFIG_CPU_SUBTYPE_SH7300 is not set
+# CONFIG_CPU_SUBTYPE_SH7619 is not set
+# CONFIG_CPU_SUBTYPE_SH7203 is not set
+# CONFIG_CPU_SUBTYPE_SH7206 is not set
+# CONFIG_CPU_SUBTYPE_SH7263 is not set
+# CONFIG_CPU_SUBTYPE_MXG is not set
 # CONFIG_CPU_SUBTYPE_SH7705 is not set
 # CONFIG_CPU_SUBTYPE_SH7706 is not set
 # CONFIG_CPU_SUBTYPE_SH7707 is not set
 # CONFIG_CPU_SUBTYPE_SH7708 is not set
 # CONFIG_CPU_SUBTYPE_SH7709 is not set
 # CONFIG_CPU_SUBTYPE_SH7710 is not set
-
-#
-# SH-4 Processor Support
-#
+# CONFIG_CPU_SUBTYPE_SH7712 is not set
+# CONFIG_CPU_SUBTYPE_SH7720 is not set
+# CONFIG_CPU_SUBTYPE_SH7721 is not set
 # CONFIG_CPU_SUBTYPE_SH7750 is not set
 # CONFIG_CPU_SUBTYPE_SH7091 is not set
 # CONFIG_CPU_SUBTYPE_SH7750R is not set
@@ -150,67 +139,88 @@ CONFIG_CPU_SH4AL_DSP=y
 # CONFIG_CPU_SUBTYPE_SH7751R is not set
 # CONFIG_CPU_SUBTYPE_SH7760 is not set
 # CONFIG_CPU_SUBTYPE_SH4_202 is not set
-
-#
-# ST40 Processor Support
-#
-# CONFIG_CPU_SUBTYPE_ST40STB1 is not set
-# CONFIG_CPU_SUBTYPE_ST40GX1 is not set
-
-#
-# SH-4A Processor Support
-#
+# CONFIG_CPU_SUBTYPE_SH7723 is not set
+# CONFIG_CPU_SUBTYPE_SH7763 is not set
 # CONFIG_CPU_SUBTYPE_SH7770 is not set
 # CONFIG_CPU_SUBTYPE_SH7780 is not set
-
-#
-# SH4AL-DSP Processor Support
-#
-# CONFIG_CPU_SUBTYPE_SH73180 is not set
+# CONFIG_CPU_SUBTYPE_SH7785 is not set
+# CONFIG_CPU_SUBTYPE_SHX3 is not set
 CONFIG_CPU_SUBTYPE_SH7343=y
+# CONFIG_CPU_SUBTYPE_SH7722 is not set
+# CONFIG_CPU_SUBTYPE_SH7366 is not set
+# CONFIG_CPU_SUBTYPE_SH5_101 is not set
+# CONFIG_CPU_SUBTYPE_SH5_103 is not set

 #
 # Memory management options
 #
+CONFIG_QUICKLIST=y
 CONFIG_MMU=y
 CONFIG_PAGE_OFFSET=0x80000000
 CONFIG_MEMORY_START=0x0c000000
 CONFIG_MEMORY_SIZE=0x01000000
-CONFIG_32BIT=y
+CONFIG_29BIT=y
 CONFIG_VSYSCALL=y
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
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
 # CONFIG_SPARSEMEM_MANUAL is not set
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPARSEMEM_STATIC=y
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_NR_QUICK=2

 #
 # Cache configuration
 #
 # CONFIG_SH_DIRECT_MAPPED is not set
-# CONFIG_SH_WRITETHROUGH is not set
-# CONFIG_SH_OCRAM is not set
+CONFIG_CACHE_WRITEBACK=y
+# CONFIG_CACHE_WRITETHROUGH is not set
+# CONFIG_CACHE_OFF is not set

 #
 # Processor features
 #
 CONFIG_CPU_LITTLE_ENDIAN=y
-# CONFIG_SH_FPU is not set
+# CONFIG_CPU_BIG_ENDIAN is not set
 # CONFIG_SH_FPU_EMU is not set
 CONFIG_SH_DSP=y
 # CONFIG_SH_STORE_QUEUES is not set
 CONFIG_CPU_HAS_INTEVT=y
 CONFIG_CPU_HAS_SR_RB=y
+CONFIG_CPU_HAS_DSP=y
+
+#
+# Board support
+#
+CONFIG_SOLUTION_ENGINE=y
+CONFIG_SH_7343_SOLUTION_ENGINE=y

 #
-# Timer support
+# Timer and clock configuration
 #
 CONFIG_SH_TMU=y
+CONFIG_SH_TIMER_IRQ
 CONFIG_SH_PCLK_FREQ'000000
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y

 #
 # CPU Frequency scaling
@@ -225,57 +235,50 @@ CONFIG_SH_PCLK_FREQ'000000
 #
 # Companion Chips
 #
-# CONFIG_HD6446X_SERIES is not set
+
+#
+# Additional SuperH Device Drivers
+#
 CONFIG_HEARTBEAT=y
+# CONFIG_PUSH_SWITCH is not set

 #
 # Kernel features
 #
 # CONFIG_HZ_100 is not set
 CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ%0
+# CONFIG_SCHED_HRTICK is not set
 # CONFIG_KEXEC is not set
-# CONFIG_SMP is not set
+# CONFIG_CRASH_DUMP is not set
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
+CONFIG_GUSA=y

 #
 # Boot options
 #
 CONFIG_ZERO_PAGE_OFFSET=0x00001000
 CONFIG_BOOT_LINK_OFFSET=0x00800000
-# CONFIG_UBC_WAKEUP is not set
 # CONFIG_CMDLINE_BOOL is not set

 #
 # Bus options
 #
-# CONFIG_PCI is not set
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
+# CONFIG_CF_ENABLER is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 # CONFIG_PCCARD is not set

 #
-# PCI Hotplug Support
-#
-
-#
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_FLAT is not set
 # CONFIG_BINFMT_MISC is not set

 #
-# Power management options (EXPERIMENTAL)
-#
-# CONFIG_PM is not set
-
-#
 # Networking
 #
 CONFIG_NET=y
@@ -283,22 +286,20 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
 CONFIG_XFRM=y
 # CONFIG_XFRM_USER is not set
 # CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_XFRM_STATISTICS is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_FIB_HASH=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-# CONFIG_IP_PNP_BOOTP is not set
-# CONFIG_IP_PNP_RARP is not set
+# CONFIG_IP_PNP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_ARPD is not set
@@ -310,29 +311,18 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_TUNNEL is not set
 CONFIG_INET_XFRM_MODE_TRANSPORT=y
 CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
@@ -345,10 +335,6 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
 # CONFIG_NET_SCHED is not set

 #
@@ -356,9 +342,20 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set

 #
 # Device Drivers
@@ -367,36 +364,32 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
-
-#
-# Memory Technology Devices (MTD)
-#
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
 CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set

 #
 # User Modules And Translation Layers
 #
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 # CONFIG_FTL is not set
 # CONFIG_NFTL is not set
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set

 #
 # RAM/ROM/Flash chip drivers
@@ -422,13 +415,15 @@ CONFIG_MTD_CFI_UTIL=y
 CONFIG_MTD_RAM=y
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set

 #
 # Mapping drivers for chip access
 #
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
-# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0x0
+CONFIG_MTD_PHYSMAP_LEN=0
+CONFIG_MTD_PHYSMAP_BANKWIDTH=0
 # CONFIG_MTD_PLATRAM is not set

 #
@@ -445,130 +440,101 @@ CONFIG_MTD_RAM=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
 # CONFIG_MTD_NAND is not set
-
-#
-# OneNAND Flash Device Drivers
-#
 # CONFIG_MTD_ONENAND is not set

 #
-# Parallel port support
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
 # CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_COW_COMMON is not set
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
-
-#
-# ATA/ATAPI/MFM/RLL support
-#
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set

 #
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
-# CONFIG_SCSI is not set
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+# CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
+CONFIG_SCSI_PROC_FS=y

 #
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
-# CONFIG_ATA is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
-# CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
+# SCSI support type (disk, tape, CD-ROM)
 #
+# CONFIG_BLK_DEV_SD is not set
+# CONFIG_CHR_DEV_ST is not set
+# CONFIG_CHR_DEV_OSST is not set
+# CONFIG_BLK_DEV_SR is not set
+# CONFIG_CHR_DEV_SG is not set
+# CONFIG_CHR_DEV_SCH is not set

 #
-# I2O device support
+# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
 #
+CONFIG_SCSI_MULTI_LUN=y
+# CONFIG_SCSI_CONSTANTS is not set
+# CONFIG_SCSI_LOGGING is not set
+# CONFIG_SCSI_SCAN_ASYNC is not set
+CONFIG_SCSI_WAIT_SCAN=m

 #
-# Network device support
+# SCSI Transports
 #
+# CONFIG_SCSI_SPI_ATTRS is not set
+# CONFIG_SCSI_FC_ATTRS is not set
+# CONFIG_SCSI_ISCSI_ATTRS is not set
+# CONFIG_SCSI_SAS_LIBSAS is not set
+# CONFIG_SCSI_SRP_ATTRS is not set
+# CONFIG_SCSI_LOWLEVEL is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
 CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-
-#
-# PHY device support
-#
+# CONFIG_VETH is not set
 # CONFIG_PHYLIB is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_AX88796 is not set
 # CONFIG_STNIC is not set
 CONFIG_SMC91X=y
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_B44 is not set
+CONFIG_NETDEV_1000=y
+# CONFIG_E1000E_ENABLED is not set
+CONFIG_NETDEV_10000=y

 #
-# Ethernet (1000 Mbit)
-#
-
-#
-# Ethernet (10000 Mbit)
-#
-
-#
-# Token Ring devices
-#
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# Wan interfaces
+# Wireless LAN
 #
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
-
-#
-# Telephony Support
-#
 # CONFIG_PHONE is not set

 #
@@ -576,13 +542,13 @@ CONFIG_SMC91X=y
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set

 #
 # Userland interfaces
 #
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 # CONFIG_INPUT_EVDEV is not set
 # CONFIG_INPUT_EVBUG is not set

@@ -592,6 +558,7 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
 # CONFIG_INPUT_MISC is not set

@@ -608,6 +575,7 @@ CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set

 #
@@ -626,147 +594,102 @@ CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_UNIX98_PTYS is not set
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT%6
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
-# CONFIG_WATCHDOG is not set
 CONFIG_HW_RANDOM=y
-# CONFIG_GEN_RTC is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
-
-#
-# Ftape, the floppy tape device driver
-#
 # CONFIG_RAW_DRIVER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
-# CONFIG_TELCLOCK is not set
-
-#
-# I2C support
-#
-CONFIG_I2C=y
-CONFIG_I2C_CHARDEV=y
-
-#
-# I2C Algorithms
-#
-# CONFIG_I2C_ALGOBIT is not set
-# CONFIG_I2C_ALGOPCF is not set
-# CONFIG_I2C_ALGOPCA is not set
-
-#
-# I2C Hardware Bus support
-#
-# CONFIG_I2C_OCORES is not set
-# CONFIG_I2C_PARPORT_LIGHT is not set
-# CONFIG_I2C_STUB is not set
-# CONFIG_I2C_PCA_ISA is not set
-
-#
-# Miscellaneous I2C Chip support
-#
-# CONFIG_SENSORS_DS1337 is not set
-# CONFIG_SENSORS_DS1374 is not set
-# CONFIG_SENSORS_EEPROM is not set
-# CONFIG_SENSORS_PCF8574 is not set
-# CONFIG_SENSORS_PCA9539 is not set
-# CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_MAX6875 is not set
-# CONFIG_I2C_DEBUG_CORE is not set
-# CONFIG_I2C_DEBUG_ALGO is not set
-# CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_I2C_DEBUG_CHIP is not set
-
-#
-# SPI support
-#
+# CONFIG_I2C is not set
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
+# CONFIG_WATCHDOG is not set

 #
-# Dallas's 1-wire bus
+# Sonics Silicon Backplane
 #
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set

 #
-# Hardware Monitoring support
+# Multifunction device drivers
 #
-# CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set

 #
-# Misc devices
+# Multimedia devices
 #

 #
-# Multimedia devices
+# Multimedia core support
 #
 CONFIG_VIDEO_DEV=y
-CONFIG_VIDEO_V4L1=y
+CONFIG_VIDEO_V4L2_COMMON=y
+CONFIG_VIDEO_ALLOW_V4L1=y
 CONFIG_VIDEO_V4L1_COMPAT=y
-CONFIG_VIDEO_V4L2=y
-
-#
-# Video Capture Adapters
-#
+# CONFIG_DVB_CORE is not set
+CONFIG_VIDEO_MEDIA=y

 #
-# Video Capture Adapters
+# Multimedia drivers
 #
+# CONFIG_MEDIA_ATTACH is not set
+CONFIG_VIDEO_V4L2=y
+CONFIG_VIDEO_V4L1=y
+CONFIG_VIDEO_CAPTURE_DRIVERS=y
 # CONFIG_VIDEO_ADV_DEBUG is not set
 CONFIG_VIDEO_HELPER_CHIPS_AUTO=y
 # CONFIG_VIDEO_VIVI is not set
 # CONFIG_VIDEO_CPIA is not set
-# CONFIG_VIDEO_SAA5246A is not set
-# CONFIG_VIDEO_SAA5249 is not set
-# CONFIG_TUNER_3036 is not set
-
-#
-# Radio Adapters
-#
-
-#
-# Digital Video Broadcasting Devices
-#
-# CONFIG_DVB is not set
+# CONFIG_SOC_CAMERA is not set
+CONFIG_RADIO_ADAPTERS=y
+# CONFIG_DAB is not set

 #
 # Graphics support
 #
-CONFIG_FIRMWARE_EDID=y
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB_DDC is not set
 # CONFIG_FB_CFB_FILLRECT is not set
 # CONFIG_FB_CFB_COPYAREA is not set
 # CONFIG_FB_CFB_IMAGEBLIT is not set
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
-# CONFIG_FB_EPSON1355 is not set
+
+#
+# Frame buffer hardware drivers
+#
 # CONFIG_FB_S1D13XXX is not set
 # CONFIG_FB_VIRTUAL is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

 #
-# Console display driver support
+# Display device support
 #
-CONFIG_DUMMY_CONSOLE=y
-# CONFIG_FRAMEBUFFER_CONSOLE is not set
+# CONFIG_DISPLAY_SUPPORT is not set

 #
-# Logo configuration
+# Console display driver support
 #
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE is not set
 # CONFIG_LOGO is not set
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

 #
 # Sound
@@ -802,85 +725,63 @@ CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_MPU401 is not set

 #
-# Open Sound System
+# SUPERH devices
 #
-# CONFIG_SOUND_PRIME is not set

 #
-# USB support
+# System on Chip audio support
 #
-# CONFIG_USB_ARCH_HAS_HCD is not set
-# CONFIG_USB_ARCH_HAS_OHCI is not set
-# CONFIG_USB_ARCH_HAS_EHCI is not set
+# CONFIG_SND_SOC is not set

 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# SoC Audio support for SuperH
 #

 #
-# USB Gadget Support
+# ALSA SoC audio for Freescale SOCs
 #
-# CONFIG_USB_GADGET is not set

 #
-# MMC/SD Card support
+# SoC Audio for the Texas Instruments OMAP
 #
-# CONFIG_MMC is not set

 #
-# LED devices
+# Open Sound System
 #
+# CONFIG_SOUND_PRIME is not set
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+# CONFIG_HIDRAW is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
-
-#
-# LED drivers
-#
-
-#
-# LED Triggers
-#
-
-#
-# InfiniBand support
-#
-
-#
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
-#
-
-#
-# Real Time Clock
-#
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_RTC_CLASS is not set
-
-#
-# DMA Engine support
-#
-# CONFIG_DMA_ENGINE is not set
-
-#
-# DMA Clients
-#
-
-#
-# DMA Devices
-#
+# CONFIG_UIO is not set

 #
 # File systems
 #
-# CONFIG_EXT2_FS is not set
-# CONFIG_EXT3_FS is not set
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=y
+CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY is not set
 # CONFIG_QUOTA is not set
-# CONFIG_DNOTIFY is not set
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
@@ -909,7 +810,6 @@ CONFIG_TMPFS=y
 # CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLBFS is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
 # CONFIG_CONFIGFS_FS is not set

 #
@@ -922,40 +822,39 @@ CONFIG_RAMFS=y
 # CONFIG_BEFS_FS is not set
 # CONFIG_BFS_FS is not set
 # CONFIG_EFS_FS is not set
-# CONFIG_JFFS_FS is not set
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
 # CONFIG_JFFS2_SUMMARY is not set
 # CONFIG_JFFS2_FS_XATTR is not set
 # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
 CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
 CONFIG_JFFS2_RTIME=y
 # CONFIG_JFFS2_RUBIN is not set
-# CONFIG_CRAMFS is not set
+CONFIG_CRAMFS=y
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
 CONFIG_NFSD=y
 # CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
-CONFIG_ROOT_NFS=y
+# CONFIG_NFSD_V4 is not set
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_EXPORTFS=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
@@ -963,56 +862,130 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set

 #
 # Partition Types
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
 # CONFIG_NLS is not set
-
-#
-# Profiling support
-#
-# CONFIG_PROFILING is not set
+# CONFIG_DLM is not set

 #
 # Kernel hacking
 #
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN24
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT
 # CONFIG_DEBUG_BUGVERBOSE is not set
-# CONFIG_DEBUG_FS is not set
+# CONFIG_SAMPLES is not set
 # CONFIG_SH_STANDARD_BIOS is not set
-# CONFIG_EARLY_SCIF_CONSOLE is not set
-# CONFIG_KGDB is not set
+CONFIG_EARLY_SCIF_CONSOLE=y
+CONFIG_EARLY_SCIF_CONSOLE_PORT=0xffe00000
+CONFIG_EARLY_PRINTK=y
+# CONFIG_SH_KGDB is not set

 #
 # Security options
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
+# CONFIG_CRYPTO_MANAGER is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
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
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_MD4 is not set
+# CONFIG_CRYPTO_MD5 is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
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
+# CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set

 #
-# Cryptographic options
+# Compression
 #
-# CONFIG_CRYPTO is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_LZO is not set
+CONFIG_CRYPTO_HW=y

 #
 # Library routines
 #
+CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
diff --git a/include/asm-sh/se7343.h b/include/asm-sh/se7343.h
index e7914a5..8d2af77 100644
--- a/include/asm-sh/se7343.h
+++ b/include/asm-sh/se7343.h
@@ -59,24 +59,95 @@
 #define PA_LCD1		0xb8000000
 #define PA_LCD2		0xb8800000

+#define PORT_PACR	0xA4050100
+#define PORT_PBCR	0xA4050102
+#define PORT_PCCR	0xA4050104
+#define PORT_PDCR	0xA4050106
+#define PORT_PECR	0xA4050108
+#define PORT_PFCR	0xA405010A
+#define PORT_PGCR	0xA405010C
+#define PORT_PHCR	0xA405010E
+#define PORT_PJCR	0xA4050110
+#define PORT_PKCR	0xA4050112
+#define PORT_PLCR	0xA4050114
+#define PORT_PMCR	0xA4050116
+#define PORT_PNCR	0xA4050118
+#define PORT_PQCR	0xA405011A
+#define PORT_PRCR	0xA405011C
+#define PORT_PSCR	0xA405011E
+#define PORT_PTCR	0xA4050140
+#define PORT_PUCR	0xA4050142
+#define PORT_PVCR	0xA4050144
+#define PORT_PWCR	0xA4050146
+#define PORT_PYCR	0xA4050148
+#define PORT_PZCR	0xA405014A
+
+#define PORT_PSELA	0xA405014C
+#define PORT_PSELB	0xA405014E
+#define PORT_PSELC	0xA4050150
+#define PORT_PSELD	0xA4050152
+#define PORT_PSELE	0xA4050154
+
+#define PORT_HIZCRA	0xA4050156
+#define PORT_HIZCRB	0xA4050158
+#define PORT_HIZCRC	0xA405015C
+
+#define PORT_DRVCR	0xA4050180
+
+#define PORT_PADR  	0xA4050120
+#define PORT_PBDR  	0xA4050122
+#define PORT_PCDR  	0xA4050124
+#define PORT_PDDR  	0xA4050126
+#define PORT_PEDR  	0xA4050128
+#define PORT_PFDR  	0xA405012A
+#define PORT_PGDR  	0xA405012C
+#define PORT_PHDR  	0xA405012E
+#define PORT_PJDR  	0xA4050130
+#define PORT_PKDR  	0xA4050132
+#define PORT_PLDR  	0xA4050134
+#define PORT_PMDR  	0xA4050136
+#define PORT_PNDR  	0xA4050138
+#define PORT_PQDR  	0xA405013A
+#define PORT_PRDR  	0xA405013C
+#define PORT_PTDR  	0xA4050160
+#define PORT_PUDR  	0xA4050162
+#define PORT_PVDR  	0xA4050164
+#define PORT_PWDR  	0xA4050166
+#define PORT_PYDR  	0xA4050168
+
+#define MSTPCR0		0xA4150030
+#define MSTPCR1		0xA4150034
+#define MSTPCR2		0xA4150038
+
+#define FPGA_IN		0xb1400000
+#define FPGA_OUT	0xb1400002
+
 #define __IO_PREFIX	sh7343se
 #include <asm/io_generic.h>

-/* External Multiplexed interrupts */
-#define PC_IRQ0		OFFCHIP_IRQ_BASE
-#define PC_IRQ1		(PC_IRQ0 + 1)
-#define PC_IRQ2		(PC_IRQ1 + 1)
-#define PC_IRQ3		(PC_IRQ2 + 1)
+#define IRQ0_IRQ        32
+#define IRQ1_IRQ        33
+#define IRQ4_IRQ        36
+#define IRQ5_IRQ        37
+
+#define SE7343_FPGA_IRQ_MRSHPC0	0
+#define SE7343_FPGA_IRQ_MRSHPC1	1
+#define SE7343_FPGA_IRQ_MRSHPC2	2
+#define SE7343_FPGA_IRQ_MRSHPC3	3
+#define SE7343_FPGA_IRQ_SMC	6	/* EXT_IRQ2 */
+#define SE7343_FPGA_IRQ_USB	8

-#define EXT_IRQ0	(PC_IRQ3 + 1)
-#define EXT_IRQ1	(EXT_IRQ0 + 1)
-#define EXT_IRQ2	(EXT_IRQ1 + 1)
-#define EXT_IRQ3	(EXT_IRQ2 + 1)
+#define SE7343_FPGA_IRQ_NR	11
+#define SE7343_FPGA_IRQ_BASE	120

-#define USB_IRQ0	(EXT_IRQ3 + 1)
-#define USB_IRQ1	(USB_IRQ0 + 1)
+#define MRSHPC_IRQ3    	(SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_MRSHPC3)
+#define MRSHPC_IRQ2    	(SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_MRSHPC2)
+#define MRSHPC_IRQ1    	(SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_MRSHPC1)
+#define MRSHPC_IRQ0    	(SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_MRSHPC0)
+#define SMC_IRQ		(SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_SMC)
+#define USB_IRQ		(SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_USB)

-#define UART_IRQ0	(USB_IRQ1 + 1)
-#define UART_IRQ1	(UART_IRQ0 + 1)
+/* arch/sh/boards/se/7343/irq.c */
+void init_7343se_IRQ(void);

 #endif  /* __ASM_SH_HITACHI_SE7343_H */
