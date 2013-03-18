From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 18 Mar 2013 11:53:19 +0000
Subject: [PATCH 7/9] ARM: mach-shmobile: kzm9g: do not enable REGULATOR_DUMMY in defconfig
Message-Id: <1363607601-20366-8-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1363607601-20366-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1363607601-20366-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Don't enable REGULATOR_DUMMY, it is only intended for development / testing.
There doesn't seem to be any value in setting it here and doing
so was an error on my part.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 84ac68c..f6e585b 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -85,7 +85,6 @@ CONFIG_I2C_SH_MOBILE=y
 CONFIG_GPIO_PCF857X=y
 # CONFIG_HWMON is not set
 CONFIG_REGULATOR=y
-CONFIG_REGULATOR_DUMMY=y
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
1.7.10.4

