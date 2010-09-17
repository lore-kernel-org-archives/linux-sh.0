From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 Sep 2010 10:30:11 +0000
Subject: [PATCH 4/5] ASoC: fix clkdev API usage in sh/migor.c
Message-Id: <Pine.LNX.4.64.1009171215120.4988@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

The clkdev API doesn't use .name and .id members of struct clk for clock
lookup. Instead clocks should be added to a lookup list. Without this patch
audio om the Migo-R board fails silently.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

As mentioned before - please also apply to 2.6.36.

 sound/soc/sh/migor.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index 866d78f..f462017 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -12,6 +12,7 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 
+#include <asm/clkdev.h>
 #include <asm/clock.h>
 
 #include <cpu/sh7722.h>
@@ -40,12 +41,12 @@ static struct clk_ops siumckb_clk_ops = {
 };
 
 static struct clk siumckb_clk = {
-	.name		= "siumckb_clk",
-	.id		= -1,
 	.ops		= &siumckb_clk_ops,
 	.rate		= 0, /* initialised at run-time */
 };
 
+static struct clk_lookup *siumckb_lookup;
+
 static int migor_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params)
 {
@@ -177,6 +178,13 @@ static int __init migor_init(void)
 	if (ret < 0)
 		return ret;
 
+	siumckb_lookup = clkdev_alloc(&siumckb_clk, "siumckb_clk", NULL);
+	if (!siumckb_lookup) {
+		ret = -ENOMEM;
+		goto eclkdevalloc;
+	}
+	clkdev_add(siumckb_lookup);
+
 	/* Port number used on this machine: port B */
 	migor_snd_device = platform_device_alloc("soc-audio", 1);
 	if (!migor_snd_device) {
@@ -195,12 +203,15 @@ static int __init migor_init(void)
 epdevadd:
 	platform_device_put(migor_snd_device);
 epdevalloc:
+	clkdev_drop(siumckb_lookup);
+eclkdevalloc:
 	clk_unregister(&siumckb_clk);
 	return ret;
 }
 
 static void __exit migor_exit(void)
 {
+	clkdev_drop(siumckb_lookup);
 	clk_unregister(&siumckb_clk);
 	platform_device_unregister(migor_snd_device);
 }
-- 
1.7.1

