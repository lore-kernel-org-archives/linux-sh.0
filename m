From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 13 Feb 2013 12:16:10 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: enable REGULATOR in defconfig
Message-Id: <1360757770-15360-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360741742-11342-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1360741742-11342-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

As well as being a generally sane thing to do this
is required for MMCIF to function in conjunction with
" ARM: shmobile: streamline mackerel SD and MMC devices".

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/mackerel_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
index ec8e605..fdced32 100644
--- a/arch/arm/configs/mackerel_defconfig
+++ b/arch/arm/configs/mackerel_defconfig
@@ -75,6 +75,8 @@ CONFIG_I2C=y
 CONFIG_I2C_SH_MOBILE=y
 # CONFIG_HWMON is not set
 # CONFIG_MFD_SUPPORT is not set
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_DUMMY=y
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_SH_MOBILE_LCDC=y
-- 
1.7.10.4

