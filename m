From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 27 May 2015 11:40:10 +0000
Subject: [PATCH 2/2] drm: rcar-du: Clean up planes in the error paths of .atomic_commit()
Message-Id: <1432726810-15969-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432726786-15906-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1432726786-15906-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

When the .atomic_commit() handler fails, clean up planes previoulsy
prepared by drm_atomic_helper_prepare_planes() with a call to
drm_atomic_helper_cleanup_planes().

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 20859aae882e..226a7e368b59 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -495,8 +495,10 @@ static int rcar_du_atomic_commit(struct drm_device *dev,
 
 	/* Allocate the commit object. */
 	commit = kzalloc(sizeof(*commit), GFP_KERNEL);
-	if (commit = NULL)
-		return -ENOMEM;
+	if (commit = NULL) {
+		ret = -ENOMEM;
+		goto error;
+	}
 
 	INIT_WORK(&commit->work, rcar_du_atomic_work);
 	commit->dev = dev;
@@ -519,7 +521,7 @@ static int rcar_du_atomic_commit(struct drm_device *dev,
 
 	if (ret) {
 		kfree(commit);
-		return ret;
+		goto error;
 	}
 
 	/* Swap the state, this is the point of no return. */
@@ -531,6 +533,10 @@ static int rcar_du_atomic_commit(struct drm_device *dev,
 		rcar_du_atomic_complete(commit);
 
 	return 0;
+
+error:
+	drm_atomic_helper_cleanup_planes(dev, state);
+	return ret;
 }
 
 /* -----------------------------------------------------------------------------
-- 
Regards,

Laurent Pinchart

