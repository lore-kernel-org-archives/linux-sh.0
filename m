From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 10 Jul 2015 06:36:49 +0000
Subject: [PATCH 02/16] ARM: shmobile: R-Mobile: Use BIT() macro instead of open coding
Message-Id: <23e95fc2964de5a38c1c76109188756420268858.1436509680.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1436509680.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1436509680.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 94161c9b1878..b9b494f5ca99 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -48,7 +48,7 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 	if (rmobile_pd->bit_shift = ~0)
 		return -EBUSY;
 
-	mask = 1 << rmobile_pd->bit_shift;
+	mask = BIT(rmobile_pd->bit_shift);
 	if (rmobile_pd->suspend) {
 		int ret = rmobile_pd->suspend();
 
@@ -85,7 +85,7 @@ static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd,
 	if (rmobile_pd->bit_shift = ~0)
 		return 0;
 
-	mask = 1 << rmobile_pd->bit_shift;
+	mask = BIT(rmobile_pd->bit_shift);
 	if (__raw_readl(rmobile_pd->base + PSTR) & mask)
 		goto out;
 
-- 
2.1.4

