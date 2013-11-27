From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 01:18:28 +0000
Subject: [PATCH 06/15] v4l: sh_vou: Enable driver compilation with COMPILE_TEST
Message-Id: <1385515117-23664-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This helps increasing build testing coverage.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: linux-media@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms@verge.net.au>
---
 drivers/media/platform/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index d7f0249..7f6ea65 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -36,7 +36,8 @@ source "drivers/media/platform/blackfin/Kconfig"
 config VIDEO_SH_VOU
 	tristate "SuperH VOU video output driver"
 	depends on MEDIA_CAMERA_SUPPORT
-	depends on VIDEO_DEV && ARCH_SHMOBILE && I2C
+	depends on VIDEO_DEV && I2C
+	depends on ARCH_SHMOBILE || COMPILE_TEST
 	select VIDEOBUF_DMA_CONTIG
 	help
 	  Support for the Video Output Unit (VOU) on SuperH SoCs.
-- 
1.8.3.2

