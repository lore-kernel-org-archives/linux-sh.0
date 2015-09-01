From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 01 Sep 2015 22:29:01 +0000
Subject: [PATCH v2] rcar_vin: propagate querystd() error upstream
Message-Id: <2328024.JIhFUGC0u1@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: g.liakhovetski@gmx.de, mchehab@osg.samsung.com, linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

rcar_vin_set_fmt() defaults to  PAL when the subdevice's querystd() method call
fails (e.g. due to I2C error).  This doesn't work very well when a camera being
used  outputs NTSC which has different order of fields and resolution.  Let  us
stop  pretending and return the actual error except  when the querystd() method
is not implemented,  in which case  we'll have  to set the 'field' variable  to
V4L2_FIELD_NONE.

Note that doing this would prevent video capture on at least Renesas Henninger/
Porter boards where I2C seems particularly buggy.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'media_tree.git' repo's 'fixes' branch.

Changes in version 2:
- filter out -ENOIOCTLCMD error code and default 'field' to V4L2_FIELD_NONE in
  that case.

 drivers/media/platform/soc_camera/rcar_vin.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

Index: media_tree/drivers/media/platform/soc_camera/rcar_vin.c
=================================--- media_tree.orig/drivers/media/platform/soc_camera/rcar_vin.c
+++ media_tree/drivers/media/platform/soc_camera/rcar_vin.c
@@ -1591,11 +1591,15 @@ static int rcar_vin_set_fmt(struct soc_c
 	case V4L2_FIELD_INTERLACED:
 		/* Query for standard if not explicitly mentioned _TB/_BT */
 		ret = v4l2_subdev_call(sd, video, querystd, &std);
-		if (ret < 0)
-			std = V4L2_STD_625_50;
-
-		field = std & V4L2_STD_625_50 ? V4L2_FIELD_INTERLACED_TB :
-						V4L2_FIELD_INTERLACED_BT;
+		if (ret = -ENOIOCTLCMD) {
+			field = V4L2_FIELD_NONE;
+		} else if (ret < 0) {
+			return ret;
+		} else {
+			field = std & V4L2_STD_625_50 ?
+				V4L2_FIELD_INTERLACED_TB :
+				V4L2_FIELD_INTERLACED_BT;
+		}
 		break;
 	}
 

