From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 19 Nov 2010 07:22:58 +0000
Subject: [PATCH 1/6] ARM: mach-shmobile: clock-sh7372: remove fsidiv bogus
Message-Id: <w3pbp5l4w1a.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current FSIDIV clock framework had bogus disable.
This patch remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 7db31e6..1322632 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -453,10 +453,8 @@ static int fsidiv_enable(struct clk *clk)
 	unsigned long value;
 
 	value  = __raw_readl(clk->mapping->base) >> 16;
-	if (value < 2) {
-		fsidiv_disable(clk);
+	if (value < 2)
 		return -ENOENT;
-	}
 
 	__raw_writel((value << 16) | 0x3, clk->mapping->base);
 
@@ -468,11 +466,6 @@ static int fsidiv_set_rate(struct clk *clk,
 {
 	int idx;
 
-	if (clk->parent->rate = rate) {
-		fsidiv_disable(clk);
-		return 0;
-	}
-
 	idx = (clk->parent->rate / rate) & 0xffff;
 	if (idx < 2)
 		return -ENOENT;
-- 
1.7.0.4

