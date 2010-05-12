From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 May 2010 08:34:58 +0000
Subject: [PATCH 02/05] ARM: mach-shmobile: Add CONFIG_FORCE_MAX_ZONEORDER
Message-Id: <20100512083458.9395.98203.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Allow SH-Mobile ARM to specify CONFIG_FORCE_MAX_ZONEORDER.
The Kconfig entry is taken from SH and non-4K page size
stuff has been trimmed away.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2010-05-12 15:21:55.000000000 +0900
@@ -69,6 +69,21 @@ config MEMORY_SIZE
 	  be overridden as normal by the 'mem=' argument on the kernel command
 	  line.
 
+config FORCE_MAX_ZONEORDER
+	int "Maximum zone order"
+	range 11 64
+	default "11"
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value.
+
+	  This config option is actually maximum order plus one. For example,
+	  a value of 11 means that the largest free memory block is 2^10 pages.
+
 endmenu
 
 menu "Timer and clock configuration"
