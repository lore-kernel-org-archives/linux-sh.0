From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Fri, 30 Jun 2017 00:54:07 +0000
Subject: [PATCH 5/6] i2c: pca-platform: use device_property_read_u32
Message-Id: <20170630005408.23968-6-chris.packham@alliedtelesis.co.nz>
List-Id: <linux-sh.vger.kernel.org>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa@the-dreams.de, andy.shevchenko@gmail.com, linux-i2c@vger.kernel.org
Cc: ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>, linux-kernel@vger.kernel.org

Use device_property_read_u32 instead of of_property_read_u32_index to
lookup the "clock-frequency" property.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-pca-platform.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 1e3c247de8f8..80420f753a87 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -176,13 +176,12 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	if (platform_data) {
 		i2c->adap.timeout = platform_data->timeout;
 		i2c->algo_data.i2c_clock = platform_data->i2c_clock_speed;
-	} else if (np) {
-		i2c->adap.timeout = HZ;
-		of_property_read_u32_index(np, "clock-frequency", 0,
-					   &i2c->algo_data.i2c_clock);
 	} else {
 		i2c->adap.timeout = HZ;
-		i2c->algo_data.i2c_clock = 59000;
+		ret = device_property_read_u32(&pdev->dev, "clock-frequency",
+					       &i2c->algo_data.i2c_clock);
+		if (ret)
+			i2c->algo_data.i2c_clock = 59000;
 	}
 
 	i2c->gpio = devm_gpiod_get_optional(&pdev->dev, "reset-gpios", GPIOD_OUT_LOW);
-- 
2.13.0

