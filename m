From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 21 Jun 2013 06:30:22 +0000
Subject: [PATCH 1/2] regulators: max8973: fix multiple instance support
Message-Id: <Pine.LNX.4.64.1306210825040.27277@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Currently the max8973 regulator driver uses a single static struct of
regulator operations for all chip instances, but can overwrite some of its
members depending on configuration. This will affect all other MAX8973
instances on the system. This patch fixes this bug by allocating a separate
copy of the struct for each chip instance.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/regulator/max8973-regulator.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index adb1414..b2dbdd7 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -100,6 +100,7 @@ struct max8973_chip {
 	int curr_vout_reg;
 	int curr_gpio_val;
 	bool valid_dvs_gpio;
+	struct regulator_ops ops;
 };
 
 /*
@@ -240,7 +241,7 @@ static unsigned int max8973_dcdc_get_mode(struct regulator_dev *rdev)
 		REGULATOR_MODE_FAST : REGULATOR_MODE_NORMAL;
 }
 
-static struct regulator_ops max8973_dcdc_ops = {
+static const struct regulator_ops max8973_dcdc_ops = {
 	.get_voltage_sel	= max8973_dcdc_get_voltage_sel,
 	.set_voltage_sel	= max8973_dcdc_set_voltage_sel,
 	.list_voltage		= regulator_list_voltage_linear,
@@ -388,10 +389,11 @@ static int max8973_probe(struct i2c_client *client,
 	}
 
 	i2c_set_clientdata(client, max);
+	max->ops = max8973_dcdc_ops;
 	max->dev = &client->dev;
 	max->desc.name = id->name;
 	max->desc.id = 0;
-	max->desc.ops = &max8973_dcdc_ops;
+	max->desc.ops = &max->ops;
 	max->desc.type = REGULATOR_VOLTAGE;
 	max->desc.owner = THIS_MODULE;
 	max->desc.min_uV = MAX8973_MIN_VOLATGE;
@@ -401,9 +403,9 @@ static int max8973_probe(struct i2c_client *client,
 	if (!pdata->enable_ext_control) {
 		max->desc.enable_reg = MAX8973_VOUT;
 		max->desc.enable_mask = MAX8973_VOUT_ENABLE;
-		max8973_dcdc_ops.enable = regulator_enable_regmap;
-		max8973_dcdc_ops.disable = regulator_disable_regmap;
-		max8973_dcdc_ops.is_enabled = regulator_is_enabled_regmap;
+		max->ops.enable = regulator_enable_regmap;
+		max->ops.disable = regulator_disable_regmap;
+		max->ops.is_enabled = regulator_is_enabled_regmap;
 	}
 
 	max->enable_external_control = pdata->enable_ext_control;
-- 
1.7.2.5

