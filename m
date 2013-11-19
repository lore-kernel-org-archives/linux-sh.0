From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 19 Nov 2013 09:05:10 +0000
Subject: [PATCH 4/6] ARM: shmobile: r7s72100: tidyup clock table order
Message-Id: <874n78ep8d.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SuperH lookups clock is using CLKDEV_CON/DEV/ICK_ID() macro
for a long term.
But in these days, the ICK clock is defined in random place.
This patch arranges it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r7s72100.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index 1c9d261..0814a50 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -170,6 +170,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP clocks */
+	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
+
+	/* ICK */
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP47]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP46]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP45]),
@@ -178,7 +181,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[MSTP42]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.6", &mstp_clks[MSTP41]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.7", &mstp_clks[MSTP40]),
-	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
 };
 
 void __init r7s72100_clock_init(void)
-- 
1.7.9.5

