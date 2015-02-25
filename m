From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:24 +0000
Subject: [PATCH 04/38] drm/atomic-helpers: Fix documentation typos and wrong copy&paste
Message-Id: <1424901298-6829-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The kerneldoc blocks for the drm_atomic_helper_*_set_property()
functions seem to have been copied from the plane disable handler
without being properly updated. Fix them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index caafc237c28b..df13c70d7899 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1689,12 +1689,13 @@ backoff:
 EXPORT_SYMBOL(drm_atomic_helper_set_config);
 
 /**
- * drm_atomic_helper_crtc_set_property - helper for crtc prorties
+ * drm_atomic_helper_crtc_set_property - helper for crtc properties
  * @crtc: DRM crtc
  * @property: DRM property
  * @val: value of property
  *
- * Provides a default plane disablle handler using the atomic driver interface.
+ * Provides a default crtc set_property handler using the atomic driver
+ * interface.
  *
  * RETURNS:
  * Zero on success, error code on failure
@@ -1748,12 +1749,13 @@ backoff:
 EXPORT_SYMBOL(drm_atomic_helper_crtc_set_property);
 
 /**
- * drm_atomic_helper_plane_set_property - helper for plane prorties
+ * drm_atomic_helper_plane_set_property - helper for plane properties
  * @plane: DRM plane
  * @property: DRM property
  * @val: value of property
  *
- * Provides a default plane disable handler using the atomic driver interface.
+ * Provides a default plane set_property handler using the atomic driver
+ * interface.
  *
  * RETURNS:
  * Zero on success, error code on failure
@@ -1807,12 +1809,13 @@ backoff:
 EXPORT_SYMBOL(drm_atomic_helper_plane_set_property);
 
 /**
- * drm_atomic_helper_connector_set_property - helper for connector prorties
+ * drm_atomic_helper_connector_set_property - helper for connector properties
  * @connector: DRM connector
  * @property: DRM property
  * @val: value of property
  *
- * Provides a default plane disablle handler using the atomic driver interface.
+ * Provides a default connector set_property handler using the atomic driver
+ * interface.
  *
  * RETURNS:
  * Zero on success, error code on failure
-- 
2.0.5

