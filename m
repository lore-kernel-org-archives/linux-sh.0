From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 12 Mar 2015 10:09:15 +0000
Subject: [PATCH v3 3/4] pinctrl: sh-pfc: Use reg_width instead of reg as sentinel
Message-Id: <1426154956-26583-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1426154956-26583-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426154956-26583-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

All other loops over sh_pfc_soc_info.data_regs[] use
pinmux_data_reg.regwidth as the sentinel, which is safer as zero is
never a valid regwidth value (reg could be zero if we start using it to
store an offset).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3:
  - Add Acked-by,

v2:
  - New.
---
 drivers/pinctrl/sh-pfc/gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index aa2fc77a1925e839..5d3a35ce09125a45 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -84,7 +84,7 @@ static void gpio_setup_data_reg(struct sh_pfc_chip *chip, unsigned idx)
 	unsigned int bit;
 	unsigned int i;
 
-	for (i = 0, dreg = pfc->info->data_regs; dreg->reg; ++i, ++dreg) {
+	for (i = 0, dreg = pfc->info->data_regs; dreg->reg_width; ++i, ++dreg) {
 		for (bit = 0; bit < dreg->reg_width; bit++) {
 			if (dreg->enum_ids[bit] = pin->enum_id) {
 				gpio_pin->dreg = i;
-- 
1.9.1

