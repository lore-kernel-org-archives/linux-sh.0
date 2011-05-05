From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 May 2011 16:26:06 +0000
Subject: [PATCH] ARM: mach-shmobile: PLL does not have to run constantly for
Message-Id: <Pine.LNX.4.64.1105051823350.29735@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The PLLC2 clock on AP4 systems does not need to run constantly to be
able to use HDMI. The HDMI hotplug interrupt works without the PLL
too, after which all the necessary clocks will be turned on by the
runtime PM.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |    5 -----
 arch/arm/mach-shmobile/board-mackerel.c |    6 ------
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 1e35fa97..74768d6 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -980,11 +980,6 @@ static void __init hdmi_init_pm_clock(void)
 		goto out;
 	}
 
-	ret = clk_enable(&sh7372_pllc2_clk);
-	if (ret < 0) {
-		pr_err("Cannot enable pllc2 clock\n");
-		goto out;
-	}
 	pr_debug("PLLC2 set frequency %lu\n", rate);
 
 	ret = clk_set_parent(hdmi_ick, &sh7372_pllc2_clk);
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 5b09cb5..b20dd6f 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -458,12 +458,6 @@ static void __init hdmi_init_pm_clock(void)
 		goto out;
 	}
 
-	ret = clk_enable(&sh7372_pllc2_clk);
-	if (ret < 0) {
-		pr_err("Cannot enable pllc2 clock\n");
-		goto out;
-	}
-
 	pr_debug("PLLC2 set frequency %lu\n", rate);
 
 	ret = clk_set_parent(hdmi_ick, &sh7372_pllc2_clk);
-- 
1.7.2.5

