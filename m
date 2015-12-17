From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 17 Dec 2015 06:25:39 +0000
Subject: [PATCH] drm: rcar-du: Add probe deferral debug messages
Message-Id: <1450333539-32178-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Print a message when the HDMI I2C slave encoder can't be found to help
debugging probe deferral issues.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
index 00fea7e6b378..cb892eefc723 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_hdmienc.c
@@ -131,12 +131,19 @@ int rcar_du_hdmienc_init(struct rcar_du_device *rcdu,
 
 	/* Locate the slave I2C device and driver. */
 	i2c_slave = of_find_i2c_device_by_node(np);
-	if (!i2c_slave || !i2c_get_clientdata(i2c_slave))
+	if (!i2c_slave || !i2c_get_clientdata(i2c_slave)) {
+		dev_dbg(rcdu->dev,
+			"can't get I2C slave for %s, deferring probe\n",
+			of_node_full_name(np));
 		return -EPROBE_DEFER;
+	}
 
 	hdmienc->dev = &i2c_slave->dev;
 
 	if (hdmienc->dev->driver = NULL) {
+		dev_dbg(rcdu->dev,
+			"I2C slave %s not probed yet, deferring probe\n",
+			dev_name(hdmienc->dev));
 		ret = -EPROBE_DEFER;
 		goto error;
 	}
-- 
Regards,

Laurent Pinchart

