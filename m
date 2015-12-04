From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 04 Dec 2015 15:33:53 +0000
Subject: [PATCH v2 2/2] gpio: rcar: Improve clock error handling and reporting
Message-Id: <1449243233-11089-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1449243233-11089-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449243233-11089-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

If the Renesas R-Car GPIO driver cannot find a functional clock, it
prints a warning, .e.g.

	gpio_rcar ffc40000.gpio: unable to get clock

and continues, as the clock is optional, depending on the SoC type.
This warning may confuse users.

To fix this, add a flag to indicate that the clock is mandatory or
optional:
  - If the clock is mandatory (on R-Car Gen2 and Gen3), a missing clock
    is now treated as a fatal error,
  - If the clock is optional (on R-Car Gen1), the warning is no longer
    printed.

Suggested-by: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Use booleans instead of bitfields,
  - Add reference to R-Car Gen3.
---
 drivers/gpio/gpio-rcar.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 1ed52fc026cb4dd2..624a435e69889d7e 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -39,6 +39,7 @@ struct gpio_rcar_priv {
 	struct clk *clk;
 	unsigned int irq_parent;
 	bool has_both_edge_trigger;
+	bool needs_clk;
 };
 
 #define IOINTSEL 0x00	/* General IO/Interrupt Switching Register */
@@ -317,14 +318,17 @@ static int gpio_rcar_direction_output(struct gpio_chip *chip, unsigned offset,
 
 struct gpio_rcar_info {
 	bool has_both_edge_trigger;
+	bool needs_clk;
 };
 
 static const struct gpio_rcar_info gpio_rcar_info_gen1 = {
 	.has_both_edge_trigger = false,
+	.needs_clk = false,
 };
 
 static const struct gpio_rcar_info gpio_rcar_info_gen2 = {
 	.has_both_edge_trigger = true,
+	.needs_clk = true,
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

