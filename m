From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Dec 2014 23:42:10 +0000
Subject: [PATCH 10/15] drm: rcar-du: Implement support for interlaced modes
Message-Id: <1418254935-13536-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Accept interlaced modes on the VGA and HDMI connectors and configure the
hardware accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c    | 23 +++++++++++++++--------
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c |  1 +
 drivers/gpu/drm/rcar-du/rcar_du_plane.c   | 18 +++++++++++++++---
 drivers/gpu/drm/rcar-du/rcar_du_regs.h    |  1 +
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c  |  1 +
 5 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 86766cc6360a..25c7a998fc2c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -155,12 +155,15 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 					mode->hsync_start - 1);
 	rcar_du_crtc_write(rcrtc, HCR,  mode->htotal - 1);
 
-	rcar_du_crtc_write(rcrtc, VDSR, mode->vtotal - mode->vsync_end - 2);
-	rcar_du_crtc_write(rcrtc, VDER, mode->vtotal - mode->vsync_end +
-					mode->vdisplay - 2);
-	rcar_du_crtc_write(rcrtc, VSPR, mode->vtotal - mode->vsync_end +
-					mode->vsync_start - 1);
-	rcar_du_crtc_write(rcrtc, VCR,  mode->vtotal - 1);
+	rcar_du_crtc_write(rcrtc, VDSR, mode->crtc_vtotal -
+					mode->crtc_vsync_end - 2);
+	rcar_du_crtc_write(rcrtc, VDER, mode->crtc_vtotal -
+					mode->crtc_vsync_end +
+					mode->crtc_vdisplay - 2);
+	rcar_du_crtc_write(rcrtc, VSPR, mode->crtc_vtotal -
+					mode->crtc_vsync_end +
+					mode->crtc_vsync_start - 1);
+	rcar_du_crtc_write(rcrtc, VCR,  mode->crtc_vtotal - 1);
 
 	rcar_du_crtc_write(rcrtc, DESR,  mode->htotal - mode->hsync_start);
 	rcar_du_crtc_write(rcrtc, DEWR,  mode->hdisplay);
@@ -256,6 +259,7 @@ void rcar_du_crtc_update_planes(struct drm_crtc *crtc)
 static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 {
 	struct drm_crtc *crtc = &rcrtc->crtc;
+	bool interlaced;
 	unsigned int i;
 
 	if (rcrtc->started)
@@ -291,7 +295,10 @@ static void rcar_du_crtc_start(struct rcar_du_crtc *rcrtc)
 	 * sync mode (with the HSYNC and VSYNC signals configured as outputs and
 	 * actively driven).
 	 */
-	rcar_du_crtc_clr_set(rcrtc, DSYSR, DSYSR_TVM_MASK, DSYSR_TVM_MASTER);
+	interlaced = rcrtc->crtc.mode.flags & DRM_MODE_FLAG_INTERLACE;
+	rcar_du_crtc_clr_set(rcrtc, DSYSR, DSYSR_TVM_MASK | DSYSR_SCM_MASK,
+			     (interlaced ? DSYSR_SCM_INT_VIDEO : 0) |
+			     DSYSR_TVM_MASTER);
 
 	rcar_du_group_start_stop(rcrtc->group, true);
 
@@ -528,7 +535,7 @@ static irqreturn_t rcar_du_crtc_irq(int irq, void *arg)
 	status = rcar_du_crtc_read(rcrtc, DSSR);
 	rcar_du_crtc_write(rcrtc, DSRCR, status & DSRCR_MASK);
 
-	if (status & DSSR_VBK) {
+	if (status & DSSR_FRM) {
 		drm_handle_vblank(rcrtc->crtc.dev, rcrtc->index);
 		rcar_du_crtc_finish_page_flip(rcrtc);
 		ret = IRQ_HANDLED;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
index 322b7208171a..ca94b029ac80 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
@@ -95,6 +95,7 @@ int rcar_du_hdmi_connector_init(struct rcar_du_device *rcdu,
 	connector = &rcon->connector;
 	connector->display_info.width_mm = 0;
 	connector->display_info.height_mm = 0;
+	connector->interlace_allowed = true;
 	connector->polled = DRM_CONNECTOR_POLL_HPD;
 
 	ret = drm_connector_init(rcdu->ddev, connector, &connector_funcs,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
index fb3ea4f95d4a..50f2f2b20d39 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
@@ -104,14 +104,22 @@ void rcar_du_plane_update_base(struct rcar_du_plane *plane)
 {
 	struct rcar_du_group *rgrp = plane->group;
 	unsigned int index = plane->hwindex;
+	bool interlaced;
 	u32 mwr;
 
-	/* Memory pitch (expressed in pixels) */
+	interlaced = plane->crtc->mode.flags & DRM_MODE_FLAG_INTERLACE;
+
+	/* Memory pitch (expressed in pixels). Must be doubled for interlaced
+	 * operation with 32bpp formats.
+	 */
 	if (plane->format->planes = 2)
 		mwr = plane->pitch;
 	else
 		mwr = plane->pitch * 8 / plane->format->bpp;
 
+	if (interlaced && plane->format->bpp = 32)
+		mwr *= 2;
+
 	rcar_du_plane_write(rgrp, index, PnMWR, mwr);
 
 	/* The Y position is expressed in raster line units and must be doubled
@@ -119,12 +127,16 @@ void rcar_du_plane_update_base(struct rcar_du_plane *plane)
 	 * doubling the Y position is found in the R8A7779 datasheet, but the
 	 * rule seems to apply there as well.
 	 *
+	 * Despite not being documented, doubling seem not to be needed when
+	 * operating in interlaced mode.
+	 *
 	 * Similarly, for the second plane, NV12 and NV21 formats seem to
-	 * require a halved Y position value.
+	 * require a halved Y position value, in both progressive and interlaced
+	 * modes.
 	 */
 	rcar_du_plane_write(rgrp, index, PnSPXR, plane->src_x);
 	rcar_du_plane_write(rgrp, index, PnSPYR, plane->src_y *
-			    (plane->format->bpp = 32 ? 2 : 1));
+			    (!interlaced && plane->format->bpp = 32 ? 2 : 1));
 	rcar_du_plane_write(rgrp, index, PnDSA0R, plane->dma[0]);
 
 	if (plane->format->planes = 2) {
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_regs.h b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
index c3639d1db28b..70fcbc471ebd 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_regs.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_regs.h
@@ -34,6 +34,7 @@
 #define DSYSR_SCM_INT_NONE	(0 << 4)
 #define DSYSR_SCM_INT_SYNC	(2 << 4)
 #define DSYSR_SCM_INT_VIDEO	(3 << 4)
+#define DSYSR_SCM_MASK		(3 << 4)
 
 #define DSMR			0x00004
 #define DSMR_VSPM		(1 << 28)
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c b/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
index 752747a5e920..9d4879921cc7 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
@@ -64,6 +64,7 @@ int rcar_du_vga_connector_init(struct rcar_du_device *rcdu,
 	connector = &rcon->connector;
 	connector->display_info.width_mm = 0;
 	connector->display_info.height_mm = 0;
+	connector->interlace_allowed = true;
 
 	ret = drm_connector_init(rcdu->ddev, connector, &connector_funcs,
 				 DRM_MODE_CONNECTOR_VGA);
-- 
2.0.4

