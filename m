From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Apr 2014 22:44:59 +0000
Subject: [PATCH 10/14] ARM: shmobile: bockw: remove old style audio clock
Message-Id: <115897dab004f580fc8b4c6bab057940ccb64989.1397774191.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397774190.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397774190.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current audio clock didn't have dependency to device/driver,
but, it was not good design for DT support.
To avoid branch merge conflict issue,
it is using this load map, and this patch is 3) part.
 1) add new style clock in platform
 2) add new style clock method in driver
 3) remove old tyle clock from platform

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-bockw.c | 10 ++++++----
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
1.8.4

