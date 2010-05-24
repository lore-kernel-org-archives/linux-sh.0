From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 24 May 2010 07:53:24 +0000
Subject: [PATCH] fbdev: fix erroneous index in drivers/video/sh_mobile_lcdcfb.c
Message-Id: <Pine.LNX.4.64.1005240949130.2611@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This is a fix, so, can go in rc2, no rush. In fact, maybe we can just 
"continue" on "pdata->ch[i].chan = LCDC_CHAN_DISABLED" in that loop? 
Doesn't look like anyone is relying on the current behaviour.

 drivers/video/sh_mobile_lcdcfb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index e8c7699..12c451a 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -991,13 +991,13 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		priv->ch[j].lcdc = priv;
 		memcpy(&priv->ch[j].cfg, &pdata->ch[i], sizeof(pdata->ch[i]));
 
-		error = sh_mobile_lcdc_check_interface(&priv->ch[i]);
+		error = sh_mobile_lcdc_check_interface(&priv->ch[j]);
 		if (error) {
 			dev_err(&pdev->dev, "unsupported interface type\n");
 			goto err1;
 		}
-		init_waitqueue_head(&priv->ch[i].frame_end_wait);
-		init_completion(&priv->ch[i].vsync_completion);
+		init_waitqueue_head(&priv->ch[j].frame_end_wait);
+		init_completion(&priv->ch[j].vsync_completion);
 		priv->ch[j].pan_offset = 0;
 
 		switch (pdata->ch[i].chan) {
-- 
1.6.2.4

