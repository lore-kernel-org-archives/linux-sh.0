From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 15 Jul 2013 23:39:56 +0000
Subject: [PATCH 08/19] sh-pfc: Rename gpio arguments to be consistent with the rest of the code
Message-Id: <1373931607-4599-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The gpio_get_data_reg() and gpio_setup_data_reg() functions both take an
argument named gpio. The argument contains a GPIO offset for the first
function and a pin index for the second one. Rename them to offset and
idx respectively to match the rest of the code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/gpio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 3620bd8..87ae38b 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -48,11 +48,11 @@ static struct sh_pfc *gpio_to_pfc(struct gpio_chip *gc)
 	return gpio_to_pfc_chip(gc)->pfc;
 }
 
-static void gpio_get_data_reg(struct sh_pfc_chip *chip, unsigned int gpio,
+static void gpio_get_data_reg(struct sh_pfc_chip *chip, unsigned int offset,
 			      struct sh_pfc_gpio_data_reg **reg,
 			      unsigned int *bit)
 {
-	int idx = sh_pfc_get_pin_index(chip->pfc, gpio);
+	int idx = sh_pfc_get_pin_index(chip->pfc, offset);
 	struct sh_pfc_gpio_pin *gpio_pin = &chip->pins[idx];
 
 	*reg = &chip->regs[gpio_pin->dreg];
@@ -76,11 +76,11 @@ static void gpio_write_data_reg(struct sh_pfc_chip *chip,
 	sh_pfc_write_raw_reg(mem, dreg->reg_width, value);
 }
 
-static void gpio_setup_data_reg(struct sh_pfc_chip *chip, unsigned gpio)
+static void gpio_setup_data_reg(struct sh_pfc_chip *chip, unsigned idx)
 {
 	struct sh_pfc *pfc = chip->pfc;
-	struct sh_pfc_gpio_pin *gpio_pin = &chip->pins[gpio];
-	const struct sh_pfc_pin *pin = &pfc->info->pins[gpio];
+	struct sh_pfc_gpio_pin *gpio_pin = &chip->pins[idx];
+	const struct sh_pfc_pin *pin = &pfc->info->pins[idx];
 	const struct pinmux_data_reg *dreg;
 	unsigned int bit;
 	unsigned int i;
-- 
1.8.1.5

