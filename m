From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 16 Jan 2013 06:02:24 +0000
Subject: [PATCH 3/5] ARM: mach-shmobile: kzm9g: defconfig update
Message-Id: <1358316146-12579-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1358316146-12579-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1358316146-12579-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Enable ARM_APPENDED_DTB

  Typically the bootloader of a kzm9g board does not support DT
  so this option is useful.

* Use voltage regulators by default

* Move command line to dts

  This brings us one small step closer to sharing defconfig
  between kzm9g and other boards

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts |    4 ++++
 arch/arm/configs/kzm9g_defconfig   |    4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index bcb9119..9a43879 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -15,6 +15,10 @@
 	model = "KZM-A9-GT";
 	compatible = "renesas,kzm9g", "renesas,sh73a0";
 
+	chosen {
+		bootargs = "console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel earlyprintk=sh-sci.4,115200";
+	};
+
 	memory {
 		device_type = "memory";
 		reg = <0x41000000 0x1e800000>;
diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index afbae28..670c3b6 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -39,7 +39,7 @@ CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel earlyprintk=sh-sci.4,115200"
+CONFIG_ARM_APPENDED_DTB=y
 CONFIG_KEXEC=y
 CONFIG_VFP=y
 CONFIG_NEON=y
@@ -85,6 +85,8 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_SH_MOBILE=y
 CONFIG_GPIO_PCF857X=y
 # CONFIG_HWMON is not set
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_DUMMY=y
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
1.7.10.4

