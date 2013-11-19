From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 19 Nov 2013 09:04:35 +0000
Subject: [PATCH 2/6] ARM: shmobile: r8a7790: fixup I2C clock source
Message-Id: <877gc4ep9b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I2C clock is based on P clock, not HP clock

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index be72032..36e1a2d 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -196,10 +196,10 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
-	[MSTP931] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 31, 0), /* I2C0 */
-	[MSTP930] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 30, 0), /* I2C1 */
-	[MSTP929] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 29, 0), /* I2C2 */
-	[MSTP928] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 28, 0), /* I2C3 */
+	[MSTP931] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 31, 0), /* I2C0 */
+	[MSTP930] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 30, 0), /* I2C1 */
+	[MSTP929] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 29, 0), /* I2C2 */
+	[MSTP928] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 28, 0), /* I2C3 */
 	[MSTP917] = SH_CLK_MSTP32(&qspi_clk, SMSTPCR9, 17, 0), /* QSPI */
 	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP726] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 26, 0), /* LVDS0 */
-- 
1.7.9.5

