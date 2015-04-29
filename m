From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 29 Apr 2015 00:37:56 +0000
Subject: [PATCH 02/10] drm: rcar-du: Document the rcar_du_plane_state structure
Message-Id: <1430267884-20560-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 drivers/gpu/drm/rcar-du/rcar_du_plane.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.h b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
index abff0ebeb195..5d2b764919d8 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_plane.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.h
@@ -46,11 +46,20 @@ struct rcar_du_planes {
 	struct drm_property *zpos;
 };
 
+/*
+ * rcar_du_plane_state - Driver-specific plane state
+ * @state: base DRM plane state
+ * @format: information about the pixel format used by the plane
+ * @hwindex: 0-based hardware plane index, -1 means unused
+ * @alpha: value of the plane alpha property
+ * @colorkey: value of the plane colorkey property
+ * @zpos: value of the plane zpos property
+ */
 struct rcar_du_plane_state {
 	struct drm_plane_state state;
 
 	const struct rcar_du_format_info *format;
-	int hwindex;		/* 0-based, -1 means unused */
+	int hwindex;
 
 	unsigned int alpha;
 	unsigned int colorkey;
-- 
2.0.5

