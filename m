From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Dec 2013 02:29:52 +0000
Subject: [PATCH 19/33] ARM: shmobile: r8a7778: add HSPI clock support for DT
Message-Id: <6c334d232ab446cc6388430a019fc1072599b718.1386897180.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1386897180.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1386897180.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7778.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 011564f..5406434 100644
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
1.8.4

