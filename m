From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 09 Sep 2011 17:14:10 +0000
Subject: [PATCH] V4L: sh_mobile_csi2: fix unbalanced pm_runtime_put()
Message-Id: <Pine.LNX.4.64.1109091910230.915@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: linux-sh@vger.kernel.org

If the sh_mobile_csi2 driver didn't attach to a client, normally, because
the respective device connects to the SoC over the parallel CEU interface
and doesn't use the CSI-2 controller, it also shouldn't call
pm_runtime_put() on attempted disconnect.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

If it also applies to the current Linus' tree, it could be a good idea to 
push it to 3.1. But in practice it's not a very serious bug, it would only 
affect systems with a serial / CSI-2 _and_ a parallel cameras connected 
simultaneously to one CEU interface, where the user switches between them 
at runtime. In any case it should be trivial to backport it to 3.1.

 drivers/media/video/sh_mobile_csi2.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/sh_mobile_csi2.c b/drivers/media/video/sh_mobile_csi2.c
index 91c680a..37706eb 100644
--- a/drivers/media/video/sh_mobile_csi2.c
+++ b/drivers/media/video/sh_mobile_csi2.c
@@ -208,6 +208,9 @@ static int sh_csi2_client_connect(struct sh_csi2 *priv)
 	unsigned long common_flags, csi2_flags;
 	int i, ret;
 
+	if (priv->client)
+		return -EBUSY;
+
 	for (i = 0; i < pdata->num_clients; i++)
 		if (&pdata->clients[i].pdev->dev = icd->pdev)
 			break;
@@ -262,6 +265,9 @@ static int sh_csi2_client_connect(struct sh_csi2 *priv)
 
 static void sh_csi2_client_disconnect(struct sh_csi2 *priv)
 {
+	if (!priv->client)
+		return;
+
 	priv->client = NULL;
 
 	pm_runtime_put(v4l2_get_subdevdata(&priv->subdev));
-- 
1.7.2.5

