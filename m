From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 Jun 2010 07:22:31 +0000
Subject: [PATCH] ARM: sh-mobile: fix EXTAL1 frequency on sh7372
Message-Id: <Pine.LNX.4.64.1006250921420.1223@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

EXTAL1 is clocked at 26.0MHz

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 82d3535..26521a7 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -60,7 +60,7 @@ static struct clk r_clk = {
  * If needed, reset this with clk_set_rate() from the platform code.
  */
 struct clk sh7372_extal1_clk = {
-	.rate		= 26666666,
+	.rate		= 26000000,
 };
 
 /*
-- 
1.6.2.4

