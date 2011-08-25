From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Aug 2011 04:05:50 +0000
Subject: [PATCH 5/7] fbdev: sh_mipi_dsi: add extra dcs settings for platform
Message-Id: <87vctmt9t1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

some platform needs extra MIPI dcs to use.
this patch add support it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mipi_dsi.c |   24 +++++++++++++++++++++++-
 include/video/sh_mipi_dsi.h |   13 +++++++++++++
 2 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 096c76a..bdf687d 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -46,6 +46,13 @@
 /* E.g., sh7372 has 2 MIPI-DSIs - one for each LCDC */
 #define MAX_SH_MIPI_DSI 2
 
+/*
+ * for extra array
+ * see sh_mipi_dsi.h
+ */
+#define GET_EXCMD(p)	((p >> 8) & 0xFF)
+#define GET_EXPARAM(p)	(p & 0xFF)
+
 struct sh_mipi {
 	void __iomem	*base;
 	void __iomem	*linkbase;
@@ -150,8 +157,9 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 {
 	void __iomem *base = mipi->base;
 	struct sh_mobile_lcdc_chan_cfg *ch = pdata->lcd_chan;
-	u32 pctype, datatype, pixfmt, linelength, vmctr2 = 0x00e00000;
+	u32 pctype, datatype, pixfmt, linelength, vmctr2 = 0x00e00000, excmd;
 	bool yuv;
+	int i;
 
 	/*
 	 * Select data format. MIPI DSI is not hot-pluggable, so, we just use
@@ -355,6 +363,20 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 			  pixfmt << 4);
 	sh_mipi_dcs(ch->chan, MIPI_DCS_SET_DISPLAY_ON);
 
+	/*
+	 * FIXME
+	 *
+	 * extra dcs settings for platform
+	 */
+	for (i = 0; i < pdata->extra_array_len; i++) {
+		excmd = pdata->extra_array[i];
+		if (0x10000000 & excmd)
+			sh_mipi_dcs(ch->chan, GET_EXCMD(excmd));
+		else
+			sh_mipi_dcs_param(ch->chan, GET_EXCMD(excmd),
+						    GET_EXPARAM(excmd));
+	}
+
 	return 0;
 }
 
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index 58b78f8..e52097a 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -32,12 +32,25 @@ struct sh_mobile_lcdc_chan_cfg;
 #define SH_MIPI_DSI_HFPBM	(1 << 2)
 #define SH_MIPI_DSI_BL2E	(1 << 3)
 
+/*
+ * x000ccpp
+ *
+ * x : 1 use sh_mipi_dcs()
+ *     0 use sh_mipi_dcs_param()
+ * cc : cmd
+ * pp : param
+ */
+#define SH_MIPI_DCS(cmd)		(0x10000000 | (cmd & 0xFF) << 8)
+#define SH_MIPI_DCS_PARAM(cmd, param)	((cmd & 0xFF) << 8 | (param & 0xFF))
+
 struct sh_mipi_dsi_info {
 	enum sh_mipi_dsi_data_fmt	data_format;
 	struct sh_mobile_lcdc_chan_cfg	*lcd_chan;
 	unsigned long			flags;
 	u32				clksrc;
 	unsigned int			vsynw_offset;
+	u32				*extra_array;
+	int				extra_array_len;
 };
 
 #endif
-- 
1.7.4.1

