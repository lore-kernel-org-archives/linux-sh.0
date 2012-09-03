From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 03 Sep 2012 06:06:52 +0000
Subject: [PATCH] ARM: shmobile: armadillo800eva: enable rw rootfs mount
Message-Id: <87d323ej2e.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

armadillo800eva default boot loader is "hermit",
and it's tag->u.core.flags has flag when kernel boots.
Because of this, ${LINUX}/arch/arm/kernel/setup.c :: parse_tag_core()
didn't remove MS_RDONLY flag from root_mountflags.
Thus, the rootfs is mounted as "readonly".
This patch adds "rw" kernel parameter,
and enable read/write mounts for rootfs

Cc: Masahiro Nakai <nakai@atmark-techno.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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
1.7.9.5

