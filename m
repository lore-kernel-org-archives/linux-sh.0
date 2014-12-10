From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Dec 2014 23:42:01 +0000
Subject: [PATCH 01/15] drm: adv7511: Remove interlaced mode check
Message-Id: <1418254935-13536-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

The ADV7511 supports interlaced modes fine, there's no need to reject
them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/i2c/adv7511.c | 3 ---
 1 file changed, 3 deletions(-)

Cc: Lars-Peter Clausen <lars@metafoo.de>

diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
index faf1c0c5ab2e..fa140e04d5fa 100644
--- a/drivers/gpu/drm/i2c/adv7511.c
+++ b/drivers/gpu/drm/i2c/adv7511.c
@@ -644,9 +644,6 @@ static int adv7511_encoder_mode_valid(struct drm_encoder *encoder,
 	if (mode->clock > 165000)
 		return MODE_CLOCK_HIGH;
 
-	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
-		return MODE_NO_INTERLACE;
-
 	return MODE_OK;
 }
 
-- 
2.0.4

