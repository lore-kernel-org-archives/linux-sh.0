From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 09 Sep 2011 10:26:13 +0000
Subject: [PATCH 03/10] fbdev: sh_mobile_lcdcfb: bugfix LDHAJR :: HSYNPAJ needs mask
Message-Id: <87mxeeqaf2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

LDHAJR register will be broken by hsync_pos without this patch

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index b048417..8cda40c 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -459,7 +459,7 @@ static void sh_mobile_lcdc_geometry(struct sh_mobile_lcdc_chan *ch)
 	tmp = ((display_var->xres & 7) << 24) |
 		((display_h_total & 7) << 16) |
 		((display_var->hsync_len & 7) << 8) |
-		hsync_pos;
+		(hsync_pos & 7);
 	lcdc_write_chan(ch, LDHAJR, tmp);
 }
 
-- 
1.7.4.1

