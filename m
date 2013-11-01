From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 01 Nov 2013 01:22:39 +0000
Subject: [PATCH 2/3] ARM: shmobile: r8a7778: add HSPI clock support for DT
Message-Id: <87zjpoykyr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365142324-7286-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1365142324-7286-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7778.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 3c25282..4b601bf 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -203,8 +203,11 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
 	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP015]), /* TMU01 */
 	CLKDEV_DEV_ID("sh-hspi.0", &mstp_clks[MSTP007]), /* HSPI0 */
+	CLKDEV_DEV_ID("fffc7000.spi", &mstp_clks[MSTP007]), /* HSPI0 */
 	CLKDEV_DEV_ID("sh-hspi.1", &mstp_clks[MSTP007]), /* HSPI1 */
+	CLKDEV_DEV_ID("fffc8000.spi", &mstp_clks[MSTP007]), /* HSPI1 */
 	CLKDEV_DEV_ID("sh-hspi.2", &mstp_clks[MSTP007]), /* HSPI2 */
+	CLKDEV_DEV_ID("fffc6000.spi", &mstp_clks[MSTP007]), /* HSPI2 */
 	CLKDEV_DEV_ID("rcar_sound", &mstp_clks[MSTP008]), /* SRU */
 
 	CLKDEV_ICK_ID("ssi.0", "rcar_sound", &mstp_clks[MSTP012]),
-- 
1.7.9.5

