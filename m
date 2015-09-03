From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 03 Sep 2015 23:18:05 +0000
Subject: [PATCH 3/3] rcar_vin: call g_std() instead of querystd()
Message-Id: <2719391.j5OZOaG8ai@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6015647.cjLjRfTWc7@wasted.cogentembedded.com>
In-Reply-To: <6015647.cjLjRfTWc7@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: g.liakhovetski@gmx.de, mchehab@osg.samsung.com, linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hans Verkuil says: "The only place querystd can be called  is in the QUERYSTD
ioctl, all other ioctls should use the last set standard." So call the g_std()
subdevice method instead of querystd() in the driver's set_fmt() method.

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/media/platform/soc_camera/rcar_vin.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: media_tree/drivers/media/platform/soc_camera/rcar_vin.c
=================================--- media_tree.orig/drivers/media/platform/soc_camera/rcar_vin.c
+++ media_tree/drivers/media/platform/soc_camera/rcar_vin.c
@@ -1589,8 +1589,8 @@ static int rcar_vin_set_fmt(struct soc_c
 		field = pix->field;
 		break;
 	case V4L2_FIELD_INTERLACED:
-		/* Query for standard if not explicitly mentioned _TB/_BT */
-		ret = v4l2_subdev_call(sd, video, querystd, &std);
+		/* Get the last standard if not explicitly mentioned _TB/_BT */
+		ret = v4l2_subdev_call(sd, video, g_std, &std);
 		if (ret = -ENOIOCTLCMD) {
 			field = V4L2_FIELD_NONE;
 		} else if (ret < 0) {

