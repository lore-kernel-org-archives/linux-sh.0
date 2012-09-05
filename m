From: Simon Horman <horms@verge.net.au>
Date: Wed, 05 Sep 2012 01:34:53 +0000
Subject: [PATCH 3/3] ARM: shmobile: armadillo800eva: enable rw rootfs mount
Message-Id: <1346808893-14124-4-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1346808893-14124-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1346808893-14124-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

armadillo800eva default boot loader is "hermit",
and it's tag->u.core.flags has flag when kernel boots.
Because of this, ${LINUX}/arch/arm/kernel/setup.c :: parse_tag_core()
didn't remove MS_RDONLY flag from root_mountflags.
Thus, the rootfs is mounted as "readonly".
This patch adds "rw" kernel parameter,
and enable read/write mounts for rootfs

Cc: Masahiro Nakai <nakai@atmark-techno.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/armadillo800eva_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 7d87184..90610c7 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -33,7 +33,7 @@ CONFIG_AEABI=y
 CONFIG_FORCE_MAX_ZONEORDER
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize@96,wsize@96"
+CONFIG_CMDLINE="console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize@96,wsize@96 rw"
 CONFIG_CMDLINE_FORCE=y
 CONFIG_KEXEC=y
 CONFIG_VFP=y
-- 
1.7.10.4

