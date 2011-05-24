From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 24 May 2011 06:58:56 +0000
Subject: [PATCH 2/3] sh_mobile_meram: Safely disable MERAM operation when not initialized
Message-Id: <1306220482-29107-3-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If the MERAM platform data is defined, but the MERAM has not been
properly initaliazed we need to safely fall back to non-MERAM operation.

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/video/sh_mobile_lcdcfb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 1c652da..edf0d32 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -610,7 +610,8 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		pitch = ch->info->fix.line_length;
 
 		/* test if we can enable meram */
-		if (ch->cfg.meram_cfg && priv->meram_dev) {
+		if (ch->cfg.meram_cfg && priv->meram_dev &&
+				priv->meram_dev->ops) {
 			struct sh_mobile_meram_cfg *cfg;
 			struct sh_mobile_meram_info *mdev;
 			unsigned long icb_addr_y, icb_addr_c;
-- 
1.7.1

