From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Nov 2012 03:08:16 +0000
Subject: [PATCH 1/8] ARM: shmobile: add fsi external clock on r8a7740
Message-Id: <874nl023mq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

xcka/xckb were required from FSI driver

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index eb5dfee..eac49d5 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -625,6 +625,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("ickb", "sh_fsi2",	&div6_reparent_clks[DIV6_FSIB]),
 	CLKDEV_ICK_ID("diva", "sh_fsi2",	&fsidivs[FSIDIV_A]),
 	CLKDEV_ICK_ID("divb", "sh_fsi2",	&fsidivs[FSIDIV_B]),
+	CLKDEV_ICK_ID("xcka", "sh_fsi2",	&fsiack_clk),
+	CLKDEV_ICK_ID("xckb", "sh_fsi2",	&fsibck_clk),
 };
 
 void __init r8a7740_clock_init(u8 md_ck)
-- 
1.7.9.5

