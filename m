From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 27 Sep 2012 14:07:27 +0000
Subject: [PATCH 08/14] media: soc-camera: use managed devm_regulator_bulk_get()
Message-Id: <1348754853-28619-9-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>

Using device-managed devm_regulator_bulk_get() eliminates the need to
release regulators explicitly.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/media/platform/soc_camera/soc_camera.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/soc_camera/soc_camera.c b/drivers/media/platform/soc_camera/soc_camera.c
index 997be15..c2a5fa3 100644
--- a/drivers/media/platform/soc_camera/soc_camera.c
+++ b/drivers/media/platform/soc_camera/soc_camera.c
@@ -1249,7 +1249,6 @@ static int soc_camera_i2c_notify(struct notifier_block *nb,
 		video_device_release(icd->vdev);
 		icd->vdev = NULL;
 	}
-	regulator_bulk_free(icl->num_regulators, icl->regulators);
 	v4l2_ctrl_handler_free(&icd->ctrl_handler);
 
 	return NOTIFY_DONE;
@@ -1358,8 +1357,8 @@ static int soc_camera_probe(struct soc_camera_device *icd)
 	if (ret < 0)
 		return ret;
 
-	ret = regulator_bulk_get(icd->pdev, icl->num_regulators,
-				 icl->regulators);
+	ret = devm_regulator_bulk_get(icd->pdev, icl->num_regulators,
+				      icl->regulators);
 	if (ret < 0)
 		goto ereg;
 
@@ -1423,7 +1422,6 @@ eadddev:
 		icd->vdev = NULL;
 	}
 evdc:
-	regulator_bulk_free(icl->num_regulators, icl->regulators);
 ereg:
 	v4l2_ctrl_handler_free(&icd->ctrl_handler);
 	return ret;
@@ -1460,8 +1458,6 @@ static int soc_camera_remove(struct soc_camera_device *icd)
 	}
 	soc_camera_free_user_formats(icd);
 
-	regulator_bulk_free(icl->num_regulators, icl->regulators);
-
 	return 0;
 }
 
-- 
1.7.2.5

