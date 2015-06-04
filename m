From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:22:26 +0000
Subject: [PATCH 02/11] ARM: shmobile: R-Mobile: Use BIT() macro instead of open coding
Message-Id: <1433442155-19492-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index 5003602921a18dd0..0dea936bc9df88a2 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -52,7 +52,7 @@ static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 	if (rmobile_pd->bit_shift = ~0)
 		return -EBUSY;
 
-	mask = 1 << rmobile_pd->bit_shift;
+	mask = BIT(rmobile_pd->bit_shift);
 	if (rmobile_pd->suspend) {
 		int ret = rmobile_pd->suspend();
 
@@ -89,7 +89,7 @@ static int __rmobile_pd_power_up(struct rmobile_pm_domain *rmobile_pd,
 	if (rmobile_pd->bit_shift = ~0)
 		return 0;
 
-	mask = 1 << rmobile_pd->bit_shift;
+	mask = BIT(rmobile_pd->bit_shift);
 	if (__raw_readl(rmobile_pd->base + PSTR) & mask)
 		goto out;
 
-- 
1.9.1

