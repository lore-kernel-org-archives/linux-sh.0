From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 10 Dec 2014 23:42:08 +0000
Subject: [PATCH 08/15] drm: rcar-du: Enable hotplug detection on HDMI connector
Message-Id: <1418254935-13536-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

As HDMI support hotplug detection, enable HPD-based poll on HDMI
connectors.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
index 4d7d4dd46d26..322b7208171a 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmicon.c
@@ -95,6 +95,7 @@ int rcar_du_hdmi_connector_init(struct rcar_du_device *rcdu,
 	connector = &rcon->connector;
 	connector->display_info.width_mm = 0;
 	connector->display_info.height_mm = 0;
+	connector->polled = DRM_CONNECTOR_POLL_HPD;
 
 	ret = drm_connector_init(rcdu->ddev, connector, &connector_funcs,
 				 DRM_MODE_CONNECTOR_HDMIA);
-- 
2.0.4

