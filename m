From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Fri, 05 Jun 2015 10:59:18 +0000
Subject: [PATCH 02/10] sh-vou: fix querycap support
Message-Id: <1433501966-30176-3-git-send-email-hverkuil@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1433501966-30176-1-git-send-email-hverkuil@xs4all.nl>
In-Reply-To: <1433501966-30176-1-git-send-email-hverkuil@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>

From: Hans Verkuil <hans.verkuil@cisco.com>

Fix v4l2-compliance errors due to empty driver and bus_info fields.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/platform/sh_vou.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/sh_vou.c b/drivers/media/platform/sh_vou.c
index 9e98233..ba1a16c 100644
--- a/drivers/media/platform/sh_vou.c
+++ b/drivers/media/platform/sh_vou.c
@@ -398,6 +398,8 @@ static int sh_vou_querycap(struct file *file, void  *priv,
 	dev_dbg(vou_dev->v4l2_dev.dev, "%s()\n", __func__);
 
 	strlcpy(cap->card, "SuperH VOU", sizeof(cap->card));
+	strlcpy(cap->driver, "sh-vou", sizeof(cap->driver));
+	strlcpy(cap->bus_info, "platform:sh-vou", sizeof(cap->bus_info));
 	cap->device_caps = V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_STREAMING;
 	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
 	return 0;
-- 
2.1.4

