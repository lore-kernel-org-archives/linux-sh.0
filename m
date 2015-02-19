From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 19 Feb 2015 17:31:01 +0000
Subject: [PATCH] Mismerge in "Merge branch 'heads/sh-drivers-for-v3.21' into devel"
Message-Id: <1424367061-11669-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Simon,

Commit fc41739c30435c50 ("Merge branch 'heads/sh-drivers-for-v3.21'
into devel"), the top of renesas-devel-20150218-v3.19, did a mismerge
in two files, resurrecting two chunks that had just been removed in
commit 62cbd0a23ad0fbe1 ("ARM: shmobile: r8a73a4: ape6evm: Remove
legacy platform").

Below is the fix to squash into the merge commit.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/Kconfig  | 6 ------
 arch/arm/mach-shmobile/Makefile | 1 -
 2 files changed, 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index c637fb4db3fe427b..0cbe84a7cd68c45f 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -128,12 +128,6 @@ config ARCH_R8A7779
 
 comment "Renesas ARM SoCs Board Type"
 
-config MACH_APE6EVM
-	bool "APE6EVM board"
-	depends on ARCH_R8A73A4
-	select SMSC_PHY if SMSC911X
-	select USE_OF
-
 config MACH_ARMADILLO800EVA
 	bool "Armadillo-800 EVA board"
 	depends on ARCH_R8A7740
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 8ceeac59cfbb5774..94890b62ab8cc514 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -53,7 +53,6 @@ obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
 else
-obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
 obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
-- 
1.9.1

