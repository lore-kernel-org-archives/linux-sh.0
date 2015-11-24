From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 24 Nov 2015 15:05:28 +0000
Subject: [PATCH] gpio: rcar: Improve clock error handling and reporting
Message-Id: <1448377528-19307-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

If the Renesas R-Car GPIO driver cannot find a functional clock, it
prints a warning, .e.g.

	gpio_rcar ffc40000.gpio: unable to get clock

and continues, as the clock is optional, depending on the SoC type.
This warning may confuse users.

To fix this, add a flag to indicate that the clock is mandatory or
optional:
  - If the clock is mandatory (on R-Car Gen2), a missing clock is now
    treated as a fatal error,
  - If the clock is optional (on R-Car Gen1), the warning is no longer
    printed.

The new flag is merged with the existing has_both_edge_trigger boolean
into a bitfield to save space.

Suggested-by: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "gpio: rcar: Remove obsolete platform data support".

Tested on r8a7779/marzen (no functional clock) and r8a7791/koelsch (with
and without mandatory functional clock).

 drivers/gpio/gpio-rcar.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index bb6e363d5178634c..c890ac14b23a65ea 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -39,6 +39,7 @@ struct gpio_rcar_priv {
 	struct clk *clk;
 	unsigned int irq_parent;
 	unsigned has_both_edge_trigger:1;
+	unsigned needs_clk:1;
 };
 
 #define IOINTSEL 0x00	/* General IO/Interrupt Switching Register */
@@ -316,15 +317,18 @@ static int gpio_rcar_direction_output(struct gpio_chip *chip, unsigned offset,
 }
 
 struct gpio_rcar_info {
-	bool has_both_edge_trigger;
+	unsigned has_both_edge_trigger:1;
+	unsigned needs_clk:1;
 };
 
 static const struct gpio_rcar_info gpio_rcar_info_gen1 = {
-	.has_both_edge_trigger = false,
+	.has_both_edge_trigger = 0,
+	.needs_clk = 0,
 };
 
 static const struct gpio_rcar_info gpio_rcar_info_gen2 = {
-	.has_both_edge_trigger = true,
+	.has_both_edge_trigger = 1,
+	.needs_clk = 1,
 };
 
 static const struct of_device_id gpio_rcar_of_table[] = {
@@ -371,6 +375,7 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
 	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
 	*npins = ret = 0 ? args.args[2] : RCAR_MAX_GPIO_PER_BANK;
 	p->has_both_edge_trigger = info->has_both_edge_trigger;
+	p->needs_clk = info->needs_clk;
 
 	if (*npins = 0 || *npins > RCAR_MAX_GPIO_PER_BANK) {
 		dev_warn(&p->pdev->dev,
@@ -409,7 +414,11 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 
 	p->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(p->clk)) {
-		dev_warn(dev, "unable to get clock\n");
+		if (p->needs_clk) {
+			dev_err(dev, "unable to get clock\n");
+			ret = PTR_ERR(p->clk);
+			goto err0;
+		}
 		p->clk = NULL;
 	}
 
-- 
1.9.1

