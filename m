From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 14 Apr 2014 10:36:36 +0000
Subject: [PATCH v3 1/7] adv7180: use async subdev registration
Message-Id: <1397471802-27216-2-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Change to using the the async subdev registration API so
that when soc_camera is using OF to find devices this can
be found and attached.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/media/i2c/adv7180.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index d7d99f1..215afa0 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -29,6 +29,7 @@
 #include <linux/videodev2.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-ctrls.h>
+#include <media/v4l2-async.h>
 #include <linux/mutex.h>
 
 #define ADV7180_INPUT_CONTROL_REG			0x00
@@ -611,6 +612,11 @@ static int adv7180_probe(struct i2c_client *client,
 	ret = init_device(client, state);
 	if (ret)
 		goto err_free_ctrl;
+
+	ret = v4l2_async_register_subdev(sd);
+	if (ret)
+		goto err_free_ctrl;
+
 	return 0;
 
 err_free_ctrl:
@@ -641,7 +647,7 @@ static int adv7180_remove(struct i2c_client *client)
 	}
 
 	mutex_destroy(&state->mutex);
-	v4l2_device_unregister_subdev(sd);
+	v4l2_async_unregister_subdev(sd);
 	return 0;
 }
 
-- 
1.9.1

