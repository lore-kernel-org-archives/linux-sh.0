From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 19 Nov 2010 07:23:26 +0000
Subject: [PATCH 4/6] ARM: mach-shmobile: clock-sh7372: modify error code
Message-Id: <w3p7hg94w0i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 4191e29..41663e0 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -454,7 +454,7 @@ static int fsidiv_enable(struct clk *clk)
 
 	value  = __raw_readl(clk->mapping->base) >> 16;
 	if (value < 2)
-		return -ENOENT;
+		return -EIO;
 
 	__raw_writel((value << 16) | 0x3, clk->mapping->base);
 
@@ -468,7 +468,7 @@ static int fsidiv_set_rate(struct clk *clk,
 
 	idx = (clk->parent->rate / rate) & 0xffff;
 	if (idx < 2)
-		return -ENOENT;
+		return -EINVAL;
 
 	__raw_writel(idx << 16, clk->mapping->base);
 	return 0;
-- 
1.7.0.4

