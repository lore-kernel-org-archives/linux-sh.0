From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 25 Aug 2014 01:10:00 +0000
Subject: [PATCH] ARM: shmobile: bockw: Do not disable SUSPEND in defconfig
Message-Id: <99923753e7c17a9c9d46bfe4d7fa543e426ec647.1408926588.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1408926588.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1408926588.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

As of "ARM: shmobile: r8a7778: Add missing call to shmobile_init_late()"
suspend-to-ram is now supported on the r8a7778 SoC and thus the bockw
board.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/bockw_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 70b3f45..1dde5da 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -29,7 +29,6 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_VFP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-# CONFIG_SUSPEND is not set
 CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.0.1

