From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 14 Apr 2014 00:56:57 +0000
Subject: [PATCH 3/7] ARM: shmobile: bockw: remove old style audio clock
Message-Id: <87ob0420fc.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sipg20h1.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87sipg20h1.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, broonie@kernel.org
Cc: Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current audio clock didn't have dependency to device/driver,
but, it was not good design for DT support.
To avoid branch merge conflict issue,
it is using this load map, and this patch is 3) part.
 1) add new style clock in platform
 2) add new style clock method in driver
 3) remove old tyle clock from platform

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index b4122f8..1aca107 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -591,6 +591,7 @@ static void __init bockw_init(void)
 {
 	void __iomem *base;
 	struct clk *clk;
+	struct platform_device *pdev;
 	int i;
 
 	r8a7778_clock_init();
@@ -673,9 +674,6 @@ static void __init bockw_init(void)
 	}
 
 	/* for Audio */
-	clk = clk_get(NULL, "audio_clk_b");
-	clk_set_rate(clk, 24576000);
-	clk_put(clk);
 	rsnd_codec_power(5, 1); /* enable ak4642 */
 
 	platform_device_register_simple(
@@ -684,11 +682,15 @@ static void __init bockw_init(void)
 	platform_device_register_simple(
 		"ak4554-adc-dac", 1, NULL, 0);
 
-	platform_device_register_resndata(
+	pdev = platform_device_register_resndata(
 		&platform_bus, "rcar_sound", -1,
 		rsnd_resources, ARRAY_SIZE(rsnd_resources),
 		&rsnd_info, sizeof(rsnd_info));
 
+	clk = clk_get(&pdev->dev, "clk_b");
+	clk_set_rate(clk, 24576000);
+	clk_put(clk);
+
 	for (i = 0; i < ARRAY_SIZE(rsnd_card_info); i++) {
 		struct platform_device_info cardinfo = {
 			.parent         = &platform_bus,
-- 
1.7.9.5

