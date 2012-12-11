From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 11 Dec 2012 03:07:33 +0000
Subject: [PATCH 5/6] ARM: mach-shmobile: kzm9g: use voltage regulators by default
Message-Id: <1355195254-4563-6-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355195254-4563-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1355195254-4563-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This is needed to initialise the MMCIF device in the
absence of platform data.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v3
* Also enable CONFIG_REGULATOR_DUMMY.
  This is needed for SMSC.

v2
* First post
---
 arch/arm/configs/kzm9g_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index c88b578..8c31b44 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -83,6 +83,8 @@ CONFIG_I2C_CHARDEV=y
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

