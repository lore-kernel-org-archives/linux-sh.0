From: Simon Horman <horms@verge.net.au>
Date: Fri, 30 Nov 2012 08:44:44 +0000
Subject: [PATCH 4/5] ARM: shmobile: kzm9g: use voltage regulators by default
Message-Id: <1354265085-2444-5-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1354265085-2444-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1354265085-2444-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This is needed to initialise the MMCIF device in the
absence of platform data.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index c88b578..6d7fd53 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -83,6 +83,7 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_SH_MOBILE=y
 CONFIG_GPIO_PCF857X=y
 # CONFIG_HWMON is not set
+CONFIG_REGULATOR=y
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
1.7.10.4

