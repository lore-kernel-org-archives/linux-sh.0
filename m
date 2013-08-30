From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Fri, 30 Aug 2013 12:37:36 +0000
Subject: [RFC 02/10] drm: Decouple edid parsing from i2c adapter
Message-Id: <1377866264-21110-3-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/gpu/drm/drm_edid.c | 18 ++++++++++--------
 include/drm/drm_edid.h     |  3 +++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 95d6f4b..94f4d79 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1059,9 +1059,10 @@ EXPORT_SYMBOL(drm_edid_is_valid);
  * Try to fetch EDID information by calling i2c driver function.
  */
 static int
-drm_do_probe_ddc_edid(struct i2c_adapter *adapter, unsigned char *buf,
+drm_do_probe_ddc_edid(void *data, unsigned char *buf,
 		      int block, int len)
 {
+	struct i2c_adapter *adapter = data;
 	unsigned char start = block * EDID_LENGTH;
 	unsigned char segment = block >> 1;
 	unsigned char xfers = segment ? 3 : 2;
@@ -1117,8 +1118,8 @@ static bool drm_edid_is_zero(u8 *in_edid, int length)
 	return true;
 }
 
-static u8 *
-drm_do_get_edid(struct drm_connector *connector, struct i2c_adapter *adapter)
+struct edid *drm_do_get_edid(struct drm_connector *connector,
+	int (*get_edid_block)(void *, unsigned char *buf, int, int), void *data)
 {
 	int i, j = 0, valid_extensions = 0;
 	u8 *block, *new;
@@ -1129,7 +1130,7 @@ drm_do_get_edid(struct drm_connector *connector, struct i2c_adapter *adapter)
 
 	/* base block fetch */
 	for (i = 0; i < 4; i++) {
-		if (drm_do_probe_ddc_edid(adapter, block, 0, EDID_LENGTH))
+		if (get_edid_block(data, block, 0, EDID_LENGTH))
 			goto out;
 		if (drm_edid_block_valid(block, 0, print_bad_edid))
 			break;
@@ -1143,7 +1144,7 @@ drm_do_get_edid(struct drm_connector *connector, struct i2c_adapter *adapter)
 
 	/* if there's no extensions, we're done */
 	if (block[0x7e] = 0)
-		return block;
+		return (struct edid *)block;
 
 	new = krealloc(block, (block[0x7e] + 1) * EDID_LENGTH, GFP_KERNEL);
 	if (!new)
@@ -1152,7 +1153,7 @@ drm_do_get_edid(struct drm_connector *connector, struct i2c_adapter *adapter)
 
 	for (j = 1; j <= block[0x7e]; j++) {
 		for (i = 0; i < 4; i++) {
-			if (drm_do_probe_ddc_edid(adapter,
+			if (get_edid_block(data,
 				  block + (valid_extensions + 1) * EDID_LENGTH,
 				  j, EDID_LENGTH))
 				goto out;
@@ -1180,7 +1181,7 @@ drm_do_get_edid(struct drm_connector *connector, struct i2c_adapter *adapter)
 		block = new;
 	}
 
-	return block;
+	return (struct edid *)block;
 
 carp:
 	if (print_bad_edid) {
@@ -1193,6 +1194,7 @@ out:
 	kfree(block);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(drm_do_get_edid);
 
 /**
  * Probe DDC presence.
@@ -1225,7 +1227,7 @@ struct edid *drm_get_edid(struct drm_connector *connector,
 	struct edid *edid = NULL;
 
 	if (drm_probe_ddc(adapter))
-		edid = (struct edid *)drm_do_get_edid(connector, adapter);
+		edid = (struct edid *)drm_do_get_edid(connector, drm_do_probe_ddc_edid, adapter);
 
 	return edid;
 }
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index fc481fc..fff4a48 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -269,4 +269,7 @@ int
 drm_hdmi_avi_infoframe_from_display_mode(struct hdmi_avi_infoframe *frame,
 					 const struct drm_display_mode *mode);
 
+struct edid *drm_do_get_edid(struct drm_connector *connector,
+	int (*get_edid_block)(void *, unsigned char *buf, int, int), void *data);
+
 #endif /* __DRM_EDID_H__ */
-- 
1.8.1.4

