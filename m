From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 28 Nov 2013 09:08:38 +0000
Subject: [PATCH 08/16] ARM: shmobile: marzen: Enable CONFIG_VFP in defconfig
Message-Id: <8f1c35732942035ea9bfff6d6848490b0131d140.1385629477.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1385629477.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1385629477.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

CONFIG_VFP is required to boot into a Debian armhf user-space.
This change brings the marzen defconfig into line with
other shmobile defconfigs.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/marzen_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index ebaaead..39e2dfe 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -30,6 +30,7 @@ CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
+CONFIG_VFP=y
 CONFIG_KEXEC=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM_RUNTIME=y
-- 
1.8.4

