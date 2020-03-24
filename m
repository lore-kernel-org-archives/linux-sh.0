From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 Mar 2020 16:26:25 +0000
Subject: [PATCH 02/10] sh: sort the selects for SUPERH alphabetically
Message-Id: <20200324162633.754714-3-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200324162633.754714-1-hch@lst.de>
In-Reply-To: <20200324162633.754714-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Ensure there is an order for the selects of the main SUPERH symbol,
as well as the SUPERH32 and SUPER64 ones.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/Kconfig | 87 ++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 44 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9ece111b0254..808b638b11f3 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -2,59 +2,58 @@
 config SUPERH
 	def_bool y
 	select ARCH_HAS_BINFMT_FLAT if !MMU
+	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAVE_CUSTOM_GPIO_H
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
 	select ARCH_MIGHT_HAVE_PC_PARPORT
-	select HAVE_PATA_PLATFORM
+	select ARCH_WANT_IPC_PARSE_VERSION
 	select CLKDEV_LOOKUP
+	select CPU_NO_EFFICIENT_FFS
 	select DMA_DECLARE_COHERENT
-	select HAVE_IDE if HAS_IOPORT_MAP
-	select HAVE_MEMBLOCK_NODE_MAP
-	select HAVE_OPROFILE
+	select GENERIC_ATOMIC64
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
+	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IRQ_SHOW
+	select GENERIC_PCI_IOMAP if PCI
+	select GENERIC_SCHED_CLOCK
+	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
+	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_PERF_EVENTS
 	select HAVE_DEBUG_BUGVERBOSE
-	select HAVE_FAST_GUP if MMU
-	select ARCH_HAVE_CUSTOM_GPIO_H
-	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
-	select ARCH_HAS_GCOV_PROFILE_ALL
-	select PERF_USE_VMALLOC
 	select HAVE_DEBUG_KMEMLEAK
-	select HAVE_KERNEL_GZIP
-	select CPU_NO_EFFICIENT_FFS
+	select HAVE_FAST_GUP if MMU
+	select HAVE_FUTEX_CMPXCHG if FUTEX
+	select HAVE_IDE if HAS_IOPORT_MAP
 	select HAVE_KERNEL_BZIP2
+	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZMA
-	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_LZO
+	select HAVE_KERNEL_XZ
+	select HAVE_MEMBLOCK_NODE_MAP
+	select HAVE_MOD_ARCH_SPECIFIC if DWARF_UNWINDER
+	select HAVE_NMI
+	select HAVE_OPROFILE
+	select HAVE_PATA_PLATFORM
+	select HAVE_PERF_EVENTS
+	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_UID16
-	select ARCH_WANT_IPC_PARSE_VERSION
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_REGS_AND_STACK_ACCESS_API
-	select MAY_HAVE_SPARSE_IRQ
 	select IRQ_FORCED_THREADING
-	select RTC_LIB
-	select GENERIC_ATOMIC64
-	select GENERIC_IRQ_SHOW
-	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_IDLE_POLL_SETUP
-	select GENERIC_CLOCKEVENTS
-	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
-	select GENERIC_PCI_IOMAP if PCI
-	select GENERIC_SCHED_CLOCK
-	select GENERIC_STRNCPY_FROM_USER
-	select GENERIC_STRNLEN_USER
-	select HAVE_MOD_ARCH_SPECIFIC if DWARF_UNWINDER
+	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA
+	select NEED_SG_DMA_LENGTH
 	select NO_GENERIC_PCI_IOPORT_MAP if PCI
-	select OLD_SIGSUSPEND
 	select OLD_SIGACTION
+	select OLD_SIGSUSPEND
 	select PCI_DOMAINS if PCI
-	select HAVE_ARCH_AUDITSYSCALL
-	select HAVE_FUTEX_CMPXCHG if FUTEX
-	select HAVE_NMI
-	select NEED_SG_DMA_LENGTH
-	select ARCH_HAS_GIGANTIC_PAGE
-
+	select PERF_USE_VMALLOC
+	select RTC_LIB
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
@@ -64,23 +63,23 @@ config SUPERH
 config SUPERH32
 	def_bool "$(ARCH)" = "sh"
 	select ARCH_32BIT_OFF_T
+	select ARCH_HIBERNATION_POSSIBLE if MMU
+	select ARCH_WANT_IPC_PARSE_VERSION
 	select GUP_GET_PTE_LOW_HIGH if X2TLB
-	select HAVE_KPROBES
-	select HAVE_KRETPROBES
-	select HAVE_IOREMAP_PROT if MMU && !X2TLB
+	select HAVE_ARCH_KGDB
+	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
-	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_NMI_ENTER if DYNAMIC_FTRACE
-	select ARCH_WANT_IPC_PARSE_VERSION
-	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_ARCH_KGDB
 	select HAVE_HW_BREAKPOINT
+	select HAVE_IOREMAP_PROT if MMU && !X2TLB
+	select HAVE_KPROBES
+	select HAVE_KRETPROBES
 	select HAVE_MIXED_BREAKPOINTS_REGS
+	select HAVE_STACKPROTECTOR
 	select PERF_EVENTS
-	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select SPARSE_IRQ
-	select HAVE_STACKPROTECTOR
 
 config SUPERH64
 	def_bool "$(ARCH)" = "sh64"
-- 
2.25.1
