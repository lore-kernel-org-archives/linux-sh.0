From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 27 Feb 2015 23:39:19 +0000
Subject: [PATCH] sh-pfc: handle pin array holes in sh_pfc_map_pins()
Message-Id: <1528110.Mb5xiNU0rc@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org

The  pin array handled by sh_pfc_map_pins() may contain holes representing non-
existing pins. We have to first count the valid pins in order to calculate the
size  of the memory to be allocated, then to skip over the non-existing pins
when  initializing the allocated arrays, and then to return the number of valid
pins  from sh_pfc_map_pins() instead of 0 on success.

As we have to touch devm_kzalloc() calls anyway, use more fitting devm_kcalloc()
instead which additionally checks the array size. And since PINMUX_TYPE_NONE is
#define'd as 0, stop re-initializing already zeroed out 'pmx->configs' array.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git' repo.
This patch should be applied before my R8A7794 PFC support patch and before
Laurent's patches removing non-existent GPIOs for R8A779[01], otherwise they
would cause the kernel  to hang while booting!

 drivers/pinctrl/sh-pfc/pinctrl.c |   32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pinctrl.c
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pinctrl.c
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -571,33 +571,39 @@ static const struct pinconf_ops sh_pfc_p
 /* PFC ranges -> pinctrl pin descs */
 static int sh_pfc_map_pins(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 {
-	unsigned int i;
+	const struct sh_pfc_pin *info;
+	struct pinctrl_pin_desc *pin;
+	unsigned int i, n;
+
+	/* Count the valid pins. */
+	for (i = 0, info = pfc->info->pins, n = 0;
+	     i < pfc->info->nr_pins; i++, info++) {
+		if (info->enum_id || info->configs)
+			n++;
+	}
 
 	/* Allocate and initialize the pins and configs arrays. */
-	pmx->pins = devm_kzalloc(pfc->dev,
-				 sizeof(*pmx->pins) * pfc->info->nr_pins,
-				 GFP_KERNEL);
+	pmx->pins = devm_kcalloc(pfc->dev, n, sizeof(*pmx->pins), GFP_KERNEL);
 	if (unlikely(!pmx->pins))
 		return -ENOMEM;
 
-	pmx->configs = devm_kzalloc(pfc->dev,
-				    sizeof(*pmx->configs) * pfc->info->nr_pins,
+	pmx->configs = devm_kcalloc(pfc->dev, n, sizeof(*pmx->configs),
 				    GFP_KERNEL);
 	if (unlikely(!pmx->configs))
 		return -ENOMEM;
 
-	for (i = 0; i < pfc->info->nr_pins; ++i) {
-		const struct sh_pfc_pin *info = &pfc->info->pins[i];
-		struct sh_pfc_pin_config *cfg = &pmx->configs[i];
-		struct pinctrl_pin_desc *pin = &pmx->pins[i];
+	for (i = 0, info = pfc->info->pins, pin = pmx->pins;
+	     i < pfc->info->nr_pins; i++, info++) {
+		if (!info->enum_id && !info->configs)
+			continue;
 
 		/* If the pin number is equal to -1 all pins are considered */
 		pin->number = info->pin != (u16)-1 ? info->pin : i;
 		pin->name = info->name;
-		cfg->type = PINMUX_TYPE_NONE;
+		pin++;
 	}
 
-	return 0;
+	return n;
 }
 
 int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
@@ -622,7 +628,7 @@ int sh_pfc_register_pinctrl(struct sh_pf
 	pmx->pctl_desc.pmxops = &sh_pfc_pinmux_ops;
 	pmx->pctl_desc.confops = &sh_pfc_pinconf_ops;
 	pmx->pctl_desc.pins = pmx->pins;
-	pmx->pctl_desc.npins = pfc->info->nr_pins;
+	pmx->pctl_desc.npins = ret;
 
 	pmx->pctl = pinctrl_register(&pmx->pctl_desc, pfc->dev, pmx);
 	if (pmx->pctl = NULL)

