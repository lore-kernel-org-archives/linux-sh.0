From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 03 Sep 2015 23:14:35 +0000
Subject: [PATCH 1/3] adv7180: implement g_std() method
Message-Id: <55445603.CDVZru8CKl@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6015647.cjLjRfTWc7@wasted.cogentembedded.com>
In-Reply-To: <6015647.cjLjRfTWc7@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mchehab@osg.samsung.com, linux-media@vger.kernel.org, lars@metafoo.de
Cc: linux-sh@vger.kernel.org

Commit cccb83f7a184 ([media] adv7180: add more subdev video ops) forgot to add
the g_std() video method. Its implementation seems identical to the querystd()
method,  so we  can just  point at adv7180_querystd()...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/media/i2c/adv7180.c |    1 +
 1 file changed, 1 insertion(+)

Index: media_tree/drivers/media/i2c/adv7180.c
=================================--- media_tree.orig/drivers/media/i2c/adv7180.c
+++ media_tree/drivers/media/i2c/adv7180.c
@@ -717,6 +717,7 @@ static int adv7180_g_mbus_config(struct
 }
 
 static const struct v4l2_subdev_video_ops adv7180_video_ops = {
+	.g_std = adv7180_querystd,
 	.s_std = adv7180_s_std,
 	.querystd = adv7180_querystd,
 	.g_input_status = adv7180_g_input_status,

