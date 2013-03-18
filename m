From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 18 Mar 2013 11:53:14 +0000
Subject: [PATCH 2/9] ARM: mach-shmobile: mackerel: enable REGULATOR in defconfig
Message-Id: <1363607601-20366-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1363607601-20366-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1363607601-20366-1-git-send-email-horms+renesas@verge.net.au>
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
 arch/arm/configs/mackerel_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
index ec8e605..9fb1189 100644
--- a/arch/arm/configs/mackerel_defconfig
+++ b/arch/arm/configs/mackerel_defconfig
@@ -75,6 +75,7 @@ CONFIG_I2C=y
 CONFIG_I2C_SH_MOBILE=y
 # CONFIG_HWMON is not set
 # CONFIG_MFD_SUPPORT is not set
+CONFIG_REGULATOR=y
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_SH_MOBILE_LCDC=y
-- 
1.7.10.4

