From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 13 Sep 2015 20:57:00 +0000
Subject: [PATCH 22/32] v4l: vsp1: Make the BRU optional
Message-Id: <1442177830-24536-23-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442177830-24536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442177830-24536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org

Not all VSP instances have a BRU on R-Car Gen3, make it optional. For
backward compatibility with older DT bindings default to BRU
availability on R-Car Gen2.

Cc: devicetree@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../devicetree/bindings/media/renesas,vsp1.txt     |  3 +++
 drivers/media/platform/vsp1/vsp1.h                 |  1 +
 drivers/media/platform/vsp1/vsp1_drv.c             | 23 ++++++++++++++++------
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,vsp1.txt b/Documentation/devicetree/bindings/media/renesas,vsp1.txt
index 674c8c30d046..766f034c1e45 100644
--- a/Documentation/devicetree/bindings/media/renesas,vsp1.txt
+++ b/Documentation/devicetree/bindings/media/renesas,vsp1.txt
@@ -20,6 +20,9 @@ Optional properties:
 
   - renesas,#uds: Number of Up Down Scaler (UDS) modules in the VSP1. Defaults
     to 0 if not present.
+  - renesas,has-bru: Boolean, indicates that the Blending & ROP Unit (BRU)
+    module is available. Defaults to true on R-Car Gen2 and false on R-Car Gen3
+    if not present.
   - renesas,has-lif: Boolean, indicates that the LCD Interface (LIF) module is
     available.
   - renesas,has-lut: Boolean, indicates that the Look Up Table (LUT) module is
diff --git a/drivers/media/platform/vsp1/vsp1.h b/drivers/media/platform/vsp1/vsp1.h
index 3b2b2387e085..173f9f830049 100644
--- a/drivers/media/platform/vsp1/vsp1.h
+++ b/drivers/media/platform/vsp1/vsp1.h
@@ -42,6 +42,7 @@ struct vsp1_uds;
 #define VSP1_HAS_LIF		(1 << 0)
 #define VSP1_HAS_LUT		(1 << 1)
 #define VSP1_HAS_SRU		(1 << 2)
+#define VSP1_HAS_BRU		(1 << 3)
 
 struct vsp1_platform_data {
 	unsigned int features;
diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index bd22457bf392..eccdacdf4f4c 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -223,13 +223,15 @@ static int vsp1_create_entities(struct vsp1_device *vsp1)
 	}
 
 	/* Instantiate all the entities. */
-	vsp1->bru = vsp1_bru_create(vsp1);
-	if (IS_ERR(vsp1->bru)) {
-		ret = PTR_ERR(vsp1->bru);
-		goto done;
-	}
+	if (vsp1->pdata.features & VSP1_HAS_BRU) {
+		vsp1->bru = vsp1_bru_create(vsp1);
+		if (IS_ERR(vsp1->bru)) {
+			ret = PTR_ERR(vsp1->bru);
+			goto done;
+		}
 
-	list_add_tail(&vsp1->bru->entity.list_dev, &vsp1->entities);
+		list_add_tail(&vsp1->bru->entity.list_dev, &vsp1->entities);
+	}
 
 	vsp1->hsi = vsp1_hsit_create(vsp1, true);
 	if (IS_ERR(vsp1->hsi)) {
@@ -513,6 +515,8 @@ static int vsp1_parse_dt(struct vsp1_device *vsp1)
 
 	vsp1->info = of_device_get_match_data(vsp1->dev);
 
+	if (of_property_read_bool(np, "renesas,has-bru"))
+		pdata->features |= VSP1_HAS_BRU;
 	if (of_property_read_bool(np, "renesas,has-lif"))
 		pdata->features |= VSP1_HAS_LIF;
 	if (of_property_read_bool(np, "renesas,has-lut"))
@@ -542,6 +546,13 @@ static int vsp1_parse_dt(struct vsp1_device *vsp1)
 		return -EINVAL;
 	}
 
+	/* Backward compatibility: all Gen2 VSP instances have a BRU, the
+	 * renesas,has-bru property was thus not available. Set the HAS_BRU
+	 * feature automatically in that case.
+	 */
+	if (vsp1->info->num_bru_inputs = 4)
+		pdata->features |= VSP1_HAS_BRU;
+
 	return 0;
 }
 
-- 
2.4.6

