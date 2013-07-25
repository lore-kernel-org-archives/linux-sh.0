From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 25 Jul 2013 02:13:43 +0000
Subject: [PATCH v2 3/3] ARM: shmobile: marzen: Enable ARM_APPENDED_DTB in defconfig
Message-Id: <1374718423-24230-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1374718423-24230-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1374718423-24230-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

"ARM: shmobile: marzen: Switch to DT_MACHINE_START" moves marzen
over to use DT_MACHINE_START, however, the prevelant boot loader
does not support booting with a separate dtb. Thus, it makes
sense to use ARM_APPENDED_DTB by default.

This is consistent with other shmobile defconfigs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/marzen_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 494e70a..82e4040 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -29,6 +29,7 @@ CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
 CONFIG_CMDLINE="console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs ip=on"
 CONFIG_CMDLINE_FORCE=y
 CONFIG_KEXEC=y
-- 
1.8.2.1

