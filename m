From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Aug 2008 09:22:49 +0000
Subject: [PATCH] sh: update Migo-R defconfig
Message-Id: <20080827092249.9122.50993.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch updates the MigoR defconfig to include the recently merged
uio_pdrv_genirq driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/configs/migor_defconfig |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

--- 0001/arch/sh/configs/migor_defconfig
+++ work/arch/sh/configs/migor_defconfig	2008-08-26 14:18:31.000000000 +0900
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26
-# Wed Jul 30 01:44:41 2008
+# Linux kernel version: 2.6.27-rc4
+# Tue Aug 26 14:18:17 2008
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
@@ -21,7 +22,6 @@ CONFIG_LOCKDEP_SUPPORT=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
 CONFIG_ARCH_NO_VIRT_TO_BUS=y
-CONFIG_ARCH_SUPPORTS_AOUT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -87,6 +87,7 @@ CONFIG_HAVE_OPROFILE=y
 # CONFIG_USE_GENERIC_SMP_HELPERS is not set
 CONFIG_HAVE_CLK=y
 CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
@@ -270,6 +271,7 @@ CONFIG_HZ%0
 # CONFIG_SCHED_HRTICK is not set
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
+CONFIG_SECCOMP=y
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
@@ -294,10 +296,6 @@ CONFIG_CMDLINE="console=ttySC0,115200 ea
 #
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-
-#
-# Networking
-#
 CONFIG_NET=y
 
 #
@@ -649,6 +647,7 @@ CONFIG_HW_RANDOM=y
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
 # CONFIG_I2C_CHARDEV is not set
+CONFIG_I2C_HELPER_AUTO=y
 
 #
 # I2C Hardware Bus support
@@ -709,6 +708,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_CORE is not set
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_PASIC3 is not set
+# CONFIG_MFD_TMIO is not set
 
 #
 # Multimedia devices
@@ -755,6 +755,8 @@ CONFIG_USB_ARCH_HAS_HCD=y
 # CONFIG_USB is not set
 # CONFIG_USB_OTG_WHITELIST is not set
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_MUSB_HDRC is not set
+# CONFIG_USB_GADGET_MUSB_HDRC is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -842,7 +844,10 @@ CONFIG_RTC_DRV_RS5C372=y
 #
 CONFIG_RTC_DRV_SH=y
 # CONFIG_DMADEVICES is not set
-# CONFIG_UIO is not set
+CONFIG_UIO=y
+# CONFIG_UIO_PDRV is not set
+CONFIG_UIO_PDRV_GENIRQ=y
+# CONFIG_UIO_SMX is not set
 
 #
 # File systems
