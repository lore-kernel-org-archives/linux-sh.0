From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 14 May 2013 04:10:17 +0000
Subject: [PATCH] sh-pfc: r8a7778: fixup IRQ1A settings
Message-Id: <8738tqurq3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

IP2[31] func2 is IRQ1A, not IRQ3A

Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 15295a5..14a84d0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -1966,7 +1966,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 			     1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
 			     1, 1, 1, 1, 3, 2, 3, 3, 3, 3) {
 		/* IP2_31 [1] */
-		FN_MLB_CLK,	FN_IRQ3_A,
+		FN_MLB_CLK,	FN_IRQ1_A,
 		/* IP2_30 [1] */
 		FN_RD_WR_B,	FN_IRQ0,
 		/* IP2_29 [1] */
-- 
1.7.9.5

