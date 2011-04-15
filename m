From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Apr 2011 18:17:34 +0000
Subject: [PATCH] ALSA: add a module alias to the FSI driver
Message-Id: <Pine.LNX.4.64.1104152015190.18593@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>

This patch enables FSI driver autoloading on sh-mobile systems.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 sound/soc/sh/fsi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 0c9997e..88b669c 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1321,3 +1321,4 @@ module_exit(fsi_mobile_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SuperH onchip FSI audio driver");
 MODULE_AUTHOR("Kuninori Morimoto <morimoto.kuninori@renesas.com>");
+MODULE_ALIAS("platform:fsi-pcm-audio");
-- 
1.7.2.5

