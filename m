From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 24 Jan 2014 12:23:51 +0000
Subject: [PATCH 2/2] ARM: shmobile: koelsch: Enable modules in defconfig
Message-Id: <1390566231-18928-3-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This enables modules and module versioning support for Koelsch.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/configs/koelsch_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index 3015797..1ce71b2 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -8,6 +8,8 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
+CONFIG_MODULES=y
+CONFIG_MODVERSIONS=y
 CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A7791=y
 CONFIG_MACH_KOELSCH=y
-- 
1.8.3.1

