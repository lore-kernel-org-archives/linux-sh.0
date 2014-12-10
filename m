From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Dec 2014 23:42:07 +0000
Subject: [PATCH 07/15] drm: rcar-du: Output HSYNC instead of CSYNC
Message-Id: <1418254935-13536-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The DU outputs by default a composite sync signal (XOR of the horizontal
and vertical sync signals) on the HSYNC output pin. As this can confuse
devices and isn't needed by any of the supported encoders, configure the
HSYNC pin to output the horizontal sync signal.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index ce280bd390a9..25b762b58765 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -144,7 +144,7 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 	/* Signal polarities */
 	value = ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? 0 : DSMR_VSL)
 	      | ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? 0 : DSMR_HSL)
-	      | DSMR_DIPM_DE;
+	      | DSMR_DIPM_DE | DSMR_CSPM;
 	rcar_du_crtc_write(rcrtc, DSMR, value);
 
 	/* Display timings */
-- 
2.0.4

