From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Wed, 27 Jun 2012 00:59:41 +0000
Subject: [PATCH 2/3] ARM: mach-shmobile: Convert sh_clk_mstp32_register to sh_clk_mstp_register
Message-Id: <1340758782-605-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1204162306540.29915@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1204162306540.29915@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_clk_mstp32_register is deprecated. This convert to sh_clk_mstp_register.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    2 +-
 arch/arm/mach-shmobile/clock-r8a7779.c |    2 +-
 arch/arm/mach-shmobile/clock-sh7367.c  |    2 +-
 arch/arm/mach-shmobile/clock-sh7372.c  |    2 +-
 arch/arm/mach-shmobile/clock-sh7377.c  |    2 +-
 arch/arm/mach-shmobile/clock-sh73a0.c  |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 26eea5f..29c397a 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -495,7 +495,7 @@ void __init r8a7740_clock_init(u8 md_ck)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 7d6e9fe4..339c62c 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -162,7 +162,7 @@ void __init r8a7779_clock_init(void)
 		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	for (k = 0; !ret && (k < ARRAY_SIZE(late_main_clks)); k++)
 		ret = clk_register(late_main_clks[k]);
diff --git a/arch/arm/mach-shmobile/clock-sh7367.c b/arch/arm/mach-shmobile/clock-sh7367.c
index 006e7b5..162b791 100644
--- a/arch/arm/mach-shmobile/clock-sh7367.c
+++ b/arch/arm/mach-shmobile/clock-sh7367.c
@@ -344,7 +344,7 @@ void __init sh7367_clock_init(void)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 94d1f88..5a2894b 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -704,7 +704,7 @@ void __init sh7372_clock_init(void)
 		ret = sh_clk_div6_reparent_register(div6_reparent_clks, DIV6_REPARENT_NR);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	for (k = 0; !ret && (k < ARRAY_SIZE(late_main_clks)); k++)
 		ret = clk_register(late_main_clks[k]);
diff --git a/arch/arm/mach-shmobile/clock-sh7377.c b/arch/arm/mach-shmobile/clock-sh7377.c
index 0798a15..85f2a3e 100644
--- a/arch/arm/mach-shmobile/clock-sh7377.c
+++ b/arch/arm/mach-shmobile/clock-sh7377.c
@@ -355,7 +355,7 @@ void __init sh7377_clock_init(void)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 472d1f5..f6788be 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -612,7 +612,7 @@ void __init sh73a0_clock_init(void)
 		ret = sh_clk_div6_reparent_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	for (k = 0; !ret && (k < ARRAY_SIZE(late_main_clks)); k++)
 		ret = clk_register(late_main_clks[k]);
-- 
1.7.10

