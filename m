From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 14 Apr 2014 00:56:50 +0000
Subject: [PATCH 2/7] ARM: shmobile: r8a7790: remove old style audio clock
Message-Id: <87ppkk20fj.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sipg20h1.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87sipg20h1.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, broonie@kernel.org
Cc: Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current sound driver moves to new style clock,
but is keeping compatiblity at this point.
Move to new style on r8a7790

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 3f93503..5f4b6c4 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -294,10 +294,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 static struct clk_lookup lookups[] = {
 
 	/* main clocks */
-	CLKDEV_CON_ID("audio_clk_a",	&audio_clk_a),
-	CLKDEV_CON_ID("audio_clk_b",	&audio_clk_b),
-	CLKDEV_CON_ID("audio_clk_c",	&audio_clk_c),
-	CLKDEV_CON_ID("audio_clk_internal",	&m2_clk),
 	CLKDEV_CON_ID("extal",		&extal_clk),
 	CLKDEV_CON_ID("extal_div2",	&extal_div2_clk),
 	CLKDEV_CON_ID("main",		&main_clk),
@@ -381,16 +377,16 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("clk_b", "rcar_sound", &audio_clk_b),
 	CLKDEV_ICK_ID("clk_c", "rcar_sound", &audio_clk_c),
 	CLKDEV_ICK_ID("clk_i", "rcar_sound", &m2_clk),
-	CLKDEV_ICK_ID("scu.0", "rcar_sound", &mstp_clks[MSTP1031]),
-	CLKDEV_ICK_ID("scu.1", "rcar_sound", &mstp_clks[MSTP1030]),
-	CLKDEV_ICK_ID("scu.2", "rcar_sound", &mstp_clks[MSTP1029]),
-	CLKDEV_ICK_ID("scu.3", "rcar_sound", &mstp_clks[MSTP1028]),
-	CLKDEV_ICK_ID("scu.4", "rcar_sound", &mstp_clks[MSTP1027]),
-	CLKDEV_ICK_ID("scu.5", "rcar_sound", &mstp_clks[MSTP1026]),
-	CLKDEV_ICK_ID("scu.6", "rcar_sound", &mstp_clks[MSTP1025]),
-	CLKDEV_ICK_ID("scu.7", "rcar_sound", &mstp_clks[MSTP1024]),
-	CLKDEV_ICK_ID("scu.8", "rcar_sound", &mstp_clks[MSTP1023]),
-	CLKDEV_ICK_ID("scu.9", "rcar_sound", &mstp_clks[MSTP1022]),
+	CLKDEV_ICK_ID("src.0", "rcar_sound", &mstp_clks[MSTP1031]),
+	CLKDEV_ICK_ID("src.1", "rcar_sound", &mstp_clks[MSTP1030]),
+	CLKDEV_ICK_ID("src.2", "rcar_sound", &mstp_clks[MSTP1029]),
+	CLKDEV_ICK_ID("src.3", "rcar_sound", &mstp_clks[MSTP1028]),
+	CLKDEV_ICK_ID("src.4", "rcar_sound", &mstp_clks[MSTP1027]),
+	CLKDEV_ICK_ID("src.5", "rcar_sound", &mstp_clks[MSTP1026]),
+	CLKDEV_ICK_ID("src.6", "rcar_sound", &mstp_clks[MSTP1025]),
+	CLKDEV_ICK_ID("src.7", "rcar_sound", &mstp_clks[MSTP1024]),
+	CLKDEV_ICK_ID("src.8", "rcar_sound", &mstp_clks[MSTP1023]),
+	CLKDEV_ICK_ID("src.9", "rcar_sound", &mstp_clks[MSTP1022]),
 	CLKDEV_ICK_ID("ssi.0", "rcar_sound", &mstp_clks[MSTP1015]),
 	CLKDEV_ICK_ID("ssi.1", "rcar_sound", &mstp_clks[MSTP1014]),
 	CLKDEV_ICK_ID("ssi.2", "rcar_sound", &mstp_clks[MSTP1013]),
-- 
1.7.9.5

