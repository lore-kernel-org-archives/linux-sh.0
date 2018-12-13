From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 13 Dec 2018 18:27:03 +0000
Subject: [PATCH 04/15] pinctrl: sh-pfc: sh7734: Add missing IPSR11 field
Message-Id: <20181213182714.26094-5-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The Peripheral Function Select Register 11 contains 3 reserved bits and
15 variable-width fields, but the variable field descriptor does not
contain the 3-bit field IP11[25:23].

Fixes: 856cb4bb337ee504 ("sh: Add support pinmux for SH7734")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-sh7734.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index b0533c86053a6467..04062f642d3e62de 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -2234,7 +2234,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_LCD_DATA15_B, 0, 0, 0 }
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR11", 0xFFFC0048, 32,
-			3, 1, 2, 2, 2, 3, 3, 1, 2, 3, 3, 1, 1, 1, 1) {
+			3, 1, 2, 3, 2, 2, 3, 3, 1, 2, 3, 3, 1, 1, 1, 1) {
 	    /* IP11_31_29 [3] */
 	    0, 0, 0, 0, 0, 0, 0, 0,
 	    /* IP11_28 [1] */
-- 
2.17.1
