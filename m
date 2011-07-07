From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 07 Jul 2011 01:36:44 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: sh7372: make sure that fsi is peripheral of spu2
Message-Id: <87ei22dg7q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

FSI act as peripheral circuits of the SPU2.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c   |    1 +
 arch/arm/mach-shmobile/board-mackerel.c |    1 +
 arch/arm/mach-shmobile/clock-sh7372.c   |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index a26f895..4226db6 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1414,6 +1414,7 @@ static void __init ap4evb_init(void)
 	hdmi_init_pm_clock();
 	fsi_init_pm_clock();
 	sh7372_pm_init();
+	pm_clk_add(&fsi_device.dev, "spu2");
 }
 
 static void __init ap4evb_timer_init(void)
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index cc1ccd8..362b883 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1587,6 +1587,7 @@ static void __init mackerel_init(void)
 
 	hdmi_init_pm_clock();
 	sh7372_pm_init();
+	pm_clk_add(&fsi_device.dev, "spu2");
 }
 
 static void __init mackerel_timer_init(void)
diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index c0800d8..91f5779 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -662,6 +662,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("ick", "sh-mobile-hdmi", &div6_reparent_clks[DIV6_HDMI]),
 	CLKDEV_ICK_ID("icka", "sh_fsi2", &div6_reparent_clks[DIV6_FSIA]),
 	CLKDEV_ICK_ID("ickb", "sh_fsi2", &div6_reparent_clks[DIV6_FSIB]),
+	CLKDEV_ICK_ID("spu2", "sh_fsi2", &mstp_clks[MSTP223]),
 };
 
 void __init sh7372_clock_init(void)
-- 
1.7.4.1

