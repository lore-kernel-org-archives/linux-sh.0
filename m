From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Sep 2011 08:33:28 +0000
Subject: [PATCH 2/6] fbdev: sh_mipi_dsi: Add HSxxCLK support
Message-Id: <87lit6ctuz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH MIPI manual explains the calculation method of HBP/HFP.
it is based on HSbyteCLK settings.
SH73a0 chip can use HS6divCLK/HS4divCLK for it.
This patch has compatibility to SH7372 mipi

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    3 ++-
 arch/arm/mach-shmobile/board-ap4evb.c |    3 ++-
 arch/arm/mach-shmobile/board-kota2.c  |    3 ++-
 drivers/video/sh_mipi_dsi.c           |   14 ++++++++++----
 include/video/sh_mipi_dsi.h           |    4 ++++
 5 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 2cbf158..4222837 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -365,7 +365,8 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 	.vsynw_offset	= 20,
 	.clksrc		= 1,
 	.flags		= SH_MIPI_DSI_HSABM |
-			  SH_MIPI_DSI_SYNC_PULSES_MODE,
+			  SH_MIPI_DSI_SYNC_PULSES_MODE |,
+			  SH_MIPI_DSI_HSbyteCLK,
 	.set_dot_clock	= sh_mipi_set_dot_clock,
 };
 
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 1c997b8..44c86f6 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -604,7 +604,8 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 	.lcd_chan	= &lcdc_info.ch[0],
 	.lane		= 2,
 	.vsynw_offset	= 17,
-	.flags		= SH_MIPI_DSI_SYNC_PULSES_MODE,
+	.flags		= SH_MIPI_DSI_SYNC_PULSES_MODE |,
+			  SH_MIPI_DSI_HSbyteCLK,
 	.set_dot_clock	= sh_mipi_set_dot_clock,
 };
 
diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index b7a1d23..9a2d77d 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -416,7 +416,8 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 	.flags		= SH_MIPI_DSI_HSABM |
 			  SH_MIPI_DSI_HBPBM |
 			  SH_MIPI_DSI_HFPBM |
-			  SH_MIPI_DSI_SYNC_BURST_MODE,
+			  SH_MIPI_DSI_SYNC_BURST_MODE |
+			  SH_MIPI_DSI_HSbyteCLK,
 	.extra_array	= sh_mipi_extra_dcs,
 	.extra_array_len= ARRAY_SIZE(sh_mipi_extra_dcs),
 	.set_dot_clock	= sh_mipi_set_dot_clock,
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index e42cd81..a87dcfe 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -159,7 +159,7 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	void __iomem *base = mipi->base;
 	struct sh_mobile_lcdc_chan_cfg *ch = pdata->lcd_chan;
 	u32 pctype, datatype, pixfmt, linelength, vmctr2, excmd;
-	u32 tmp, top, bottom, delay;
+	u32 tmp, top, bottom, delay, div;
 	bool yuv;
 	int i, bpp;
 
@@ -370,17 +370,23 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	bottom	= 0x00000001;
 	delay	= 0;
 
+	div = 1;	/* HSbyteCLK is calculation base
+			 * HS4divCLK = HSbyteCLK/2
+			 * HS6divCLK is not supported for now */
+	if (pdata->flags & SH_MIPI_DSI_HS4divCLK)
+		div = 2;
+
 	if (pdata->flags & SH_MIPI_DSI_HFPBM) {	/* HBPLEN */
 		top = ch->lcd_cfg[0].hsync_len + ch->lcd_cfg[0].left_margin;
-		top = ((pdata->lane * top) - 10) << 16;
+		top = ((pdata->lane * top / div) - 10) << 16;
 	}
 	if (pdata->flags & SH_MIPI_DSI_HBPBM) { /* HFPLEN */
 		bottom = ch->lcd_cfg[0].right_margin;
-		bottom = (pdata->lane * bottom) - 12;
+		bottom = (pdata->lane * bottom / div) - 12;
 	}
 
 	bpp = linelength / ch->lcd_cfg[0].xres; /* byte / pixel */
-	if (pdata->lane > bpp) {
+	if ((pdata->lane / div) > bpp) {
 		tmp = ch->lcd_cfg[0].xres / bpp; /* output cycle */
 		tmp = ch->lcd_cfg[0].xres - tmp; /* (input - output) cycle */
 		delay = (pdata->lane * tmp);
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index 5ded705..f745f02 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -35,6 +35,10 @@ struct sh_mobile_lcdc_chan_cfg;
 #define SH_MIPI_DSI_HSEE	(1 << 5)
 #define SH_MIPI_DSI_HSAE	(1 << 6)
 
+#define SH_MIPI_DSI_HSbyteCLK	(1 << 24)
+#define SH_MIPI_DSI_HS6divCLK	(1 << 25)
+#define SH_MIPI_DSI_HS4divCLK	(1 << 26)
+
 #define SH_MIPI_DSI_SYNC_PULSES_MODE	(SH_MIPI_DSI_VSEE | \
 					 SH_MIPI_DSI_HSEE | \
 					 SH_MIPI_DSI_HSAE)
-- 
1.7.4.1

