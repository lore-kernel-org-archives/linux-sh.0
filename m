From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 10 Jan 2013 01:23:57 +0000
Subject: [PATCH 3/5] ARM: mach-shmobile: kzm9g: use voltage regulators by default
Message-Id: <1357781039-14003-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1357781039-14003-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1357781039-14003-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This is needed to initialise the MMCIF device in the
absence of platform data.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index afbae28..7f6ec2c 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
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

