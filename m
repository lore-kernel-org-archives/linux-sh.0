From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 21 Aug 2010 13:47:59 +0000
Subject: [PATCH] sh: Set CONFIG_SYSFS_DEPRECATED_V2=n
Message-Id: <2bf9c3bb585d142503d6b7f3669e2138ba9ed112.1282398356.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

As the help for the config option suggests, this option really shouldn't
be set by default for any recent distribution as it changes the layout
of sysfs. I spotted this while running debian when udev got very
confused by the sysfs layout and failed to create some device nodes.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/configs/sh7785lcr_defconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sh/configs/sh7785lcr_defconfig b/arch/sh/configs/sh7785lcr_defconfig
index ee6b81f..51561f5 100644
--- a/arch/sh/configs/sh7785lcr_defconfig
+++ b/arch/sh/configs/sh7785lcr_defconfig
@@ -4,7 +4,6 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_SLAB=y
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
-- 
1.7.1

