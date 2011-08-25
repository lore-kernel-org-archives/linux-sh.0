From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Aug 2011 04:04:50 +0000
Subject: [PATCH 1/7] fbdev: sh_mipi_dsi: typo fix of SH_MIPI_DSI_HBPBM
Message-Id: <871uwauof4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mipi_dsi.c |    2 +-
 include/video/sh_mipi_dsi.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 24640c8..8f17efc 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -317,7 +317,7 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	 */
 	if (pdata->flags & SH_MIPI_DSI_HSABM)
 		vmctr2 |= 0x20;
-	if (pdata->flags & SH_MIPI_DSI_HSPBM)
+	if (pdata->flags & SH_MIPI_DSI_HBPBM)
 		vmctr2 |= 0x10;
 	iowrite32(vmctr2, mipi->linkbase + VMCTR2);
 
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index 6cb95c9..4e2bcb5 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -28,7 +28,7 @@ enum sh_mipi_dsi_data_fmt {
 struct sh_mobile_lcdc_chan_cfg;
 
 #define SH_MIPI_DSI_HSABM	(1 << 0)
-#define SH_MIPI_DSI_HSPBM	(1 << 1)
+#define SH_MIPI_DSI_HBPBM	(1 << 1)
 
 struct sh_mipi_dsi_info {
 	enum sh_mipi_dsi_data_fmt	data_format;
-- 
1.7.4.1

