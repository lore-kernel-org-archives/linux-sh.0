From: Alexandre Courbot <gnurou@gmail.com>
Date: Wed, 23 Feb 2011 08:41:50 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdcfb: fix module lock acquisition
Message-Id: <1298450510-4075-1-git-send-email-gnurou@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Whenever the LCDC is to be started or stopped, a board callback is
checked for existence and invoked. Prior to the invokation, the
callback's module lock is also acquired, to be released once the
callback returns. However, the order of testing makes it possible for
the lock to be acquired and not released in case the callback does not
exist. This patch reorders the tests to prevent this particular case.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index bf12e53..90d442d 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -614,7 +614,7 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 			continue;
 
 		board_cfg = &ch->cfg.board_cfg;
-		if (try_module_get(board_cfg->owner) && board_cfg->display_on) {
+		if (board_cfg->display_on && try_module_get(board_cfg->owner)) {
 			board_cfg->display_on(board_cfg->board_data, ch->info);
 			module_put(board_cfg->owner);
 		}
@@ -649,7 +649,7 @@ static void sh_mobile_lcdc_stop(struct sh_mobile_lcdc_priv *priv)
 		}
 
 		board_cfg = &ch->cfg.board_cfg;
-		if (try_module_get(board_cfg->owner) && board_cfg->display_off) {
+		if (board_cfg->display_off && try_module_get(board_cfg->owner)) {
 			board_cfg->display_off(board_cfg->board_data);
 			module_put(board_cfg->owner);
 		}
@@ -1114,7 +1114,7 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 
 	switch(action) {
 	case FB_EVENT_SUSPEND:
-		if (try_module_get(board_cfg->owner) && board_cfg->display_off) {
+		if (board_cfg->display_off && try_module_get(board_cfg->owner)) {
 			board_cfg->display_off(board_cfg->board_data);
 			module_put(board_cfg->owner);
 		}
@@ -1127,7 +1127,7 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 		mutex_unlock(&ch->open_lock);
 
 		/* HDMI must be enabled before LCDC configuration */
-		if (try_module_get(board_cfg->owner) && board_cfg->display_on) {
+		if (board_cfg->display_on && try_module_get(board_cfg->owner)) {
 			board_cfg->display_on(board_cfg->board_data, info);
 			module_put(board_cfg->owner);
 		}
-- 
1.7.4.1

