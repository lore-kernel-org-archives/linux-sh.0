From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 10 Jan 2013 01:23:59 +0000
Subject: [PATCH 5/5] ARM: mach-shmobile: kzm9g: Enable ARM_APPENDED_DTB in defconfig
Message-Id: <1357781039-14003-6-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1357781039-14003-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1357781039-14003-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Typically the bootloader of a kzm9g board does not support DT
so this option is useful.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 7f6ec2c..c6005a0 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -39,6 +39,7 @@ CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
 CONFIG_CMDLINE="console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel earlyprintk=sh-sci.4,115200"
 CONFIG_KEXEC=y
 CONFIG_VFP=y
-- 
1.7.10.4

