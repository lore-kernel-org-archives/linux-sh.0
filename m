From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jan 2012 09:44:22 +0000
Subject: [PATCH][RFC] sh: clock-sh7724: fixup sh_fsi clock settings
Message-Id: <87vco99wgg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_fsi needs HWBLK_SPU clock on sh7724

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index b3c039a..70bd966 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -343,7 +343,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_ceu.1", &mstp_clks[HWBLK_CEU1]),
 	CLKDEV_CON_ID("beu1", &mstp_clks[HWBLK_BEU1]),
 	CLKDEV_CON_ID("2ddmac0", &mstp_clks[HWBLK_2DDMAC]),
-	CLKDEV_CON_ID("spu0", &mstp_clks[HWBLK_SPU]),
+	CLKDEV_DEV_ID("sh_fsi.0", &mstp_clks[HWBLK_SPU]),
 	CLKDEV_CON_ID("jpu0", &mstp_clks[HWBLK_JPU]),
 	CLKDEV_DEV_ID("sh-vou.0", &mstp_clks[HWBLK_VOU]),
 	CLKDEV_CON_ID("beu0", &mstp_clks[HWBLK_BEU0]),
-- 
1.7.5.4

