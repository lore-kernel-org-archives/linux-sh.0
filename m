From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 14 Apr 2014 10:36:40 +0000
Subject: [PATCH v3 5/7] rcar_vin: copy flags from pdata
Message-Id: <1397471802-27216-6-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The platform data is a single word, so simply copy
it into the device's private data structure than
keeping a copy of the pointer.

This will make changing to device-tree binding
easier as it is one allocation instead of two.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/media/platform/soc_camera/rcar_vin.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
index 702dc47..47516df 100644
--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -126,13 +126,13 @@ struct rcar_vin_priv {
 	int				sequence;
 	/* State of the VIN module in capturing mode */
 	enum rcar_vin_state		state;
-	struct rcar_vin_platform_data	*pdata;
 	struct soc_camera_host		ici;
 	struct list_head		capture;
 #define MAX_BUFFER_NUM			3
 	struct vb2_buffer		*queue_buf[MAX_BUFFER_NUM];
 	struct vb2_alloc_ctx		*alloc_ctx;
 	enum v4l2_field			field;
+	unsigned int			pdata_flags;
 	unsigned int			vb_count;
 	unsigned int			nr_hw_slots;
 	bool				request_to_stop;
@@ -275,12 +275,12 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
 		break;
 	case V4L2_MBUS_FMT_YUYV8_2X8:
 		/* BT.656 8bit YCbCr422 or BT.601 8bit YCbCr422 */
-		vnmc |= priv->pdata->flags & RCAR_VIN_BT656 ?
+		vnmc |= priv->pdata_flags & RCAR_VIN_BT656 ?
 			VNMC_INF_YUV8_BT656 : VNMC_INF_YUV8_BT601;
 		break;
 	case V4L2_MBUS_FMT_YUYV10_2X10:
 		/* BT.656 10bit YCbCr422 or BT.601 10bit YCbCr422 */
-		vnmc |= priv->pdata->flags & RCAR_VIN_BT656 ?
+		vnmc |= priv->pdata_flags & RCAR_VIN_BT656 ?
 			VNMC_INF_YUV10_BT656 : VNMC_INF_YUV10_BT601;
 		break;
 	default:
@@ -799,7 +799,7 @@ static int rcar_vin_set_bus_param(struct soc_camera_device *icd)
 	/* Make choises, based on platform preferences */
 	if ((common_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) &&
 	    (common_flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)) {
-		if (priv->pdata->flags & RCAR_VIN_HSYNC_ACTIVE_LOW)
+		if (priv->pdata_flags & RCAR_VIN_HSYNC_ACTIVE_LOW)
 			common_flags &= ~V4L2_MBUS_HSYNC_ACTIVE_HIGH;
 		else
 			common_flags &= ~V4L2_MBUS_HSYNC_ACTIVE_LOW;
@@ -807,7 +807,7 @@ static int rcar_vin_set_bus_param(struct soc_camera_device *icd)
 
 	if ((common_flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH) &&
 	    (common_flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)) {
-		if (priv->pdata->flags & RCAR_VIN_VSYNC_ACTIVE_LOW)
+		if (priv->pdata_flags & RCAR_VIN_VSYNC_ACTIVE_LOW)
 			common_flags &= ~V4L2_MBUS_VSYNC_ACTIVE_HIGH;
 		else
 			common_flags &= ~V4L2_MBUS_VSYNC_ACTIVE_LOW;
@@ -1447,7 +1447,7 @@ static int rcar_vin_probe(struct platform_device *pdev)
 	priv->ici.drv_name = dev_name(&pdev->dev);
 	priv->ici.ops = &rcar_vin_host_ops;
 
-	priv->pdata = pdata;
+	priv->pdata_flags = pdata->flags;
 	priv->chip = pdev->id_entry->driver_data;
 	spin_lock_init(&priv->lock);
 	INIT_LIST_HEAD(&priv->capture);
-- 
1.9.1

