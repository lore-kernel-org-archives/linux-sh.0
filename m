From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 17 Aug 2010 22:53:58 +0000
Subject: [PATCH/RFC] ARM: mach-shmobile: do not enable the PLLC2 clock on
Message-Id: <Pine.LNX.4.64.1008180052080.14651@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

AP4EVB has to reparent PLLC2 to provide a precise HDMI clock, this is only
possible, if PLLC2 hasn't been enabled yet. Since no other driver currently
uses PLLC2 we can safely remove the CLK_ENABLE_ON_INIT flag. This fixes 
the "Cannot set PLLC2 parent: -16, 1 users" error message, when trying to 
use HDMI on AP4EVB.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index dcaac1b..7594689 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -286,7 +286,6 @@ static struct clk_ops pllc2_clk_ops = {
 
 struct clk pllc2_clk = {
 	.ops		= &pllc2_clk_ops,
-	.flags		= CLK_ENABLE_ON_INIT,
 	.parent		= &extal1_div2_clk,
 	.freq_table	= pllc2_freq_table,
 	.parent_table	= pllc2_parent,
-- 
1.7.2

