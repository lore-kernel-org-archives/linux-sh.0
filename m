From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 09 Dec 2009 05:21:42 +0000
Subject: [PATCH] sh: mach-ecovec24: MEMORY_SIZE fixup
Message-Id: <uy6lcvi1l.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
This patch is v2 of "sh: mach-ecovec24: update ecovec24 defconfig"

 arch/sh/configs/ecovec24-romimage_defconfig |    2 +-
 arch/sh/configs/ecovec24_defconfig          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/configs/ecovec24-romimage_defconfig b/arch/sh/configs/ecovec24-romimage_defconfig
index 0774924..4687470 100644
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
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index ac64697..cad9184 100644
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
-- 
1.6.3.3

