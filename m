From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 04 Jun 2015 23:25:01 +0000
Subject: [PATCH v2 1/4] sh-pfc: do not call sh_pfc_get_pin_index() when unnecessary
Message-Id: <10321666.EILxzFPKZf@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4326653.qPvIJDU6F2@wasted.cogentembedded.com>
In-Reply-To: <4326653.qPvIJDU6F2@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org

Calling sh_pfc_get_pin_index()  to calculate a pin index based on the collected
pin range data is unnecessary when we're dealing with 'pfc->info->pins' and
'chip->pins' arrays as those always reperesent the pins starting from index 0
sequentially. Being a  mere  optimization at this time, this change will become
crucial when we'll allow the "holes" in those arrays...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- new patch.

 drivers/pinctrl/sh-pfc/gpio.c    |    6 ++----
 drivers/pinctrl/sh-pfc/pinctrl.c |    7 +++----
 2 files changed, 5 insertions(+), 8 deletions(-)

Index: linux-pinctrl/drivers/pinctrl/sh-pfc/gpio.c
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/gpio.c
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/gpio.c
@@ -52,8 +52,7 @@ static void gpio_get_data_reg(struct sh_
 			      struct sh_pfc_gpio_data_reg **reg,
 			      unsigned int *bit)
 {
-	int idx = sh_pfc_get_pin_index(chip->pfc, offset);
-	struct sh_pfc_gpio_pin *gpio_pin = &chip->pins[idx];
+	struct sh_pfc_gpio_pin *gpio_pin = &chip->pins[offset];
 
 	*reg = &chip->regs[gpio_pin->dreg];
 	*bit = gpio_pin->dbit;
@@ -138,9 +137,8 @@ static int gpio_setup_data_regs(struct s
 static int gpio_pin_request(struct gpio_chip *gc, unsigned offset)
 {
 	struct sh_pfc *pfc = gpio_to_pfc(gc);
-	int idx = sh_pfc_get_pin_index(pfc, offset);
 
-	if (idx < 0 || pfc->info->pins[idx].enum_id = 0)
+	if (pfc->info->pins[offset].enum_id = 0)
 		return -EINVAL;
 
 	return pinctrl_request_gpio(offset);
Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pinctrl.c
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pinctrl.c
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -370,7 +370,7 @@ static int sh_pfc_gpio_request_enable(st
 		/* If GPIOs are handled externally the pin mux type need to be
 		 * set to GPIO here.
 		 */
-		const struct sh_pfc_pin *pin = &pfc->info->pins[idx];
+		const struct sh_pfc_pin *pin = &pfc->info->pins[offset];
 
 		ret = sh_pfc_config_mux(pfc, pin->enum_id, PINMUX_TYPE_GPIO);
 		if (ret < 0)
@@ -410,7 +410,7 @@ static int sh_pfc_gpio_set_direction(str
 	struct sh_pfc *pfc = pmx->pfc;
 	int new_type = input ? PINMUX_TYPE_INPUT : PINMUX_TYPE_OUTPUT;
 	int idx = sh_pfc_get_pin_index(pfc, offset);
-	const struct sh_pfc_pin *pin = &pfc->info->pins[idx];
+	const struct sh_pfc_pin *pin = &pfc->info->pins[offset];
 	struct sh_pfc_pin_config *cfg = &pmx->configs[idx];
 	unsigned long flags;
 	unsigned int dir;
@@ -452,8 +452,7 @@ static const struct pinmux_ops sh_pfc_pi
 static bool sh_pfc_pinconf_validate(struct sh_pfc *pfc, unsigned int _pin,
 				    enum pin_config_param param)
 {
-	int idx = sh_pfc_get_pin_index(pfc, _pin);
-	const struct sh_pfc_pin *pin = &pfc->info->pins[idx];
+	const struct sh_pfc_pin *pin = &pfc->info->pins[_pin];
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:

