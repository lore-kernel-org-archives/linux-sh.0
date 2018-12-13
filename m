From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 13 Dec 2018 18:27:08 +0000
Subject: [PATCH 09/15] pinctrl: sh-pfc: sh7734: Remove bogus IPSR10 value
Message-Id: <20181213182714.26094-10-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The IP10[5:3] field in Peripheral Function Select Register 10 has a
width of 3 bits, i.e. it allows programming one out of 8 different
configurations.
However, 9 values are provided instead of 8, overflowing into the
subsequent field in the register, and thus breaking the configuration of
the latter.

Fix this by dropping a bogus zero value.

Fixes: ac1ebc2190f575fc ("sh-pfc: Add sh7734 pinmux support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-sh7734.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index 04062f642d3e62de..cad70f9cf5699f0c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -2228,7 +2228,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		FN_LCD_CL1_B, 0, 0, 0,
 	    /* IP10_5_3 [3] */
 		FN_SSI_WS23, FN_VI1_5_B, FN_TX1_D, FN_HSCK0_C, FN_FALE_B,
-		FN_LCD_DON_B, 0, 0, 0,
+		FN_LCD_DON_B, 0, 0,
 	    /* IP10_2_0 [3] */
 		FN_SSI_SCK23, FN_VI1_4_B, FN_RX1_D, FN_FCLE_B,
 		FN_LCD_DATA15_B, 0, 0, 0 }
-- 
2.17.1
