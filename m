From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Sep 2011 08:34:11 +0000
Subject: [PATCH 5/6] fbdev: sh_mipi_dsi: fixup setup timing of SYSCONF
Message-Id: <87hb3uctts.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SYSCONF should be set after PHYCTRL

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mipi_dsi.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 005c9fd..b3cdcd5 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -252,18 +252,6 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	/* setup DSI link */
 
 	/*
-	 * Default = ULPS enable |
-	 *	Contention detection enabled |
-	 *	EoT packet transmission enable |
-	 *	CRC check enable |
-	 *	ECC check enable
-	 * additionally enable first two lanes
-	 */
-	bitmap_fill((unsigned long*)&tmp, pdata->lane);
-	tmp |= 0x00003700;
-	iowrite32(tmp, base + SYSCONF);
-
-	/*
 	 * T_wakeup = 0x7000
 	 * T_hs-trail = 3
 	 * T_hs-prepare = 3
@@ -293,6 +281,17 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	/* Deassert resets, power on */
 	iowrite32(0x03070001, base + PHYCTRL);
 
+	/*
+	 * Default = ULPS enable |
+	 *	Contention detection enabled |
+	 *	EoT packet transmission enable |
+	 *	CRC check enable |
+	 *	ECC check enable
+	 */
+	bitmap_fill((unsigned long *)&tmp, pdata->lane);
+	tmp |= 0x00003700;
+	iowrite32(tmp, base + SYSCONF);
+
 	/* setup l-bridge */
 
 	/*
-- 
1.7.4.1

