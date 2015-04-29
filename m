From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 29 Apr 2015 00:37:55 +0000
Subject: [PATCH 01/10] drm: rcar-du: Document the rcar_du_crtc structure
Message-Id: <1430267884-20560-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430267884-20560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1430267884-20560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Document the structure fields using kerneldoc.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
index 5d9aa9b33769..e72f15c8c706 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -22,6 +22,20 @@
 
 struct rcar_du_group;
 
+/*
+ * rcar_du_crtc - the CRTC, representing a DU superposition processor
+ * @crtc: base DRM CRTC
+ * @clock: the CRTC functional clock
+ * @extclock: external pixel dot clock (optional)
+ * @mmio_offset: offset of the CRTC registers in the DU MMIO block
+ * @index: CRTC software and hardware index
+ * @started: whether the CRTC has been started and is running
+ * @event: event to post when the pending page flip completes
+ * @flip_wait: wait queue used to signal page flip completion
+ * @outputs: bitmask of the outputs (enum rcar_du_output) driven by this CRTC
+ * @enabled: whether the CRTC is enabled, used to control system resume
+ * @group: CRTC group this CRTC belongs to
+ */
 struct rcar_du_crtc {
 	struct drm_crtc crtc;
 
-- 
2.0.5

