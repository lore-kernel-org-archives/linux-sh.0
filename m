From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Fri, 30 Jun 2017 00:54:06 +0000
Subject: [PATCH 4/6] i2c: pca-platform: unconditionally use devm_gpiod_get_optional
Message-Id: <20170630005408.23968-5-chris.packham@alliedtelesis.co.nz>
List-Id: <linux-sh.vger.kernel.org>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa@the-dreams.de, andy.shevchenko@gmail.com, linux-i2c@vger.kernel.org
Cc: ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>, linux-kernel@vger.kernel.org

Allow for the reset-gpios property to be defined in the device tree
or via a GPIO lookup table.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-pca-platform.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 853a2abedb05..1e3c247de8f8 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -176,32 +176,19 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	if (platform_data) {
 		i2c->adap.timeout = platform_data->timeout;
 		i2c->algo_data.i2c_clock = platform_data->i2c_clock_speed;
-		if (gpio_is_valid(platform_data->gpio)) {
-			ret = devm_gpio_request_one(&pdev->dev,
-						    platform_data->gpio,
-						    GPIOF_ACTIVE_LOW,
-						    i2c->adap.name);
-			if (ret = 0) {
-				i2c->gpio = gpio_to_desc(platform_data->gpio);
-				gpiod_direction_output(i2c->gpio, 0);
-			} else {
-				dev_warn(&pdev->dev, "Registering gpio failed!\n");
-				i2c->gpio = NULL;
-			}
-		}
 	} else if (np) {
 		i2c->adap.timeout = HZ;
-		i2c->gpio = devm_gpiod_get_optional(&pdev->dev, "reset-gpios", GPIOD_OUT_LOW);
-		if (IS_ERR(i2c->gpio))
-			return PTR_ERR(i2c->gpio);
 		of_property_read_u32_index(np, "clock-frequency", 0,
 					   &i2c->algo_data.i2c_clock);
 	} else {
 		i2c->adap.timeout = HZ;
 		i2c->algo_data.i2c_clock = 59000;
-		i2c->gpio = NULL;
 	}
 
+	i2c->gpio = devm_gpiod_get_optional(&pdev->dev, "reset-gpios", GPIOD_OUT_LOW);
+	if (IS_ERR(i2c->gpio))
+		return PTR_ERR(i2c->gpio);
+
 	i2c->algo_data.data = i2c;
 	i2c->algo_data.wait_for_completion = i2c_pca_pf_waitforcompletion;
 	if (i2c->gpio)
-- 
2.13.0

