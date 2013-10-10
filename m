From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 10 Oct 2013 07:16:27 +0000
Subject: [PATCH 02/11] ARM: shmobile: marzen: Do not set command line in defconfig
Message-Id: <1381389396-22000-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1381389396-22000-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1381389396-22000-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

As a set towards moving shmobile towards multi-platform
the kernel command line should be set in the DTB rather than
in the kernel config.

marzen already has the command line present in its DTS file
but it was being overrirden by the kernel config.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/marzen_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 000e920..96391fc 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -30,8 +30,6 @@ CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
-CONFIG_CMDLINE="console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs ip=on"
-CONFIG_CMDLINE_FORCE=y
 CONFIG_KEXEC=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM_RUNTIME=y
-- 
1.8.4

