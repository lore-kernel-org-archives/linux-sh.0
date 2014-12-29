From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 29 Dec 2014 01:43:18 +0000
Subject: [PATCH 1/5] ARM: shmobile: kzm9g_defconfig: Update AK8975 config option
Message-Id: <ca8bfc97ca7795f86e5b25553dd19d96b252bb29.1419808942.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1419808942.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1419808942.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

CONFIG_SENSORS_AK8975 was renamed to CONFIG_AK8975 in commit
2fc72cd8354e3e9c ("iio:magnetometer:ak8975 move driver out of staging")
in v3.10.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 5d63fc5..23e8d14 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -126,8 +126,8 @@ CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_ASYNC_TX_DMA=y
 CONFIG_STAGING=y
-CONFIG_SENSORS_AK8975=y
 CONFIG_IIO=y
+CONFIG_AK8975=y
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
2.1.3

