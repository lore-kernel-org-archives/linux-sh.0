From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 22 Aug 2013 17:56:56 +0000
Subject: [PATCH 1/2] v4l: vsp1: Initialize media device bus_info field
Message-Id: <1377194217-24235-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377194217-24235-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1377194217-24235-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Fill bus_info with the VSP1 platform device name

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/vsp1/vsp1_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index 8700842..291d20f 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -134,6 +134,8 @@ static int vsp1_create_entities(struct vsp1_device *vsp1)
 
 	mdev->dev = vsp1->dev;
 	strlcpy(mdev->model, "VSP1", sizeof(mdev->model));
+	snprintf(mdev->bus_info, sizeof(mdev->bus_info), "platform:%s",
+		 dev_name(mdev->dev));
 	ret = media_device_register(mdev);
 	if (ret < 0) {
 		dev_err(vsp1->dev, "media device registration failed (%d)\n",
-- 
1.8.1.5

