From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 02 Dec 2013 02:19:33 +0000
Subject: [PATCH 27/28] ARM: shmobile: r8a7790: fixup I2C clock source
Message-Id: <420382f4eea728d4104c28275aa9594f1d6dbf0c.1385950394.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1385950394.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1385950394.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

I2C clock is based on P clock, not HP clock

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index ecec746..3a267c2 100644
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
1.8.4

