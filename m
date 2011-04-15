From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Apr 2011 18:10:07 +0000
Subject: [PATCH] ARM: mach-shmobile: fix Oops during system wake up
Message-Id: <Pine.LNX.4.64.1104152009080.18593@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

During system resume the clock subsystem is restoring all clock rates,
if sound has not been used before suspend, the rate remains 0 and
the wake up Oopses with division by zero.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index e9731b5..fb29d89 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -458,6 +458,9 @@ static int fsidiv_set_rate(struct clk *clk, unsigned long rate)
 {
 	int idx;
 
+	if (!rate)
+		return -EDOM;
+
 	idx = (clk->parent->rate / rate) & 0xffff;
 	if (idx < 2)
 		return -EINVAL;
-- 
1.7.2.5

