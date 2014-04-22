From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 22 Apr 2014 16:38:05 +0000
Subject: [PATCH] sh-pfc: r8a7791: Fix definition of MOD_SEL3
Message-Id: <1398184685-31670-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Phil Edworthy <phil.edworthy@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

There is a missing 0 entry from the MOD_SEL3 table.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 56f62dc..a823b5b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -5305,7 +5305,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* SEL_SCIF3 [2] */
 		FN_SEL_SCIF3_0, FN_SEL_SCIF3_1, FN_SEL_SCIF3_2, FN_SEL_SCIF3_3,
 		/* SEL_IEB [2] */
-		FN_SEL_IEB_0, FN_SEL_IEB_1, FN_SEL_IEB_2,
+		FN_SEL_IEB_0, FN_SEL_IEB_1, FN_SEL_IEB_2, 0,
 		/* SEL_MMC [1] */
 		FN_SEL_MMC_0, FN_SEL_MMC_1,
 		/* SEL_SCIF5 [1] */
-- 
1.9.1

