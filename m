From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Date: Wed, 08 Apr 2020 16:18:46 +0000
Subject: [PATCH] arch: sh: configs: remove CONFIG_PCIEASPM_DEBUG
Message-Id: <20200408161846.30031-1-cascardo@canonical.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ysato@users.sourceforge.jp, dalias@libc.org, cascardo@canonical.com

This option has been removed, so remove any leftover from defconfigs.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 arch/sh/configs/sdk7786_defconfig | 1 -
 arch/sh/configs/urquell_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 7fa116b436c3..3eaf5bbf5959 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -75,7 +75,6 @@ CONFIG_CMDLINE="console=ttySC1,115200 earlyprintk=sh-sci.1,115200 root=/dev/sda1
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCIEAER_INJECT=y
-CONFIG_PCIEASPM_DEBUG=y
 CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index cb2f56468fe0..c981d5b7e68c 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -33,7 +33,6 @@ CONFIG_KEXEC=y
 CONFIG_SECCOMP=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
-CONFIG_PCIEASPM_DEBUG=y
 CONFIG_PCI_DEBUG=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM=y
-- 
2.20.1
