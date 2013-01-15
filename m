From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 15 Jan 2013 00:49:35 +0000
Subject: [PATCH 5/5] ARM: mach-shmobile: kzm9d: update defconfig
Message-Id: <1358210975-26970-6-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1358210975-26970-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1358210975-26970-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Do not disable SUSPEND

  Suspend seems to work fine on the kzm9d.

  This is part of an effort reduce differences between mach-shmobile
  defconfigs with a view to using a common defconfig.

* Enable PM_RUNTIME

  This also seems to work fine on the kzm9d.

  This is part of an effort reduce differences between mach-shmobile
  defconfigs with a view to using a common defconfig.

* Move kernel command line from defconfig to dts.

  This brings us one small step closer to sharing defconfig
  between kzm9d and other boards.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts |    2 +-
 arch/arm/configs/kzm9d_defconfig  |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 297e3ba..b9b3241 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -21,6 +21,6 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS1,115200n81";
+		bootargs = "console=tty0 console=ttyS1,115200n81 earlyprintk=serial8250-em.1,115200n81 mem8M@0x40000000 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize@96,wsize@96";
 	};
 };
diff --git a/arch/arm/configs/kzm9d_defconfig b/arch/arm/configs/kzm9d_defconfig
index 8c49df6..6c37f4a 100644
--- a/arch/arm/configs/kzm9d_defconfig
+++ b/arch/arm/configs/kzm9d_defconfig
@@ -32,11 +32,9 @@ CONFIG_FORCE_MAX_ZONEORDER
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
-CONFIG_CMDLINE="console=tty0 console=ttyS1,115200n81 earlyprintk=serial8250-em.1,115200n81 mem8M@0x40000000 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize@96,wsize@96"
-CONFIG_CMDLINE_FORCE=y
 CONFIG_VFP=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-# CONFIG_SUSPEND is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
1.7.10.4

