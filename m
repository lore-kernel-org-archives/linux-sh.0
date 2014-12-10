From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Dec 2014 23:42:09 +0000
Subject: [PATCH 09/15] drm: rcar-du: Clamp DPMS states to on and off
Message-Id: <1418254935-13536-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The intermediate DPMS standby and suspend states are a thing from the
past. They only matter in practice for VGA CRT monitors, and are just a
power saving vs. resume time optimization. Given that they have never
been implemented properly in the rcar-du driver and that the Intel
driver has dropped them on the vga port years ago, it's safe to only
care about the on and off states.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c    | 3 +++
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c | 3 +++
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 25b762b58765..86766cc6360a 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -347,6 +347,9 @@ static void rcar_du_crtc_dpms(struct drm_crtc *crtc, int mode)
 {
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 
+	if (mode != DRM_MODE_DPMS_ON)
+		mode = DRM_MODE_DPMS_OFF;
+
 	if (rcrtc->dpms = mode)
 		return;
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
index 243aba8d4dd2..279167f783f6 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_encoder.c
@@ -46,6 +46,9 @@ static void rcar_du_encoder_dpms(struct drm_encoder *encoder, int mode)
 {
 	struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
 
+	if (mode != DRM_MODE_DPMS_ON)
+		mode = DRM_MODE_DPMS_OFF;
+
 	if (renc->lvds)
 		rcar_du_lvdsenc_dpms(renc->lvds, encoder->crtc, mode);
 }
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
index 0d774a937e79..221f0a17fd6a 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
@@ -37,6 +37,9 @@ static void rcar_du_hdmienc_dpms(struct drm_encoder *encoder, int mode)
 	struct rcar_du_hdmienc *hdmienc = to_rcar_hdmienc(encoder);
 	struct drm_encoder_slave_funcs *sfuncs = to_slave_funcs(encoder);
 
+	if (mode != DRM_MODE_DPMS_ON)
+		mode = DRM_MODE_DPMS_OFF;
+
 	if (hdmienc->dpms = mode)
 		return;
 
-- 
2.0.4

