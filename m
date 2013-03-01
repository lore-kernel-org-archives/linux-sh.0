From: Bastian Hecht <hechtb@gmail.com>
Date: Fri, 01 Mar 2013 16:52:17 +0000
Subject: [PATCH 2/3] ARM: mach-shmobile: sh73a0: Add CMT DT name to clock list
Message-Id: <1362159932-18533-3-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362159932-18533-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1362159932-18533-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This adds temporarily the alternative device name to the clock list
that is used when booting via Device Tree setup.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 71843dd..4aed113 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -575,6 +575,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP331]), /* SCIFA6 */
 	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
+	CLKDEV_DEV_ID("e6138010.cmt", &mstp_clks[MSTP329]), /* CMT10 */
 	CLKDEV_DEV_ID("sh_fsi2", &mstp_clks[MSTP328]), /* FSI */
 	CLKDEV_DEV_ID("sh_irda.0", &mstp_clks[MSTP325]), /* IrDA */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* I2C1 */
-- 
1.7.9.5

