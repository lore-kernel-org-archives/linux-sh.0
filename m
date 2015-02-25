From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 25 Feb 2015 21:54:29 +0000
Subject: [PATCH 09/38] drm: rcar-du: Don't set connector->encoder at init time
Message-Id: <1424901298-6829-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

The drm_connector encoder field points to the encoder driving the
connector. No such association exists at init time, as all pipelines are
disabled. Don't set the field.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c | 1 -
 drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c | 1 -
 drivers/gpu/drm/rcar-du/rcar_du_vgacon.c  | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
index ca94b029ac80..3896cb20ad51 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
@@ -116,7 +116,6 @@ int rcar_du_hdmi_connector_init(struct rcar_du_device *rcdu,
 	if (ret < 0)
 		return ret;
 
-	connector->encoder = encoder;
 	rcon->encoder = renc;
 
 	return 0;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
index 6d9811c052c4..7c0b08fe0774 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_lvdscon.c
@@ -125,7 +125,6 @@ int rcar_du_lvds_connector_init(struct rcar_du_device *rcdu,
 	if (ret < 0)
 		return ret;
 
-	connector->encoder = encoder;
 	lvdscon->connector.encoder = renc;
 
 	return 0;
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c b/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
index 9d4879921cc7..ae8b304e6fea 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vgacon.c
@@ -84,7 +84,6 @@ int rcar_du_vga_connector_init(struct rcar_du_device *rcdu,
 	if (ret < 0)
 		return ret;
 
-	connector->encoder = encoder;
 	rcon->encoder = renc;
 
 	return 0;
-- 
2.0.5

