From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 19 Oct 2015 14:07:37 +0000
Subject: [PATCH/RFT 4/7] media: soc_camera: soc_scale_crop: Use correct pad number in try_fmt
Message-Id: <1445263660-6945-5-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Rob Taylor <rob.taylor@codethink.co.uk>

Fix calls to subdev try_fmt function to use valid pad numbers, fixing
the case where subdevs (eg. ADV7612) have valid pad numbers that are
non-zero.

Signed-off-by: William Towle <william.towle@codethink.co.uk>
Reviewed-by: Rob Taylor <rob.taylor@codethink.co.uk>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/platform/soc_camera/soc_scale_crop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/soc_camera/soc_scale_crop.c b/drivers/media/platform/soc_camera/soc_scale_crop.c
index bda29bc..2772215 100644
--- a/drivers/media/platform/soc_camera/soc_scale_crop.c
+++ b/drivers/media/platform/soc_camera/soc_scale_crop.c
@@ -225,6 +225,7 @@ static int client_set_fmt(struct soc_camera_device *icd,
 	bool host_1to1;
 	int ret;
 
+	format->pad = icd->src_pad_idx;
 	ret = v4l2_device_call_until_err(sd->v4l2_dev,
 					 soc_camera_grp_id(icd), pad,
 					 set_fmt, NULL, format);
-- 
2.6.1

