From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 31 May 2010 09:09:54 +0000
Subject: [PATCH] sh_tmu: compute mult and shift before registration
Message-Id: <1275296994-12005-1-git-send-email-aurelien@aurel32.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Since commit 98962465ed9e6ea99c38e0af63fe1dcb5a79dc25 ("nohz: Prevent
clocksource wrapping during idle"), the CPU of an R2D board never goes
to idle. This commit assumes that mult and shift are assigned before
the clocksource is registered. As a consequence the safe maximum sleep
time is negative and the CPU never goes into idle.

This patch fixes the problem by moving mult and shift initialization
from sh_tmu_clocksource_enable() to sh_tmu_register_clocksource().

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 drivers/clocksource/sh_tmu.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 8e44e14..e9e35aa 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -199,16 +199,8 @@ static cycle_t sh_tmu_clocksource_read(struct clocksource *cs)
 static int sh_tmu_clocksource_enable(struct clocksource *cs)
 {
 	struct sh_tmu_priv *p = cs_to_sh_tmu(cs);
-	int ret;
-
-	ret = sh_tmu_enable(p);
-	if (ret)
-		return ret;
 
-	/* TODO: calculate good shift from rate and counter bit width */
-	cs->shift = 10;
-	cs->mult = clocksource_hz2mult(p->rate, cs->shift);
-	return 0;
+	return sh_tmu_enable(p);
 }
 
 static void sh_tmu_clocksource_disable(struct clocksource *cs)
@@ -228,6 +220,10 @@ static int sh_tmu_register_clocksource(struct sh_tmu_priv *p,
 	cs->disable = sh_tmu_clocksource_disable;
 	cs->mask = CLOCKSOURCE_MASK(32);
 	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
+	/* TODO: calculate good shift from rate and counter bit width */
+	cs->shift = 10;
+	/* channel will be configured at parent clock / 4 */
+	cs->mult = clocksource_hz2mult(clk_get_rate(p->clk) / 4, cs->shift);
 	dev_info(&p->pdev->dev, "used as clock source\n");
 	clocksource_register(cs);
 	return 0;
-- 
1.7.1

