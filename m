From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 01 Oct 2013 02:38:42 +0000
Subject: [PATCH 1/4] ARM: shmobile: marzen: Select DRM_RCAR_DU in defconfig
Message-Id: <7525e87b468a1b2d8e3f0156e36acd8992af673c.1380514316.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1380514316.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1380514316.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

A R-Car DU DRM device is registered for the Marzen board, select the
corresponding driver in its defconfig.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/marzen_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 000e920..5cc6360 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -92,6 +92,8 @@ CONFIG_SOC_CAMERA=y
 CONFIG_VIDEO_RCAR_VIN=y
 # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
 CONFIG_VIDEO_ADV7180=y
+CONFIG_DRM=y
+CONFIG_DRM_RCAR_DU=y
 CONFIG_USB=y
 CONFIG_USB_RCAR_PHY=y
 CONFIG_MMC=y
-- 
1.8.4

