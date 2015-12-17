From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 17 Dec 2015 08:40:23 +0000
Subject: [PATCH/RFC 45/48] v4l: vsp1: Use __vsp1_video_try_format to initialize format at init time
Message-Id: <1450341626-6695-46-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1450341626-6695-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Reuse the runtime logic to initialize the default format instead of
open-coding it. This ensures coherency between intialization and
runtime.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_video.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platform/vsp1/vsp1_video.c
index c757847110ba..a1527d622734 100644
--- a/drivers/media/platform/vsp1/vsp1_video.c
+++ b/drivers/media/platform/vsp1/vsp1_video.c
@@ -966,17 +966,10 @@ struct vsp1_video *vsp1_video_create(struct vsp1_device *vsp1,
 		return ERR_PTR(ret);
 
 	/* ... and the format ... */
-	rwpf->fmtinfo = vsp1_get_format_info(VSP1_VIDEO_DEF_FORMAT);
-	rwpf->format.pixelformat = rwpf->fmtinfo->fourcc;
-	rwpf->format.colorspace = V4L2_COLORSPACE_SRGB;
-	rwpf->format.field = V4L2_FIELD_NONE;
+	rwpf->format.pixelformat = VSP1_VIDEO_DEF_FORMAT;
 	rwpf->format.width = VSP1_VIDEO_DEF_WIDTH;
 	rwpf->format.height = VSP1_VIDEO_DEF_HEIGHT;
-	rwpf->format.num_planes = 1;
-	rwpf->format.plane_fmt[0].bytesperline -		rwpf->format.width * rwpf->fmtinfo->bpp[0] / 8;
-	rwpf->format.plane_fmt[0].sizeimage -		rwpf->format.plane_fmt[0].bytesperline * rwpf->format.height;
+	__vsp1_video_try_format(video, &rwpf->format, &rwpf->fmtinfo);
 
 	/* ... and the video node... */
 	video->video.v4l2_dev = &video->vsp1->v4l2_dev;
-- 
2.4.10

