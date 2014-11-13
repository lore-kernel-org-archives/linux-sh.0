From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Nov 2014 01:19:55 +0000
Subject: [PATCH 3/3] ARM: shmobile: r8a7740 legacy: Correct IIC0 parent clock
Message-Id: <4f37828d4d69a46830e0525a065da9847fc7a819.1415757100.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415757100.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415757100.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

According to the datasheet, the operating clock for IIC0 is the HPP
(RT Peri) clock, not the SUB (Peri) clock. Both clocks run at the same
speed (50 Mhz).

This is consistent with IIC0 being located in the A4R PM domain, and
IIC1 in the A3SP PM domain.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 16a6b7c..19df9cb 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -474,7 +474,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP127] = SH_CLK_MSTP32(&div4_clks[DIV4_S],	SMSTPCR1, 27, 0), /* CEU20 */
 	[MSTP125] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR1, 25, 0), /* TMU0 */
 	[MSTP117] = SH_CLK_MSTP32(&div4_clks[DIV4_B],	SMSTPCR1, 17, 0), /* LCDC1 */
-	[MSTP116] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR1, 16, 0), /* IIC0 */
+	[MSTP116] = SH_CLK_MSTP32(&div4_clks[DIV4_HPP],	SMSTPCR1, 16, 0), /* IIC0 */
 	[MSTP111] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR1, 11, 0), /* TMU1 */
 	[MSTP100] = SH_CLK_MSTP32(&div4_clks[DIV4_B],	SMSTPCR1,  0, 0), /* LCDC0 */
 
-- 
2.1.1

