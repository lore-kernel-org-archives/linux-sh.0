From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:32 +0000
Subject: [PATCH 12/38] drm: rcar-du: Turn vblank on/off when enabling/disabling CRTC
Message-Id: <1424901298-6829-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The DRM core vblank handling mechanism requires drivers to forcefully
turn vblank reporting off when disabling the CRTC, and to restore the
vblank reporting status when enabling the CRTC.

Implement this using the drm_crtc_vblank_on/off helpers. When disabling
vblank we must first wait for page flips to complete, so implement page
flip completion wait as well.

Finally, drm_crtc_vblank_off() must be called at startup to synchronize
the state of the vblank core code with the hardware, which is initially
disabled. This is performed at CRTC creation time, requiring vertical
blanking to be initialized before creating CRTCs.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 18 +++++++++++++-----
 drivers/gpu/drm/rcar-du/rcar_du_drv.c  | 14 ++++++++------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 7f5ae0269a61..5cf2cac75146 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -279,7 +279,7 @@ void rcar_du_crtc_cancel_page_flip(struct rcar_du_crtc *rcrtc,
 	if (event && event->base.file_priv = file) {
 		rcrtc->event = NULL;
 		event->base.destroy(&event->base);
-		drm_vblank_put(dev, rcrtc->index);
+		drm_crtc_vblank_put(&rcrtc->crtc);
 	}
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 }
@@ -303,7 +303,7 @@ static void rcar_du_crtc_finish_page_flip(struct rcar_du_crtc *rcrtc)
 	wake_up(&rcrtc->flip_wait);
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 
-	drm_vblank_put(dev, rcrtc->index);
+	drm_crtc_vblank_put(&rcrtc->crtc);
 }
 
 static bool rcar_du_crtc_page_flip_pending(struct rcar_du_crtc *rcrtc)
@@ -383,6 +383,9 @@ static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 
 	rcar_du_group_start_stop(rcrtc->group, true);
 
+	/* Turn vertical blanking interrupt reporting back on. */
+	drm_crtc_vblank_on(crtc);
+
 	rcrtc->started = true;
 }
 
@@ -393,10 +396,12 @@ static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
 	if (!rcrtc->started)
 		return;
 
-	/* Wait for page flip completion before stopping the CRTC as userspace
-	 * excepts page flips to eventually complete.
+	/* Disable vertical blanking interrupt reporting. We first need to wait
+	 * for page flip completion before stopping the CRTC as userspace
+	 * expects page flips to eventually complete.
 	 */
 	rcar_du_crtc_wait_page_flip(rcrtc);
+	drm_crtc_vblank_off(crtc);
 
 	mutex_lock(&rcrtc->group->planes.lock);
 	rcrtc->plane->enabled = false;
@@ -596,7 +601,7 @@ static int rcar_du_crtc_page_flip(struct drm_crtc *crtc,
 
 	if (event) {
 		event->pipe = rcrtc->index;
-		drm_vblank_get(dev, rcrtc->index);
+		drm_crtc_vblank_get(crtc);
 		spin_lock_irqsave(&dev->event_lock, flags);
 		rcrtc->event = event;
 		spin_unlock_irqrestore(&dev->event_lock, flags);
@@ -693,6 +698,9 @@ int rcar_du_crtc_create(struct rcar_du_group *rgrp, unsigned int index)
 
 	drm_crtc_helper_add(crtc, &crtc_helper_funcs);
 
+	/* Start with vertical blanking interrupt reporting disabled. */
+	drm_crtc_vblank_off(crtc);
+
 	/* Register the interrupt handler. */
 	if (rcar_du_has(rcdu, RCAR_DU_FEATURE_CRTC_IRQ_CLOCK)) {
 		irq = platform_get_irq(pdev, index);
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index e0d74f821416..8ab4c69c599b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -175,17 +175,19 @@ static int rcar_du_load(struct drm_device *dev, unsigned long flags)
 	if (IS_ERR(rcdu->mmio))
 		return PTR_ERR(rcdu->mmio);
 
-	/* DRM/KMS objects */
-	ret = rcar_du_modeset_init(rcdu);
+	/* Initialize vertical blanking interrupts handling. Start with vblank
+	 * disabled for all CRTCs.
+	 */
+	ret = drm_vblank_init(dev, (1 << rcdu->info->num_crtcs) - 1);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to initialize DRM/KMS\n");
+		dev_err(&pdev->dev, "failed to initialize vblank\n");
 		goto done;
 	}
 
-	/* vblank handling */
-	ret = drm_vblank_init(dev, (1 << rcdu->num_crtcs) - 1);
+	/* DRM/KMS objects */
+	ret = rcar_du_modeset_init(rcdu);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to initialize vblank\n");
+		dev_err(&pdev->dev, "failed to initialize DRM/KMS\n");
 		goto done;
 	}
 
-- 
2.0.5

