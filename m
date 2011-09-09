From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 09 Sep 2011 10:27:02 +0000
Subject: [PATCH 05/10] fbdev: sh_mipi_dsi: add sync_pulses/sync_events/burst mode
Message-Id: <87k49iqadp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    3 ++-
 arch/arm/mach-shmobile/board-ap4evb.c |    1 +
 arch/arm/mach-shmobile/board-kota2.c  |    2 +-
 drivers/video/sh_mipi_dsi.c           |    9 ++++++++-
 include/video/sh_mipi_dsi.h           |    9 +++++++++
 5 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 70beba2..87e9091 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -326,7 +326,8 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 	.lane		= 2,
 	.vsynw_offset	= 20,
 	.clksrc		= 1,
-	.flags		= SH_MIPI_DSI_HSABM,
+	.flags		= SH_MIPI_DSI_HSABM |
+			  SH_MIPI_DSI_SYNC_PULSES_MODE,
 };
 
 static struct platform_device mipidsi0_device = {
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index f8e3724..114fd8a 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -580,6 +580,7 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 	.lcd_chan	= &lcdc_info.ch[0],
 	.lane		= 2,
 	.vsynw_offset	= 17,
+	.flags		= SH_MIPI_DSI_SYNC_PULSES_MODE,
 };
 
 static struct platform_device mipidsi0_device = {
diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index 388ce3f..a2be703 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -374,7 +374,7 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 	.flags		= SH_MIPI_DSI_HSABM |
 			  SH_MIPI_DSI_HBPBM |
 			  SH_MIPI_DSI_HFPBM |
-			  SH_MIPI_DSI_BL2E,
+			  SH_MIPI_DSI_SYNC_BURST_MODE,
 	.extra_array	= sh_mipi_extra_dcs,
 	.extra_array_len= ARRAY_SIZE(sh_mipi_extra_dcs),
 };
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 1f49e19..3f8da95 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -158,7 +158,7 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 {
 	void __iomem *base = mipi->base;
 	struct sh_mobile_lcdc_chan_cfg *ch = pdata->lcd_chan;
-	u32 pctype, datatype, pixfmt, linelength, vmctr2 = 0x00e00000, excmd;
+	u32 pctype, datatype, pixfmt, linelength, vmctr2, excmd;
 	u32 tmp;
 	bool yuv;
 	int i;
@@ -331,6 +331,13 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	 * Non-burst mode with sync pulses: VSE and HSE are output,
 	 * HSA period allowed, no commands in LP
 	 */
+	vmctr2 = 0;
+	if (pdata->flags & SH_MIPI_DSI_VSEE)
+		vmctr2 |= 1 << 23;
+	if (pdata->flags & SH_MIPI_DSI_HSEE)
+		vmctr2 |= 1 << 22;
+	if (pdata->flags & SH_MIPI_DSI_HSAE)
+		vmctr2 |= 1 << 21;
 	if (pdata->flags & SH_MIPI_DSI_BL2E)
 		vmctr2 |= 1 << 17;
 	if (pdata->flags & SH_MIPI_DSI_HSABM)
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index d71122d..fb3950e 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -31,6 +31,15 @@ struct sh_mobile_lcdc_chan_cfg;
 #define SH_MIPI_DSI_HBPBM	(1 << 1)
 #define SH_MIPI_DSI_HFPBM	(1 << 2)
 #define SH_MIPI_DSI_BL2E	(1 << 3)
+#define SH_MIPI_DSI_VSEE	(1 << 4)
+#define SH_MIPI_DSI_HSEE	(1 << 5)
+#define SH_MIPI_DSI_HSAE	(1 << 6)
+
+#define SH_MIPI_DSI_SYNC_PULSES_MODE	(SH_MIPI_DSI_VSEE | \
+					 SH_MIPI_DSI_HSEE | \
+					 SH_MIPI_DSI_HSAE)
+#define SH_MIPI_DSI_SYNC_EVENTS_MODE	(0)
+#define SH_MIPI_DSI_SYNC_BURST_MODE	(SH_MIPI_DSI_BL2E)
 
 /*
  * x000ccpp
-- 
1.7.4.1

