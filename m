From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 27 Sep 2012 14:07:28 +0000
Subject: [PATCH 09/14] media: mt9t112: support deferred probing
Message-Id: <1348754853-28619-10-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>

If .probe() is called without our private data, this might mean, that the
host driver hasn't probed yet. Defer probing in this case.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/media/i2c/soc_camera/mt9t112.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/media/i2c/soc_camera/mt9t112.c b/drivers/media/i2c/soc_camera/mt9t112.c
index dfa03f0..9e0837c 100644
--- a/drivers/media/i2c/soc_camera/mt9t112.c
+++ b/drivers/media/i2c/soc_camera/mt9t112.c
@@ -1094,7 +1094,10 @@ static int mt9t112_probe(struct i2c_client *client,
 	};
 	int ret;
 
-	if (!icl || !icl->priv) {
+	if (!icl)
+		return -EPROBE_DEFER;
+
+	if (!icl->priv) {
 		dev_err(&client->dev, "mt9t112: missing platform data!\n");
 		return -EINVAL;
 	}
-- 
1.7.2.5

