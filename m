From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:22:33 +0000
Subject: [PATCH 09/11] ARM: shmobile: r8a7779: Remove GENPD_FLAG_PM_CLK flag
Message-Id: <1433442155-19492-10-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The R-Car SYSC PM Domain only manages power domains for the main CPUs
and for coprocessors. It does not fill in the genpd .{at,de}tach_dev()
callbacks, and no power management clocks are registered for devices.
Hence pm_clk_{suspend,resume}() are no-ops, and setting of the
GENPD_FLAG_PM_CLK flag can be removed.

Originally the clock handling was copied from the R-Mobile PM Domain
code, which does manage a clock domain, in addition to device power
domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-r8a7779.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index 44a74c4c5a01d0d4..d5f258e4d890f0ca 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -83,7 +83,6 @@ static void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
 {
 	struct generic_pm_domain *genpd = &r8a7779_pd->genpd;
 
-	genpd->flags = GENPD_FLAG_PM_CLK;
 	pm_genpd_init(genpd, NULL, false);
 	genpd->dev_ops.active_wakeup = pd_active_wakeup;
 	genpd->power_off = pd_power_down;
-- 
1.9.1

