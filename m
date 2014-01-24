From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 24 Jan 2014 22:40:21 +0000
Subject: [PATCH V2 1/2] ARM: shmobile: lager: Enable modules in defconfig
Message-Id: <1390603222-13351-2-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This enables modules, module unloading and versioning support for Lager.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/configs/lager_defconfig | 3 +++
 1 file changed, 3 insertions(+)

Changes in V2:
* enabled module unloading support.

diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index ee93b8a..9ba837b 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -8,6 +8,9 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
 # CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
-- 
1.8.3.1

