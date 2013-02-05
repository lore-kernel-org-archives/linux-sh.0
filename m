From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 05 Feb 2013 03:47:42 +0000
Subject: [PATCH] ARM: shmobile: r8a7779: Correct TMU clock support
Message-Id: <1360036062-3490-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360036062-3490-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1360036062-3490-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

During code review it was noticed that the clock value for
TMU01 was incorrect and the value for TMU02 was missing.

For reference: As of 3.8-rc6 there are no in-tree consumes of these clocks.

Reported-by: Denis Oliver Kropp <dok@directfb.org>
Reviewed-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index c019609..202370d 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -161,7 +161,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
 	CLKDEV_DEV_ID("ohci-platform.0", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
 	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
-	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP016]), /* TMU01 */
+	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP015]), /* TMU01 */
+	CLKDEV_DEV_ID("sh_tmu.2", &mstp_clks[MSTP014]), /* TMU02 */
 	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
 	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP029]), /* I2C1 */
 	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP028]), /* I2C2 */
-- 
1.7.10.4

