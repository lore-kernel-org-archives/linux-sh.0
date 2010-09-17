From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 Sep 2010 10:30:05 +0000
Subject: [PATCH 3/5] ASoC: lowercase wm8978 codec name to match its only user
Message-Id: <Pine.LNX.4.64.1009171214281.4988@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

All ASoC codecs are called in lower case, adjust wm8978 to match them and also
to match its so far only user - the sh7722 migor board.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 sound/soc/codecs/wm8978.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 676a430..a521678 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -1038,7 +1038,7 @@ MODULE_DEVICE_TABLE(i2c, wm8978_i2c_id);
 
 static struct i2c_driver wm8978_i2c_driver = {
 	.driver = {
-		.name = "WM8978-codec",
+		.name = "wm8978-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe =    wm8978_i2c_probe,
-- 
1.7.1

