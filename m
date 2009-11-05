From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 05 Nov 2009 10:23:40 +0000
Subject: [PATCH] sh: sh7724: SPU2 clock enable on boot
Message-Id: <uk4y56zir.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
This is v2 patch of 
[PATCH] sh: mach-ecovec24: Enable SPU2 clock when boot

 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index dfe9192..9db7438 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -152,7 +152,7 @@ struct clk div6_clks[] = {
 	SH_CLK_DIV6("fsia_clk", &div3_clk, FCLKACR, 0),
 	SH_CLK_DIV6("fsib_clk", &div3_clk, FCLKBCR, 0),
 	SH_CLK_DIV6("irda_clk", &div3_clk, IRDACLKCR, 0),
-	SH_CLK_DIV6("spu_clk", &div3_clk, SPUCLKCR, 0),
+	SH_CLK_DIV6("spu_clk", &div3_clk, SPUCLKCR, CLK_ENABLE_ON_INIT),
 };
 
 #define R_CLK (&r_clk)
-- 
1.6.3.3

