From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Sun, 07 Jun 2015 08:58:00 +0000
Subject: [PATCHv2 06/11] sh-vou: fix incorrect initial pixelformat.
Message-Id: <1433667485-35711-7-git-send-email-hverkuil@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1433667485-35711-1-git-send-email-hverkuil@xs4all.nl>
In-Reply-To: <1433667485-35711-1-git-send-email-hverkuil@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>

From: Hans Verkuil <hans.verkuil@cisco.com>

It was set to a format that wasn't supported.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/platform/sh_vou.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sh_vou.c b/drivers/media/platform/sh_vou.c
index d9a4502..262c244 100644
--- a/drivers/media/platform/sh_vou.c
+++ b/drivers/media/platform/sh_vou.c
@@ -1368,7 +1368,7 @@ static int sh_vou_probe(struct platform_device *pdev)
 	rect->height		= 480;
 	pix->width		= VOU_MAX_IMAGE_WIDTH;
 	pix->height		= 480;
-	pix->pixelformat	= V4L2_PIX_FMT_YVYU;
+	pix->pixelformat	= V4L2_PIX_FMT_NV16;
 	pix->field		= V4L2_FIELD_NONE;
 	pix->bytesperline	= VOU_MAX_IMAGE_WIDTH * 2;
 	pix->sizeimage		= VOU_MAX_IMAGE_WIDTH * 2 * 480;
-- 
2.1.4

