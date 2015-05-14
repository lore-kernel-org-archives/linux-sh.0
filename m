From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 14 May 2015 12:34:02 +0000
Subject: [PATCH 2/2] drm: rcar-du: Disable all planes when stopping the CRTC
Message-Id: <1431606842-15522-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431606842-15522-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1431606842-15522-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The DSnPR plane configuration registers are updated on vblank, and no
vblank will occur once the CRTC is stopped. We thus can't only disable
planes right before starting the CRTC as it would start scanning out
immediately from old frame buffers until the next vblank.

Fix the problem by disabling all planes when stopping the CRTC and wait
for the change to take effect. This increases the CRTC stop delay,
especially when multiple CRTCs are stopped in one operation as we now
wait for one vblank per CRTC. Whether this can be improved needs to be
researched.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index e6a32c4e4040..a40085806f5b 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -398,6 +398,19 @@ static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
 	if (!rcrtc->started)
 		return;
 
+	/* Disable all planes and wait for the change to take effect. This is
+	 * required as the DSnPR registers are updated on vblank, and no vblank
+	 * will occur once the CRTC is stopped. Disabling planes when starting
+	 * the CRTC thus wouldn't be enough as it would start scanning out
+	 * immediately from old frame buffers until the next vblank.
+	 *
+	 * This increases the CRTC stop delay, especially when multiple CRTCs
+	 * are stopped in one operation as we now wait for one vblank per CRTC.
+	 * Whether this can be improved needs to be researched.
+	 */
+	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? DS2PR : DS1PR, 0);
+	drm_crtc_wait_one_vblank(crtc);
+
 	/* Disable vertical blanking interrupt reporting. We first need to wait
 	 * for page flip completion before stopping the CRTC as userspace
 	 * expects page flips to eventually complete.
-- 
Regards,

Laurent Pinchart

