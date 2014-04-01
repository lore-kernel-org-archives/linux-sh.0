From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 01 Apr 2014 11:03:52 +0000
Subject: [PATCH] drm/rcar-du: Handle encoder initialization failures
Message-Id: <1396350232-26967-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The rcar_du_encoder_init() function can fail and return an error code.
Don't ignore it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index fbeabd9..a87edfa 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -248,7 +248,10 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 			continue;
 		}
 
-		rcar_du_encoder_init(rcdu, pdata->type, pdata->output, pdata);
+		ret = rcar_du_encoder_init(rcdu, pdata->type, pdata->output,
+					   pdata);
+		if (ret < 0)
+			return ret;
 	}
 
 	/* Set the possible CRTCs and possible clones. There's always at least
-- 
Regards,

Laurent Pinchart

