From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 09 Nov 2013 12:12:28 +0000
Subject: [PATCH] regulator: gpio-regulator: Don't oops on missing regulator-type property
Message-Id: <1383999148-2516-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Catch missing regulator-type property in DT and return an error
gracefully instead of deferencing a NULL pointer and crashing.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/regulator/gpio-regulator.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 98a98ff..bcd827c 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -139,6 +139,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np)
 	struct property *prop;
 	const char *regtype;
 	int proplen, gpio, i;
+	int ret;
 
 	config = devm_kzalloc(dev,
 			sizeof(struct gpio_regulator_config),
@@ -202,7 +203,11 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np)
 	}
 	config->nr_states = i;
 
-	of_property_read_string(np, "regulator-type", &regtype);
+	ret = of_property_read_string(np, "regulator-type", &regtype);
+	if (ret < 0) {
+		dev_err(dev, "Missing 'regulator-type' property\n");
+		return ERR_PTR(-EINVAL);
+	}
 
 	if (!strncmp("voltage", regtype, 7))
 		config->type = REGULATOR_VOLTAGE;
-- 
Regards,

Laurent Pinchart

