From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 15 Aug 2009 02:53:16 +0000
Subject: [PATCH 01/04] sh: skip disabled LCDC channels
Message-Id: <20090815025316.8125.53448.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch updates the SuperH Mobile LCDC driver to skip
over disabled channels. Without this patch suspend-to-ram
operation will crash if deferred io is enabled.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/sh_mobile_lcdcfb.c |    5 +++++
 1 file changed, 5 insertions(+)

--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2009-08-14 13:29:48.000000000 +0900
@@ -477,6 +477,9 @@ static int sh_mobile_lcdc_start(struct s
 	/* tell the board code to enable the panel */
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
 		ch = &priv->ch[k];
+		if (!ch->enabled)
+			continue;
+
 		board_cfg = &ch->cfg.board_cfg;
 		if (board_cfg->display_on)
 			board_cfg->display_on(board_cfg->board_data);
@@ -494,6 +497,8 @@ static void sh_mobile_lcdc_stop(struct s
 	/* clean up deferred io and ask board code to disable panel */
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
 		ch = &priv->ch[k];
+		if (!ch->enabled)
+			continue;
 
 		/* deferred io mode:
 		 * flush frame, and wait for frame end interrupt
