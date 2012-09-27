From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 27 Sep 2012 14:07:32 +0000
Subject: [PATCH 13/14] media: sh-mobile-ceu-driver: support max width and height in DT
Message-Id: <1348754853-28619-14-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>

Some CEU implementations have non-standard (larger) maximum supported
width and height values. Add two OF properties to specify them.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 .../platform/soc_camera/sh_mobile_ceu_camera.c     |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c b/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
index 61ee459..1fd03f6 100644
--- a/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
+++ b/drivers/media/platform/soc_camera/sh_mobile_ceu_camera.c
@@ -2119,6 +2119,25 @@ static int __devinit sh_mobile_ceu_probe(struct platform_device *pdev)
 		pcdev->flags = pcdev->pdata->flags;
 	}
 
+	if (!pcdev->max_width) {
+		unsigned int v;
+		err = of_property_read_u32(pdev->dev.of_node, "renesas,max-width", &v);
+		if (!err)
+			pcdev->max_width = v;
+
+		if (!pcdev->max_width)
+			pcdev->max_width = 2560;
+	}
+	if (!pcdev->max_height) {
+		unsigned int v;
+		err = of_property_read_u32(pdev->dev.of_node, "renesas,max-height", &v);
+		if (!err)
+			pcdev->max_height = v;
+
+		if (!pcdev->max_height)
+			pcdev->max_height = 1920;
+	}
+
 	base = ioremap_nocache(res->start, resource_size(res));
 	if (!base) {
 		err = -ENXIO;
-- 
1.7.2.5

