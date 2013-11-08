From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 08 Nov 2013 23:47:45 +0000
Subject: [PATCH] ARM: shmobile: kzm9d: Enable AUTO_ZRELADDR in defconfig
Message-Id: <1383954465-6056-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This is required to allow the load address to be supplied
as an environment variable when building a uImage.

LOADADDR=0x40008000 ARCH=arm make uImage

This is necessary since "ARM: shmobile: Remove legacy KZM9D board code"

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/kzm9d_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/kzm9d_defconfig b/arch/arm/configs/kzm9d_defconfig
index 6c37f4a..e6aed23 100644
--- a/arch/arm/configs/kzm9d_defconfig
+++ b/arch/arm/configs/kzm9d_defconfig
@@ -32,6 +32,7 @@ CONFIG_FORCE_MAX_ZONEORDER
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
+CONFIG_AUTO_ZRELADDR=y
 CONFIG_VFP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM_RUNTIME=y
-- 
1.8.4

