From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 04 May 2015 14:40:46 +0000
Subject: [PATCH] pinctrl: sh-pfc: r8a7740: Fix typo SCIFAB in comment
Message-Id: <1430750446-8302-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The last serial port is called "SCIFB", not "SCIFAB".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index b486e9d20cc2f7cb..d0bb1459783a16d2 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -258,7 +258,7 @@ enum {
 	/* SCIFA7 */
 	SCIFA7_TXD_MARK,	SCIFA7_RXD_MARK,
 
-	/* SCIFAB */
+	/* SCIFB */
 	SCIFB_SCK_PORT190_MARK, /* MSEL5CR_17_0 */
 	SCIFB_RXD_PORT191_MARK,
 	SCIFB_TXD_PORT192_MARK,
-- 
1.9.1

