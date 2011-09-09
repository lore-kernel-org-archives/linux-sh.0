From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 09 Sep 2011 10:26:37 +0000
Subject: [PATCH 4/10] fbdev: sh_mipi_dsi: add lane control support
Message-Id: <87lityqaee.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH MIPI DSI can use 0-4 lane

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    1 +
 arch/arm/mach-shmobile/board-ap4evb.c |    1 +
 arch/arm/mach-shmobile/board-kota2.c  |    1 +
 drivers/video/sh_mipi_dsi.c           |   10 +++++++++-
 include/video/sh_mipi_dsi.h           |    1 +
 5 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index ce5c251..70beba2 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -323,6 +323,7 @@ static struct resource mipidsi0_resources[] = {
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
 	.lcd_chan	= &lcdc0_info.ch[0],
+	.lane		= 2,
 	.vsynw_offset	= 20,
 	.clksrc		= 1,
 	.flags		= SH_MIPI_DSI_HSABM,
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 9e0856b..f8e3724 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -578,6 +578,7 @@ static struct resource mipidsi0_resources[] = {
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
 	.lcd_chan	= &lcdc_info.ch[0],
+	.lane		= 2,
 	.vsynw_offset	= 17,
 };
 
diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index 913176e..388ce3f 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -368,6 +368,7 @@ static u32 sh_mipi_extra_dcs[] = {
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
 	.lcd_chan	= &lcdc0_info.ch[0],
+	.lane		= 2,
 	.vsynw_offset	= 20,
 	.clksrc		= 1,
 	.flags		= SH_MIPI_DSI_HSABM |
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index d24ba7e..5f4bff6 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -8,6 +8,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/bitmap.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/init.h>
@@ -158,6 +159,7 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	void __iomem *base = mipi->base;
 	struct sh_mobile_lcdc_chan_cfg *ch = pdata->lcd_chan;
 	u32 pctype, datatype, pixfmt, linelength, vmctr2 = 0x00e00000, excmd;
+	u32 tmp;
 	bool yuv;
 	int i;
 
@@ -260,6 +262,9 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	    (!yuv && ch->interface_type != RGB24))
 		return -EINVAL;
 
+	if (!pdata->lane)
+		return -EINVAL;
+
 	/* reset DSI link */
 	iowrite32(0x00000001, base + SYSCTRL);
 	/* Hold reset for 100 cycles of the slowest of bus, HS byte and LP clock */
@@ -276,7 +281,10 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	 *	ECC check enable
 	 * additionally enable first two lanes
 	 */
-	iowrite32(0x00003703, base + SYSCONF);
+	bitmap_fill((unsigned long *)&tmp, pdata->lane);
+	tmp |= 0x00003700;
+	iowrite32(tmp, base + SYSCONF);
+
 	/*
 	 * T_wakeup = 0x7000
 	 * T_hs-trail = 3
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index e52097a..d71122d 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -46,6 +46,7 @@ struct sh_mobile_lcdc_chan_cfg;
 struct sh_mipi_dsi_info {
 	enum sh_mipi_dsi_data_fmt	data_format;
 	struct sh_mobile_lcdc_chan_cfg	*lcd_chan;
+	int				lane;
 	unsigned long			flags;
 	u32				clksrc;
 	unsigned int			vsynw_offset;
-- 
1.7.4.1

