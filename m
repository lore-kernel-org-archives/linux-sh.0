From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Sep 2011 08:34:24 +0000
Subject: [PATCH 6/6] fbdev: sh_mipi_dsi: fixup setup timing DSICTRL
Message-Id: <87fwjecttf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

DSICTRL should be called after all mipi settings

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mipi_dsi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index b3cdcd5..050070e 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -271,8 +271,6 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	iowrite32(0x0fffffff, base + TATOVSET);
 	/* Peripheral reset timeout, default 0xffffffff */
 	iowrite32(0x0fffffff, base + PRTOVSET);
-	/* Enable timeout counters */
-	iowrite32(0x00000f00, base + DSICTRL);
 	/* Interrupts not used, disable all */
 	iowrite32(0, base + DSIINTE);
 	/* DSI-Tx bias on */
@@ -408,6 +406,9 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 						    GET_EXPARAM(excmd));
 	}
 
+	/* Enable timeout counters */
+	iowrite32(0x00000f00, base + DSICTRL);
+
 	return 0;
 }
 
-- 
1.7.4.1

