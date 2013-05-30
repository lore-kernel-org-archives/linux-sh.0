From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Thu, 30 May 2013 09:31:06 +0000
Subject: [PATCH] pinctrl: sh-pfc: r8a7779: Fix missing MOD_SEL2 entry
Message-Id: <1369906266-30205-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The list of functions selected by the MOD_SEL2 register was missing
an entry. This caused all entries after this to modify the MOD_SEL2
register incorrectly.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 13feaa0..5dfeb3e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2525,7 +2525,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 	    /* SEL_SCIF [2] */
 	    FN_SEL_SCIF_0, FN_SEL_SCIF_1, FN_SEL_SCIF_2, FN_SEL_SCIF_3,
 	    /* SEL_CANCLK [2] */
-	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2,
+	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2, 0,
 	    /* SEL_CAN0 [1] */
 	    FN_SEL_CAN0_0, FN_SEL_CAN0_1,
 	    /* SEL_HSCIF1 [1] */
-- 
1.7.9.5

