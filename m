From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Dec 2013 02:29:43 +0000
Subject: [PATCH 10/33] ARM: shmobile: r8a7778: add SDHI clock support for DT
Message-Id: <67c01c3e0ff8d2e8d16e20574ad9a8342df58924.1386897180.git.horms+renesas@verge.net.au>
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
index e043715..011564f 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -175,8 +175,11 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mmcif", &mstp_clks[MSTP331]), /* MMC */
 	CLKDEV_DEV_ID("ffe4e000.mmcif", &mstp_clks[MSTP331]), /* MMC */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
+	CLKDEV_DEV_ID("ffe4c000.sdhi", &mstp_clks[MSTP323]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
+	CLKDEV_DEV_ID("ffe4d000.sdhi", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
+	CLKDEV_DEV_ID("ffe4f000.sdhi", &mstp_clks[MSTP321]), /* SDHI2 */
 	CLKDEV_DEV_ID("r8a777x-ether", &mstp_clks[MSTP114]), /* Ether */
 	CLKDEV_DEV_ID("r8a7778-vin.0", &mstp_clks[MSTP110]), /* VIN0 */
 	CLKDEV_DEV_ID("r8a7778-vin.1", &mstp_clks[MSTP109]), /* VIN1 */
-- 
1.8.4

