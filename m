From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 22 Feb 2011 09:57:40 +0000
Subject: [PATCH 1/3] V4L: soc_camera_platform: add helper functions to manage
Message-Id: <Pine.LNX.4.64.1102221056110.1380@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1102221049240.1380@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1102221049240.1380@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add helper inline functions to correctly manage dynamic allocation and
freeing of platform devices. This avoids the ugly code to nullify
device objects.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/media/soc_camera_platform.h |   49 +++++++++++++++++++++++++++++++++++
 1 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/include/media/soc_camera_platform.h b/include/media/soc_camera_platform.h
index 0ecefe2..fbf4b79 100644
--- a/include/media/soc_camera_platform.h
+++ b/include/media/soc_camera_platform.h
@@ -25,4 +25,53 @@ struct soc_camera_platform_info {
 	int (*set_capture)(struct soc_camera_platform_info *info, int enable);
 };
 
+static inline void soc_camera_platform_release(struct platform_device **pdev)
+{
+	*pdev = NULL;
+}
+
+static inline int soc_camera_platform_add(const struct soc_camera_link *icl,
+					  struct device *dev,
+					  struct platform_device **pdev,
+					  struct soc_camera_link *plink,
+					  void (*release)(struct device *dev),
+					  int id)
+{
+	struct soc_camera_platform_info *info = plink->priv;
+	int ret;
+
+	if (icl != plink)
+		return -ENODEV;
+
+	if (*pdev)
+		return -EBUSY;
+
+	*pdev = platform_device_alloc("soc_camera_platform", id);
+	if (!*pdev)
+		return -ENOMEM;
+
+	(*pdev)->dev.platform_data = info;
+	(*pdev)->dev.release = release;
+
+	ret = platform_device_add(*pdev);
+	if (ret < 0) {
+		platform_device_put(*pdev);
+		*pdev = NULL;
+	} else {
+		info->dev = dev;
+	}
+
+	return 0;
+}
+
+static inline void soc_camera_platform_del(const struct soc_camera_link *icl,
+					   struct platform_device *pdev,
+					   const struct soc_camera_link *plink)
+{
+	if (icl != plink || !pdev)
+		return;
+
+	platform_device_unregister(pdev);
+}
+
 #endif /* __SOC_CAMERA_H__ */
-- 
1.7.2.3

