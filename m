From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 18 May 2011 11:10:11 +0000
Subject: [PATCH 6/6] fbdev: sh_mobile_meram: Enable/disable MERAM clocks along with LCDC clocks
Message-Id: <1305717011-20742-7-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 drivers/video/sh_mobile_lcdcfb.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 1c652da..b987647 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -259,6 +259,11 @@ static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
 		pm_runtime_get_sync(priv->dev);
 		if (priv->dot_clk)
 			clk_enable(priv->dot_clk);
+		if (priv->meram_dev) {
+			struct sh_mobile_meram_info *mdev;
+			mdev = priv->meram_dev;
+			mdev->ops->meram_clk_on(mdev);
+		}
 	}
 }
 
@@ -267,6 +272,11 @@ static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
 	if (atomic_sub_return(1, &priv->hw_usecnt) = -1) {
 		if (priv->dot_clk)
 			clk_disable(priv->dot_clk);
+		if (priv->meram_dev) {
+			struct sh_mobile_meram_info *mdev;
+			mdev = priv->meram_dev;
+			mdev->ops->meram_clk_off(mdev);
+		}
 		pm_runtime_put(priv->dev);
 	}
 }
-- 
1.7.1

