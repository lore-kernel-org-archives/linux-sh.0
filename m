From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 22 Feb 2011 09:57:49 +0000
Subject: [PATCH 3/3] ARM: switch mackerel to dynamically manage the platform
Message-Id: <Pine.LNX.4.64.1102221057040.1380@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1102221049240.1380@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1102221049240.1380@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Use soc_camera_platform helper functions to dynamically manage the
camera device.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-mackerel.c |   28 +++++++---------------------
 1 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 7b15d21..257355e 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -843,37 +843,23 @@ static struct soc_camera_link camera_link = {
 	.priv		= &camera_info,
 };
 
-static void dummy_release(struct device *dev)
+static struct platform_device *camera_device;
+
+static void mackerel_camera_release(struct device *dev)
 {
+	soc_camera_platform_release(&camera_device);
 }
 
-static struct platform_device camera_device = {
-	.name		= "soc_camera_platform",
-	.dev		= {
-		.platform_data	= &camera_info,
-		.release	= dummy_release,
-	},
-};
-
 static int mackerel_camera_add(struct soc_camera_link *icl,
 			       struct device *dev)
 {
-	if (icl != &camera_link)
-		return -ENODEV;
-
-	camera_info.dev = dev;
-
-	return platform_device_register(&camera_device);
+	return soc_camera_platform_add(icl, dev, &camera_device, &camera_link,
+				       mackerel_camera_release, 0);
 }
 
 static void mackerel_camera_del(struct soc_camera_link *icl)
 {
-	if (icl != &camera_link)
-		return;
-
-	platform_device_unregister(&camera_device);
-	memset(&camera_device.dev.kobj, 0,
-	       sizeof(camera_device.dev.kobj));
+	soc_camera_platform_del(icl, camera_device, &camera_link);
 }
 
 static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
-- 
1.7.2.3

