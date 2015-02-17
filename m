From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 17 Feb 2015 12:11:12 +0000
Subject: [PATCH/RFC 2/2] regulator: da9210: Add optional interrupt support
Message-Id: <1424175072-14643-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1424175072-14643-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1424175072-14643-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Steve Twiss <stwiss.opensource@diasemi.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org

Add optional interrupt support to the da9210 regulator driver, to handle
over-current, under-voltage, and over-temperature events.

Only the interrupt sources for which we handle events are unmasked, to
avoid interrupts we cannot handle.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org
---
  - I do not have access to the da9210 datasheet, but looked at the da9211
    driver, hence the RFC status,
  - Does there exist any regulator notifier event that corresponds to
    DA9210_E_VMAX?
---
 .../devicetree/bindings/regulator/da9210.txt       |  4 ++
 drivers/regulator/da9210-regulator.c               | 63 ++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/da9210.txt b/Documentation/devicetree/bindings/regulator/da9210.txt
index 3297c53cb9152395..7aa9b1fa6b21ca18 100644
--- a/Documentation/devicetree/bindings/regulator/da9210.txt
+++ b/Documentation/devicetree/bindings/regulator/da9210.txt
@@ -5,6 +5,10 @@ Required properties:
 - compatible:	must be "dlg,da9210"
 - reg:		the i2c slave address of the regulator. It should be 0x68.
 
+Optional properties:
+
+- interrupts:	a reference to the DA9210 interrupt, if available.
+
 Any standard regulator properties can be used to configure the single da9210
 DCDC.
 
diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index f0489cb9018b4e78..2c60a2d6f3a7a080 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -22,6 +22,8 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
@@ -120,6 +122,43 @@ static int da9210_get_current_limit(struct regulator_dev *rdev)
 	return da9210_buck_limits[sel];
 }
 
+static irqreturn_t da9210_irq_handler(int irq, void *data)
+{
+	struct da9210 *chip = data;
+	unsigned int val;
+	int error, ret = IRQ_NONE;
+
+	error = regmap_read(chip->regmap, DA9210_REG_EVENT_B, &val);
+	if (error < 0)
+		goto error_i2c;
+
+	if (val & DA9210_E_OVCURR)
+		regulator_notifier_call_chain(chip->rdev,
+					      REGULATOR_EVENT_OVER_CURRENT,
+					      NULL);
+	if (val & DA9210_E_NPWRGOOD)
+		regulator_notifier_call_chain(chip->rdev,
+					      REGULATOR_EVENT_UNDER_VOLTAGE,
+					      NULL);
+	if (val & (DA9210_E_TEMP_WARN | DA9210_E_TEMP_CRIT))
+		regulator_notifier_call_chain(chip->rdev,
+					      REGULATOR_EVENT_OVER_TEMP, NULL);
+	if (val) {
+		/* Clear all events */
+		error = regmap_write(chip->regmap, DA9210_REG_EVENT_B, val);
+		if (error < 0)
+			goto error_i2c;
+
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+
+error_i2c:
+	dev_err(regmap_get_device(chip->regmap), "I2C error : %d\n", error);
+	return ret;
+}
+
 /*
  * I2C driver interface functions
  */
@@ -168,6 +207,30 @@ static int da9210_i2c_probe(struct i2c_client *i2c,
 	}
 
 	chip->rdev = rdev;
+	if (i2c->irq) {
+		error = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
+						  da9210_irq_handler,
+						  IRQF_TRIGGER_LOW |
+						  IRQF_ONESHOT | IRQF_SHARED,
+						  "da9210", chip);
+		if (error) {
+			dev_err(&i2c->dev, "Failed to request IRQ%u: %d\n",
+				i2c->irq, error);
+			return error;
+		}
+
+		error = regmap_update_bits(chip->regmap, DA9210_REG_MASK_B,
+					 DA9210_M_OVCURR | DA9210_M_NPWRGOOD |
+					 DA9210_M_TEMP_WARN |
+					 DA9210_M_TEMP_CRIT, 0);
+		if (error < 0) {
+			dev_err(&i2c->dev, "Failed to update mask reg: %d\n",
+				error);
+			return error;
+		}
+	} else {
+		dev_warn(&i2c->dev, "No IRQ configured\n");
+	}
 
 	i2c_set_clientdata(i2c, chip);
 
-- 
1.9.1

