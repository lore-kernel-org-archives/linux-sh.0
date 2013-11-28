From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 28 Nov 2013 09:08:32 +0000
Subject: [PATCH 02/16] ARM: shmobile: bockw: enable CONFIG_REGULATOR
Message-Id: <03248fde88e37b1b043b640b1bae4fb14d4d3f23.1385629477.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1385629477.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1385629477.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

CONFIG_REGULATOR is required from MMCIF and SMSC

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/bockw_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index b38cd10..6583683 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -82,6 +82,7 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HWMON is not set
 CONFIG_I2C=y
 CONFIG_I2C_RCAR=y
+CONFIG_REGULATOR=y
 CONFIG_MEDIA_SUPPORT=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
-- 
1.8.4

