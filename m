From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Apr 2011 08:13:22 +0000
Subject: [PATCH] ARM: mach-shmobile: clock-sh7372: remove status check from
Message-Id: <w3pbp091c9p.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

clock status check is not needed in recalc function.
clk->rate will be 0 in clk_set_rate without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index e9731b5..6c79b40 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -421,9 +421,6 @@ static unsigned long fsidiv_recalc(struct clk *clk)
 
 	value = __raw_readl(clk->mapping->base);
 
-	if ((value & 0x3) != 0x3)
-		return 0;
-
 	value >>= 16;
 	if (value < 2)
 		return 0;
-- 
1.7.1

