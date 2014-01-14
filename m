From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 14 Jan 2014 02:25:27 +0000
Subject: [PATCH 1/4] ARM: shmobile: r8a7778: add audio clock in new style
Message-Id: <87a9ezguzv.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehb8th3c.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehb8th3c.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current audio clock doesn't have dependency to device/driver,
but, it is not good design for DT support.
To avoid branch merge conflict issue,
it uses this load map, and this patch is 1) part.
 1) add new style clock in platform
 2) add new style clock method in driver
 3) remove old tyle clock from platform

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7778.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 9783945..2009a9b 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -221,6 +221,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("fffc6000.spi", &mstp_clks[MSTP007]), /* HSPI2 */
 	CLKDEV_DEV_ID("rcar_sound", &mstp_clks[MSTP008]), /* SRU */
 
+	CLKDEV_ICK_ID("clk_a", "rcar_sound", &audio_clk_a),
+	CLKDEV_ICK_ID("clk_b", "rcar_sound", &audio_clk_b),
+	CLKDEV_ICK_ID("clk_c", "rcar_sound", &audio_clk_c),
+	CLKDEV_ICK_ID("clk_i", "rcar_sound", &s1_clk),
 	CLKDEV_ICK_ID("ssi.0", "rcar_sound", &mstp_clks[MSTP012]),
 	CLKDEV_ICK_ID("ssi.1", "rcar_sound", &mstp_clks[MSTP011]),
 	CLKDEV_ICK_ID("ssi.2", "rcar_sound", &mstp_clks[MSTP010]),
-- 
1.7.9.5

