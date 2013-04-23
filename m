From: Katsuya Matsubara <matsu@igel.co.jp>
Date: Tue, 23 Apr 2013 10:51:37 +0000
Subject: [PATCH 3/3] [media] sh_veu: fix the buffer size calculation
Message-Id: <1366714297-2784-4-git-send-email-matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1366714297-2784-1-git-send-email-matsu@igel.co.jp>
In-Reply-To: <1366714297-2784-1-git-send-email-matsu@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Katsuya Matsubara <matsu@igel.co.jp>

The 'bytesperline' value only indicates the stride of the Y plane
if the color format is planar, such as NV12. When calculating
the total plane size, the size of CbCr plane must also be considered.

Signed-off-by: Katsuya Matsubara <matsu@igel.co.jp>
---
 drivers/media/platform/sh_veu.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/sh_veu.c b/drivers/media/platform/sh_veu.c
index fa86c6f..358dac5 100644
--- a/drivers/media/platform/sh_veu.c
+++ b/drivers/media/platform/sh_veu.c
@@ -904,11 +904,11 @@ static int sh_veu_queue_setup(struct vb2_queue *vq,
 		if (ftmp.fmt.pix.width != pix->width ||
 		    ftmp.fmt.pix.height != pix->height)
 			return -EINVAL;
-		size = pix->bytesperline ? pix->bytesperline * pix->height :
-			pix->width * pix->height * fmt->depth >> 3;
+		size = pix->bytesperline ? pix->bytesperline * pix->height * fmt->depth / fmt->ydepth :
+			pix->width * pix->height * fmt->depth / fmt->ydepth;
 	} else {
 		vfmt = sh_veu_get_vfmt(veu, vq->type);
-		size = vfmt->bytesperline * vfmt->frame.height;
+		size = vfmt->bytesperline * vfmt->frame.height * vfmt->fmt->depth / vfmt->fmt->ydepth;
 	}
 
 	if (count < 2)
-- 
1.7.0.4

