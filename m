From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 24 Jul 2012 14:40:18 +0000
Subject: [PATCH v2 1/6] ARM: mach-shmobile: clock-r8a7740: add TPU PWM support
Message-Id: <1343140823-13754-2-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 7b9e4ab..1e5b5f0 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -467,7 +467,7 @@ enum {
 
 	MSTP329, MSTP328, MSTP323, MSTP320,
 	MSTP314, MSTP313, MSTP312,
-	MSTP309,
+	MSTP309, MSTP304,
 
 	MSTP416, MSTP415, MSTP407, MSTP406,
 
@@ -501,6 +501,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP313] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 13, 0), /* SDHI1 */
 	[MSTP312] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 12, 0), /* MMC */
 	[MSTP309] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3,  9, 0), /* GEther */
+	[MSTP304] = SH_CLK_MSTP32(&div4_clks[DIV4_CP],	SMSTPCR3,  4, 0), /* TPU0 */
 
 	[MSTP416] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 16, 0), /* USBHOST */
 	[MSTP415] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 15, 0), /* SDHI2 */
@@ -576,6 +577,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mmcif",		&mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("sh-eth",			&mstp_clks[MSTP309]),
 
+	CLKDEV_DEV_ID("rmob_tpu_pwm.0",		&mstp_clks[MSTP304]),
+
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
 
 	/* ICK */
-- 
1.7.8.6

