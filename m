From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Jan 2014 05:25:14 +0000
Subject: [PATCH] regulator: gpio: bugfix: add gpios-status for DT
Message-Id: <87eh3o7mfc.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r47r6v48.wl%kuninori.morimoto.gx@gmail.com>
	<20140129124516.GZ11841@sirena.org.uk>
	<87mwieib5x.wl%kuninori.morimoto.gx@gmail.com>
	<20140130121251.GO22609@sirena.org.uk>
In-Reply-To: <20140130121251.GO22609@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

config->gpios[x].flags indicates initial pin status,
and it will be used for drvdata->state
on gpio_regulator_probe().
But, current of_get_gpio_regulator_config() doesn't care
about this flags.
This patch adds new gpios-status property in order to
care about initial pin status.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../bindings/regulator/gpio-regulator.txt          |    1 +
 drivers/regulator/gpio-regulator.c                 |   11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
index 63c6598..3ecb585 100644
--- a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
@@ -8,6 +8,7 @@ Required properties:
 Optional properties:
 - enable-gpio		: GPIO to use to enable/disable the regulator.
 - gpios			: GPIO group used to control voltage.
+- gpios-states		: gpios pin's initial states. 1 means HIGH
 - startup-delay-us	: Startup time in microseconds.
 - enable-active-high	: Polarity of GPIO is active high (default is low).
 
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index c0a1d00..7c8e37a 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -172,11 +172,22 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np)
 	if (!config->gpios)
 		return ERR_PTR(-ENOMEM);
 
+	prop = of_find_property(np, "gpios-states", NULL);
+	if (prop) {
+		proplen = prop->length / sizeof(int);
+		if (proplen != config->nr_gpios) {
+			/* gpios <-> gpios-states mismatch */
+			prop = NULL;
+		}
+	}
+
 	for (i = 0; i < config->nr_gpios; i++) {
 		gpio = of_get_named_gpio(np, "gpios", i);
 		if (gpio < 0)
 			break;
 		config->gpios[i].gpio = gpio;
+		if (prop && be32_to_cpup((int *)prop->value + i))
+			config->gpios[i].flags = GPIOF_OUT_INIT_HIGH;
 	}
 
 	/* Fetch states. */
-- 
1.7.9.5

