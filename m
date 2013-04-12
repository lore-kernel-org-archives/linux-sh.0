From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 12 Apr 2013 15:40:39 +0000
Subject: [PATCH v9 19/20] imx074: support asynchronous probing
Message-Id: <1365781240-16149-20-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1365781240-16149-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1365781240-16149-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>

Both synchronous and asynchronous imx074 subdevice probing is supported by
this patch.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/media/i2c/soc_camera/imx074.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/soc_camera/imx074.c b/drivers/media/i2c/soc_camera/imx074.c
index a6a5060..c0eed84 100644
--- a/drivers/media/i2c/soc_camera/imx074.c
+++ b/drivers/media/i2c/soc_camera/imx074.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 
 #include <media/soc_camera.h>
+#include <media/v4l2-async.h>
 #include <media/v4l2-clk.h>
 #include <media/v4l2-subdev.h>
 #include <media/v4l2-chip-ident.h>
@@ -455,14 +456,27 @@ static int imx074_probe(struct i2c_client *client,
 
 	priv->fmt	= &imx074_colour_fmts[0];
 
+	priv->subdev.dev = &client->dev;
+
 	priv->clk = v4l2_clk_get(&client->dev, "mclk");
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
+	if (IS_ERR(priv->clk)) {
+		dev_info(&client->dev, "Error %ld getting clock\n", PTR_ERR(priv->clk));
+		return -EPROBE_DEFER;
+	}
+
+	ret = soc_camera_power_init(&client->dev, ssdd);
+	if (ret < 0)
+		goto epwrinit;
 
 	ret = imx074_video_probe(client);
 	if (ret < 0)
-		v4l2_clk_put(priv->clk);
+		goto eprobe;
 
+	return v4l2_async_register_subdev(&priv->subdev);
+
+epwrinit:
+eprobe:
+	v4l2_clk_put(priv->clk);
 	return ret;
 }
 
@@ -471,7 +485,9 @@ static int imx074_remove(struct i2c_client *client)
 	struct soc_camera_subdev_desc *ssdd = soc_camera_i2c_to_desc(client);
 	struct imx074 *priv = to_imx074(client);
 
+	v4l2_async_unregister_subdev(&priv->subdev);
 	v4l2_clk_put(priv->clk);
+
 	if (ssdd->free_bus)
 		ssdd->free_bus(ssdd);
 
-- 
1.7.2.5

