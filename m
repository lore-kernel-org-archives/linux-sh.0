From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Dec 2009 14:20:06 +0000
Subject: [PATCH] sh: add a start_transfer() callback to the LCDC driver
Message-Id: <20091207142006.6718.47399.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds a ->start_transfer() callback to the
driver sh_mobile_lcdcfb.c. The callback is used to
program the LCDC panel in the case of one-shot mode.

Needed by the LCD controller used on the KFR2R09 board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/video/sh_mobile_lcdcfb.c |   10 +++++++++-
 include/video/sh_mobile_lcdc.h   |    2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2009-12-07 18:34:46.000000000 +0900
@@ -281,6 +281,7 @@ static void sh_mobile_lcdc_deferred_io(s
 				       struct list_head *pagelist)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
+	struct sh_mobile_lcdc_board_cfg	*bcfg = &ch->cfg.board_cfg;
 
 	/* enable clocks before accessing hardware */
 	sh_mobile_lcdc_clk_on(ch->lcdc);
@@ -305,10 +306,17 @@ static void sh_mobile_lcdc_deferred_io(s
 
 		/* trigger panel update */
 		dma_map_sg(info->dev, ch->sglist, nr_pages, DMA_TO_DEVICE);
+		if (bcfg->start_transfer)
+			bcfg->start_transfer(bcfg->board_data, ch,
+					     &sh_mobile_lcdc_sys_bus_ops);
 		lcdc_write_chan(ch, LDSM2R, 1);
 		dma_unmap_sg(info->dev, ch->sglist, nr_pages, DMA_TO_DEVICE);
-	} else
+	} else {
+		if (bcfg->start_transfer)
+			bcfg->start_transfer(bcfg->board_data, ch,
+					     &sh_mobile_lcdc_sys_bus_ops);
 		lcdc_write_chan(ch, LDSM2R, 1);
+	}
 }
 
 static void sh_mobile_lcdc_deferred_io_touch(struct fb_info *info)
--- 0001/include/video/sh_mobile_lcdc.h
+++ work/include/video/sh_mobile_lcdc.h	2009-12-07 18:34:46.000000000 +0900
@@ -50,6 +50,8 @@ struct sh_mobile_lcdc_board_cfg {
 	void *board_data;
 	int (*setup_sys)(void *board_data, void *sys_ops_handle,
 			 struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
+	void (*start_transfer)(void *board_data, void *sys_ops_handle,
+			       struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
 	void (*display_on)(void *board_data);
 	void (*display_off)(void *board_data);
 };
