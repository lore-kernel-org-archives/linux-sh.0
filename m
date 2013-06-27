From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 27 Jun 2013 09:49:14 +0000
Subject: [PATCH 04/24] drm/rcar-du: Don't ignore rcar_du_crtc_create() return value
Message-Id: <1372326574-4315-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Handle error cases correctly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 9c63f39..06cacf6 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -191,8 +191,11 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < ARRAY_SIZE(rcdu->crtcs); ++i)
-		rcar_du_crtc_create(rcdu, i);
+	for (i = 0; i < ARRAY_SIZE(rcdu->crtcs); ++i) {
+		ret = rcar_du_crtc_create(rcdu, i);
+		if (ret < 0)
+			return ret;
+	}
 
 	rcdu->used_crtcs = 0;
 	rcdu->num_crtcs = i;
-- 
1.8.1.5

