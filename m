From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Aug 2011 04:05:29 +0000
Subject: [PATCH 4/7] fbdev: sh_mipi_dsi: add SH_MIPI_DSI_BL2E flag
Message-Id: <87wre2t9tm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mipi_dsi.c |    2 ++
 include/video/sh_mipi_dsi.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index b35454e..096c76a 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -315,6 +315,8 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	 * Non-burst mode with sync pulses: VSE and HSE are output,
 	 * HSA period allowed, no commands in LP
 	 */
+	if (pdata->flags & SH_MIPI_DSI_BL2E)
+		vmctr2 |= 1 << 17;
 	if (pdata->flags & SH_MIPI_DSI_HSABM)
 		vmctr2 |= 1 << 5;
 	if (pdata->flags & SH_MIPI_DSI_HBPBM)
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index 86a72c0..58b78f8 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -30,6 +30,7 @@ struct sh_mobile_lcdc_chan_cfg;
 #define SH_MIPI_DSI_HSABM	(1 << 0)
 #define SH_MIPI_DSI_HBPBM	(1 << 1)
 #define SH_MIPI_DSI_HFPBM	(1 << 2)
+#define SH_MIPI_DSI_BL2E	(1 << 3)
 
 struct sh_mipi_dsi_info {
 	enum sh_mipi_dsi_data_fmt	data_format;
-- 
1.7.4.1

