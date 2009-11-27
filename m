From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 27 Nov 2009 09:01:55 +0000
Subject: [PATCH] sh: mach-ecovec24: update ecovec24 defconfig
Message-Id: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

o modify memory size
o change cache configuration to boot

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
I change cache configuration 
because currect kernel can not use CONFIG_CACHE_WRITEBACK

 arch/sh/configs/ecovec24-romimage_defconfig |    6 +++---
 arch/sh/configs/ecovec24_defconfig          |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/configs/ecovec24-romimage_defconfig b/arch/sh/configs/ecovec24-romimage_defconfig
index 0774924..9145fa3 100644
--- a/arch/sh/configs/ecovec24-romimage_defconfig
+++ b/arch/sh/configs/ecovec24-romimage_defconfig
@@ -203,7 +203,7 @@ CONFIG_MMU=y
 CONFIG_PAGE_OFFSET=0x80000000
 CONFIG_FORCE_MAX_ZONEORDER
 CONFIG_MEMORY_START=0x08000000
-CONFIG_MEMORY_SIZE=0x08000000
+CONFIG_MEMORY_SIZE=0x10000000
 CONFIG_29BIT=y
 # CONFIG_X2TLB is not set
 CONFIG_VSYSCALL=y
@@ -237,8 +237,8 @@ CONFIG_DEFAULT_MMAP_MIN_ADDR@96
 #
 # Cache configuration
 #
-CONFIG_CACHE_WRITEBACK=y
-# CONFIG_CACHE_WRITETHROUGH is not set
+# CONFIG_CACHE_WRITEBACK is not set
+CONFIG_CACHE_WRITETHROUGH=y
 # CONFIG_CACHE_OFF is not set
 
 #
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index ac64697..6a20b87 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -204,7 +204,7 @@ CONFIG_MMU=y
 CONFIG_PAGE_OFFSET=0x80000000
 CONFIG_FORCE_MAX_ZONEORDER
 CONFIG_MEMORY_START=0x08000000
-CONFIG_MEMORY_SIZE=0x08000000
+CONFIG_MEMORY_SIZE=0x10000000
 CONFIG_29BIT=y
 # CONFIG_X2TLB is not set
 CONFIG_VSYSCALL=y
@@ -238,8 +238,8 @@ CONFIG_DEFAULT_MMAP_MIN_ADDR@96
 #
 # Cache configuration
 #
-CONFIG_CACHE_WRITEBACK=y
-# CONFIG_CACHE_WRITETHROUGH is not set
+# CONFIG_CACHE_WRITEBACK is not set
+CONFIG_CACHE_WRITETHROUGH=y
 # CONFIG_CACHE_OFF is not set
 
 #
-- 
1.6.3.3

