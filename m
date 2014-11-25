From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 25 Nov 2014 23:47:27 +0000
Subject: [PATCH v4 6/9] drm: Decouple EDID parsing from I2C adapter
Message-Id: <1416959247-23132-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414337068-28664-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414337068-28664-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

The drm_get_edid() function performs direct I2C accesses to read EDID
blocks, assuming that the monitor DDC interface is directly connected to
the I2C bus. It can't thus be used with HDMI encoders that control the
DDC bus and expose EDID blocks through a different interface.

Refactor drm_do_get_edid() to take a block read callback function
instead of an I2C adapter, and export it for direct use by drivers.

As in the general case the DDC bus is accessible by the kernel at the
I2C level, drivers must make all reasonable efforts to expose it as an
I2C adapter and use drm_get_edid() instead of abusing this function.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/gpu/drm/drm_edid.c | 43 ++++++++++++++++++++++++++++++-------------
 include/drm/drm_edid.h     |  5 +++++
 2 files changed, 35 insertions(+), 13 deletions(-)

Daniel, could you please review and hopefully ack this ? If this new version is
acceptable I'd like to send an updated pull request for R-Car DU HDMI support
for v3.19, so time is running short.

Changes since v3:

- Add kerneldoc for the new exported drm_do_get_edid function

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 3bf999134bcc..1a77a49d2695 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1125,9 +1125,9 @@ EXPORT_SYMBOL(drm_edid_is_valid);
  * Return: 0 on success or -1 on failure.
  */
 static int
-drm_do_probe_ddc_edid(struct i2c_adapter *adapter, unsigned char *buf,
-		      int block, int len)
+drm_do_probe_ddc_edid(void *data, u8 *buf, unsigned int block, size_t len)
 {
+	struct i2c_adapter *adapter = data;
 	unsigned char start = block * EDID_LENGTH;
 	unsigned char segment = block >> 1;
 	unsigned char xfers = segment ? 3 : 2;
@@ -1184,8 +1184,26 @@ static bool drm_edid_is_zero(u8 *in_edid, int length)
 	return true;
 }
 
-static u8 *
-drm_do_get_edid(struct drm_connector *connector, struct i2c_adapter *adapter)
+/**
+ * drm_do_get_edid - get EDID data using a custom EDID block read function
+ * @connector: connector we're probing
+ * @get_edid_block: EDID block read function
+ * @data: private data passed to the block read function
+ *
+ * When the I2C adapter connected to the DDC bus is hidden behind a device that
+ * exposes a different interface to read EDID blocks this function can be used
+ * to get EDID data using a custom block read function.
+ *
+ * As in the general case the DDC bus is accessible by the kernel at the I2C
+ * level, drivers must make all reasonable efforts to expose it as an I2C
+ * adapter and use drm_get_edid() instead of abusing this function.
+ *
+ * Return: Pointer to valid EDID or NULL if we couldn't find any.
+ */
+struct edid *drm_do_get_edid(struct drm_connector *connector,
+	int (*get_edid_block)(void *data, u8 *buf, unsigned int block,
+			      size_t len),
+	void *data)
 {
 	int i, j = 0, valid_extensions = 0;
 	u8 *block, *new;
@@ -1196,7 +1214,7 @@ drm_do_get_edid(struct drm_connector *connector, struct i2c_adapter *adapter)
 
 	/* base block fetch */
 	for (i = 0; i < 4; i++) {
-		if (drm_do_probe_ddc_edid(adapter, block, 0, EDID_LENGTH))
+		if (get_edid_block(data, block, 0, EDID_LENGTH))
 			goto out;
 		if (drm_edid_block_valid(block, 0, print_bad_edid))
 			break;
@@ -1210,7 +1228,7 @@ drm_do_get_edid(struct drm_connector *connector, struct i2c_adapter *adapter)
 
 	/* if there's no extensions, we're done */
 	if (block[0x7e] = 0)
-		return block;
+		return (struct edid *)block;
 
 	new = krealloc(block, (block[0x7e] + 1) * EDID_LENGTH, GFP_KERNEL);
 	if (!new)
@@ -1219,7 +1237,7 @@ drm_do_get_edid(struct drm_connector *connector, struct i2c_adapter *adapter)
 
 	for (j = 1; j <= block[0x7e]; j++) {
 		for (i = 0; i < 4; i++) {
-			if (drm_do_probe_ddc_edid(adapter,
+			if (get_edid_block(data,
 				  block + (valid_extensions + 1) * EDID_LENGTH,
 				  j, EDID_LENGTH))
 				goto out;
@@ -1247,7 +1265,7 @@ drm_do_get_edid(struct drm_connector *connector, struct i2c_adapter *adapter)
 		block = new;
 	}
 
-	return block;
+	return (struct edid *)block;
 
 carp:
 	if (print_bad_edid) {
@@ -1260,6 +1278,7 @@ out:
 	kfree(block);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(drm_do_get_edid);
 
 /**
  * drm_probe_ddc() - probe DDC presence
@@ -1289,12 +1308,10 @@ EXPORT_SYMBOL(drm_probe_ddc);
 struct edid *drm_get_edid(struct drm_connector *connector,
 			  struct i2c_adapter *adapter)
 {
-	struct edid *edid = NULL;
-
-	if (drm_probe_ddc(adapter))
-		edid = (struct edid *)drm_do_get_edid(connector, adapter);
+	if (!drm_probe_ddc(adapter))
+		return NULL;
 
-	return edid;
+	return drm_do_get_edid(connector, drm_do_probe_ddc_edid, adapter);
 }
 EXPORT_SYMBOL(drm_get_edid);
 
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index c2f1bfa22010..d59240ffb1f7 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -381,4 +381,9 @@ static inline int drm_eld_size(const uint8_t *eld)
 	return DRM_ELD_HEADER_BLOCK_SIZE + eld[DRM_ELD_BASELINE_ELD_LEN] * 4;
 }
 
+struct edid *drm_do_get_edid(struct drm_connector *connector,
+	int (*get_edid_block)(void *data, u8 *buf, unsigned int block,
+			      size_t len),
+	void *data);
+
 #endif /* __DRM_EDID_H__ */
-- 
2.0.4

