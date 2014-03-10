From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 10 Mar 2014 08:36:45 +0000
Subject: [PATCH] ARM: shmobile: r7s72100: fix bus clock calculation
Message-Id: <d93023f81d2c79595e64e4f516f03af4e4c73c13.1394440226.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1394440226.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1394440226.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

The picture in the datasheet is a little misleading, yet the divider of
the bus_clk is 1/3 and not 2/3.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index f17a5db..bee0073 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -70,7 +70,7 @@ static struct clk pll_clk = {
 
 static unsigned long bus_recalc(struct clk *clk)
 {
-	return clk->parent->rate * 2 / 3;
+	return clk->parent->rate / 3;
 }
 
 static struct sh_clk_ops bus_clk_ops = {
-- 
1.8.5.2

