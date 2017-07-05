From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Wed, 05 Jul 2017 10:13:56 +0000
Subject: [PATCH v2 2/4] i2c: pca-platform: unconditionally use devm_gpiod_get_optional
Message-Id: <20170705101358.17458-3-chris.packham@alliedtelesis.co.nz>
List-Id: <linux-sh.vger.kernel.org>
References: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa@the-dreams.de, ysato@users.sourceforge.jp, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>

Allow for the reset-gpios property to be defined in the device tree
or via a GPIO lookup table.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- move call up above platform_data usage

 drivers/i2c/busses/i2c-pca-platform.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 853a2abedb05..b90193d09d4b 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -173,33 +173,20 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	i2c->adap.dev.parent = &pdev->dev;
 	i2c->adap.dev.of_node = np;
 
+	i2c->gpio = devm_gpiod_get_optional(&pdev->dev, "reset-gpios", GPIOD_OUT_LOW);
+	if (IS_ERR(i2c->gpio))
+		return PTR_ERR(i2c->gpio);
+
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
 
 	i2c->algo_data.data = i2c;
-- 
2.13.0

