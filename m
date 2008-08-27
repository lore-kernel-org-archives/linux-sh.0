From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Aug 2008 09:23:52 +0000
Subject: [PATCH] sh: update AP325RXA defconfig
Message-Id: <20080827092352.9125.23065.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch updates the AP325RXA defconfig to include the recently merged
uio_pdrv_genirq driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/configs/ap325rxa_defconfig |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- 0001/arch/sh/configs/ap325rxa_defconfig
+++ work/arch/sh/configs/ap325rxa_defconfig	2008-08-26 14:21:29.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26
-# Wed Jul 30 01:18:59 2008
+# Linux kernel version: 2.6.27-rc4
+# Tue Aug 26 14:21:17 2008
 #
 CONFIG_SUPERH=y
 CONFIG_SUPERH32=y
@@ -11,6 +11,7 @@ CONFIG_GENERIC_BUG=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_TIME=y
@@ -20,7 +21,6 @@ CONFIG_LOCKDEP_SUPPORT=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_ARCH_NO_VIRT_TO_BUS=y
-CONFIG_ARCH_SUPPORTS_AOUT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -58,7 +58,6 @@ CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_UID16=y
 CONFIG_SYSCTL_SYSCALL=y
-CONFIG_SYSCTL_SYSCALL_CHECK=y
 # CONFIG_KALLSYMS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
@@ -89,6 +88,7 @@ CONFIG_HAVE_OPROFILE=y
 # CONFIG_USE_GENERIC_SMP_HELPERS is not set
 CONFIG_HAVE_CLK=y
 CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -261,9 +261,10 @@ CONFIG_HZ_250=y
 # CONFIG_HZ_300 is not set
 # CONFIG_HZ_1000 is not set
 CONFIG_HZ%0
-# CONFIG_SCHED_HRTICK is not set
+CONFIG_SCHED_HRTICK=y
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
+CONFIG_SECCOMP=y
 # CONFIG_PREEMPT_NONE is not set
 # CONFIG_PREEMPT_VOLUNTARY is not set
 CONFIG_PREEMPT=y
@@ -289,10 +290,6 @@ CONFIG_CMDLINE="console=tty1 console=tty
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-
-#
-# Networking
-#
 CONFIG_NET=y
 
 #
@@ -647,6 +644,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
 
 #
 # Multimedia devices
@@ -690,7 +688,10 @@ CONFIG_DUMMY_CONSOLE=y
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_RTC_CLASS is not set
 # CONFIG_DMADEVICES is not set
-# CONFIG_UIO is not set
+CONFIG_UIO=y
+# CONFIG_UIO_PDRV is not set
+CONFIG_UIO_PDRV_GENIRQ=y
+# CONFIG_UIO_SMX is not set
 
 #
 # File systems
@@ -854,6 +855,7 @@ CONFIG_FRAME_WARN24
 # CONFIG_DEBUG_KERNEL is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_MEMORY_INIT is not set
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 # CONFIG_SAMPLES is not set
 # CONFIG_SH_STANDARD_BIOS is not set
 # CONFIG_EARLY_SCIF_CONSOLE is not set
