From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Nov 2012 03:08:50 +0000
Subject: [PATCH 2/8] ARM: shmobile: add fsi external clock sh7372
Message-Id: <87390k23ls.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

xcka/xckb were required from FSI driver

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index bee2d05..4d57e34 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -606,6 +606,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("spu2", "sh_fsi2", &mstp_clks[MSTP223]),
 	CLKDEV_ICK_ID("diva", "sh_fsi2", &fsidivs[FSIDIV_A]),
 	CLKDEV_ICK_ID("divb", "sh_fsi2", &fsidivs[FSIDIV_B]),
+	CLKDEV_ICK_ID("xcka", "sh_fsi2", &sh7372_fsiack_clk),
+	CLKDEV_ICK_ID("xckb", "sh_fsi2", &sh7372_fsibck_clk),
 };
 
 void __init sh7372_clock_init(void)
-- 
1.7.9.5

