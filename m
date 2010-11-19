From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 19 Nov 2010 07:23:32 +0000
Subject: [PATCH 5/6] ARM: mach-shmobile: clock-sh7372: remove unnecessary fsi
Message-Id: <w3p62vt4w0b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 41663e0..cbeca28 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -602,8 +602,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("vck3_clk", &div6_clks[DIV6_VCK3]),
 	CLKDEV_CON_ID("fmsi_clk", &div6_clks[DIV6_FMSI]),
 	CLKDEV_CON_ID("fmso_clk", &div6_clks[DIV6_FMSO]),
-	CLKDEV_CON_ID("fsia_clk", &div6_reparent_clks[DIV6_FSIA]),
-	CLKDEV_CON_ID("fsib_clk", &div6_reparent_clks[DIV6_FSIB]),
 	CLKDEV_CON_ID("sub_clk", &div6_clks[DIV6_SUB]),
 	CLKDEV_CON_ID("spu_clk", &div6_clks[DIV6_SPU]),
 	CLKDEV_CON_ID("vou_clk", &div6_clks[DIV6_VOU]),
-- 
1.7.0.4

