From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 06 Aug 2014 01:24:51 +0000
Subject: [PATCH 3/3 v2] ARM: shmobile: r8a7791: add missing 0x0100 for SDCKCR
Message-Id: <87y4v2jtpb.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

4bfb358b1d6cdeff8c6a13677f01ed78e9696b98
(ARM: shmobile: Add r8a7791 legacy SDHI clocks)
added r8a7791 SDHI clock support.

But, it is missing
"0x0100: x 1/8" division ratio.
This patch fixes hidden bug.
It is based on R-Car H2 v0.7, R-Car M2 v0.9.

Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7791.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index 10e193d..453b231 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -152,7 +152,7 @@ enum {
 
 static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_SDH] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 8, 0x0dff, CLK_ENABLE_ON_INIT),
-	[DIV4_SD0] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 4, 0x1de0, CLK_ENABLE_ON_INIT),
+	[DIV4_SD0] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 4, 0x1df0, CLK_ENABLE_ON_INIT),
 };
 
 /* DIV6 clocks */
-- 
1.7.9.5

