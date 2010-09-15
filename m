From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Sep 2010 06:38:07 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: modify wrong array size of
Message-Id: <w3peicvwlyp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 7594689..ea384e1 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -548,7 +548,7 @@ void __init sh7372_clock_init(void)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_clk_div6_reparent_register(div6_reparent_clks, DIV6_NR);
+		ret = sh_clk_div6_reparent_register(div6_reparent_clks, DIV6_REPARENT_NR);
 
 	if (!ret)
 		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
-- 
1.7.0.4

