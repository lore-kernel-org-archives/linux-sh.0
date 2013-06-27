From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 27 Jun 2013 09:49:23 +0000
Subject: [PATCH 13/24] drm/rcar-du: Rename rcar_du_plane_(init|register) to rcar_du_planes_*
Message-Id: <1372326574-4315-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372326574-4315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The functions initialize or register all planes, rename them
accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c   | 4 ++--
 drivers/gpu/drm/rcar-du/rcar_du_plane.c | 4 ++--
 drivers/gpu/drm/rcar-du/rcar_du_plane.h | 5 +++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index a8eef16..a1343fb 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -174,7 +174,7 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 	rcdu->ddev->mode_config.max_height = 2047;
 	rcdu->ddev->mode_config.funcs = &rcar_du_mode_config_funcs;
 
-	ret = rcar_du_plane_init(rcdu);
+	ret = rcar_du_planes_init(rcdu);
 	if (ret < 0)
 		return ret;
 
@@ -215,7 +215,7 @@ int rcar_du_modeset_init(struct rcar_du_device *rcdu)
 		encoder->possible_clones = 1 << 0;
 	}
 
-	ret = rcar_du_plane_register(rcdu);
+	ret = rcar_du_planes_register(rcdu);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index 38ebd20..29f2147 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -435,7 +435,7 @@ static const uint32_t formats[] = {
 	DRM_FORMAT_NV16,
 };
 
-int rcar_du_plane_init(struct rcar_du_device *rcdu)
+int rcar_du_planes_init(struct rcar_du_device *rcdu)
 {
 	unsigned int i;
 
@@ -475,7 +475,7 @@ int rcar_du_plane_init(struct rcar_du_device *rcdu)
 	return 0;
 }
 
-int rcar_du_plane_register(struct rcar_du_device *rcdu)
+int rcar_du_planes_register(struct rcar_du_device *rcdu)
 {
 	unsigned int i;
 	int ret;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index 5c8488c..bcf6f76 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -67,8 +67,9 @@ struct rcar_du_planes {
 	struct drm_property *zpos;
 };
 
-int rcar_du_plane_init(struct rcar_du_device *rcdu);
-int rcar_du_plane_register(struct rcar_du_device *rcdu);
+int rcar_du_planes_init(struct rcar_du_device *rcdu);
+int rcar_du_planes_register(struct rcar_du_device *rcdu);
+
 void rcar_du_plane_setup(struct rcar_du_plane *plane);
 void rcar_du_plane_update_base(struct rcar_du_plane *plane);
 void rcar_du_plane_compute_base(struct rcar_du_plane *plane,
-- 
1.8.1.5

