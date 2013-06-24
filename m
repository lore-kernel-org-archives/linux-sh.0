From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 24 Jun 2013 09:21:16 +0000
Subject: [PATCH] V4L2: sh_vou: add I2C build dependency
Message-Id: <Pine.LNX.4.64.1306241120270.19735@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: linux-sh@vger.kernel.org

The sh_vou driver needs CONFIG_I2C or CONFIG_I2C_MODULE to build, add the
respective dependency.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/media/platform/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 0494d27..bd99e50 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -36,7 +36,7 @@ source "drivers/media/platform/blackfin/Kconfig"
 config VIDEO_SH_VOU
 	tristate "SuperH VOU video output driver"
 	depends on MEDIA_CAMERA_SUPPORT
-	depends on VIDEO_DEV && ARCH_SHMOBILE
+	depends on VIDEO_DEV && ARCH_SHMOBILE && I2C
 	select VIDEOBUF_DMA_CONTIG
 	help
 	  Support for the Video Output Unit (VOU) on SuperH SoCs.
-- 
1.7.2.5

