From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 01 May 2016 05:08:26 +0000
Subject: [PATCH RESEND 02/12] sh: Config update for OF mode
Message-Id: <1462079316-27771-3-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

DeviceTreee support is use liner IRQ.
And use generic function (clock / io / IRQ).

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/Kconfig             | 26 +++++++++++++++++++++++---
 arch/sh/boards/Kconfig      |  4 ++++
 arch/sh/drivers/Makefile    |  2 ++
 arch/sh/include/asm/io.h    |  6 ++++++
 arch/sh/kernel/cpu/Makefile |  8 ++++++--
 arch/sh/kernel/cpu/clock.c  |  9 ++++++---
 drivers/sh/Makefile         |  2 ++
 7 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7ed20fc..d4177ba 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -28,7 +28,7 @@ config SUPERH
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select MAY_HAVE_SPARSE_IRQ
+	select MAY_HAVE_SPARSE_IRQ if !SH_DEVICE_TREE
 	select IRQ_FORCED_THREADING
 	select RTC_LIB
 	select GENERIC_ATOMIC64
@@ -66,7 +66,7 @@ config SUPERH32
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select PERF_EVENTS
 	select ARCH_HIBERNATION_POSSIBLE if MMU
-	select SPARSE_IRQ
+	select SPARSE_IRQ if !SH_DEVICE_TREE
 	select HAVE_CC_STACKPROTECTOR
 
 config SUPERH64
@@ -745,6 +745,26 @@ endmenu
 
 menu "Boot options"
 
+config USE_BUILTIN_DTB
+	bool "Use builtin DTB"
+	default n
+	depends on SH_DEVICE_TREE
+	help
+	  Link a device tree blob for particular hardware into the kernel,
+	  suppressing use of the DTB pointer provided by the bootloader.
+	  This option should only be used with legacy bootloaders that are
+	  not capable of providing a DTB to the kernel, or for experimental
+	  hardware without stable device tree bindings.
+
+config BUILTIN_DTB_SOURCE
+	string "Source file for builtin DTB"
+	default ""
+	depends on USE_BUILTIN_DTB
+	help
+	  Base name (without suffix, relative to arch/sh/boot/dts) for the
+	  a DTS file that will be used to produce the DTB linked into the
+	  kernel.
+
 config ZERO_PAGE_OFFSET
 	hex
 	default "0x00010000" if PAGE_SIZE_64KB || SH_RTS7751R2D || \
@@ -839,7 +859,7 @@ config PCI
 	depends on SYS_SUPPORTS_PCI
 	select PCI_DOMAINS
 	select GENERIC_PCI_IOMAP
-	select NO_GENERIC_PCI_IOPORT_MAP
+	select NO_GENERIC_PCI_IOPORT_MAP if !SH_DEVICE_TREE
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 5e52d53..98f884e 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -12,6 +12,10 @@ config SH_DEVICE_TREE
 	select OF_EARLY_FLATTREE
 	select CLKSRC_OF
 	select GENERIC_CALIBRATE_DELAY
+	select COMMON_CLK
+	select GENERIC_IOMAP
+	select GENERIC_IRQ_CHIP
+	select SYS_SUPPORTS_PCI
 	help
 	  Select Board Described by Device Tree to build a kernel that
 	  does not hard-code any board-specific knowledge but instead uses
diff --git a/arch/sh/drivers/Makefile b/arch/sh/drivers/Makefile
index e13f06b..382e86f 100644
--- a/arch/sh/drivers/Makefile
+++ b/arch/sh/drivers/Makefile
@@ -4,7 +4,9 @@
 
 obj-y		+= dma/
 
+ifndef CONFIG_SH_DEVICE_TREE
 obj-$(CONFIG_PCI)		+= pci/
+endif
 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
 obj-$(CONFIG_PUSH_SWITCH)	+= push-switch.o
 obj-$(CONFIG_HEARTBEAT)		+= heartbeat.o
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 3280a6b..df62a9f 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -387,6 +387,12 @@ static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
 int valid_phys_addr_range(phys_addr_t addr, size_t size);
 int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 
+#define PCI_IOBASE	0xfe240000UL
+
+#define HAVE_ARCH_PIO_SIZE
+#define PIO_OFFSET	PCI_IOBASE
+#define PIO_MASK	0x3ffffUL
+#define PIO_RESERVED	0x40000UL
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_SH_IO_H */
diff --git a/arch/sh/kernel/cpu/Makefile b/arch/sh/kernel/cpu/Makefile
index accc7ca..22ad0ee 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -16,6 +16,10 @@ obj-$(CONFIG_ARCH_SHMOBILE)	+= shmobile/
 # Common interfaces.
 
 obj-$(CONFIG_SH_ADC)		+= adc.o
+ifndef CONFIG_COMMON_CLK
 obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
-
-obj-y	+= irq/ init.o clock.o fpu.o pfc.o proc.o
+endif
+ifndef CONFIG_GENERIC_IRQ_CHIP
+obj-y	+= irq/
+endif
+obj-y	+= init.o clock.o fpu.o pfc.o proc.o
diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index 4187cf4..856a05c 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -17,19 +17,21 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/clk.h>
+#include <linux/of.h>
 #include <asm/clock.h>
 #include <asm/machvec.h>
 
 int __init clk_init(void)
 {
-	int ret;
+	int ret = 0;
 
+#ifndef CONFIG_COMMON_CLK
 	ret = arch_clk_init();
 	if (unlikely(ret)) {
 		pr_err("%s: CPU clock registration failed.\n", __func__);
 		return ret;
 	}
-
+#endif
 	if (sh_mv.mv_clk_init) {
 		ret = sh_mv.mv_clk_init();
 		if (unlikely(ret)) {
@@ -39,12 +41,13 @@ int __init clk_init(void)
 		}
 	}
 
+#ifndef CONFIG_COMMON_CLK
 	/* Kick the child clocks.. */
 	recalculate_root_clocks();
 
 	/* Enable the necessary init clocks */
 	clk_enable_init_clocks();
-
+#endif
 	return ret;
 }
 
diff --git a/drivers/sh/Makefile b/drivers/sh/Makefile
index 114203f..e7888ea 100644
--- a/drivers/sh/Makefile
+++ b/drivers/sh/Makefile
@@ -1,7 +1,9 @@
 #
 # Makefile for the SuperH specific drivers.
 #
+ifneq ($(CONFIG_RENESAS_SH_INTC),y)
 obj-$(CONFIG_SH_INTC)			+= intc/
+endif
 ifneq ($(CONFIG_COMMON_CLK),y)
 obj-$(CONFIG_HAVE_CLK)			+= clk/
 endif
-- 
2.7.0

