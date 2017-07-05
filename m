From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Wed, 05 Jul 2017 10:13:57 +0000
Subject: [PATCH v2 3/4] i2c: pca-platform: use device_property_read_u32
Message-Id: <20170705101358.17458-4-chris.packham@alliedtelesis.co.nz>
List-Id: <linux-sh.vger.kernel.org>
References: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa@the-dreams.de, ysato@users.sourceforge.jp, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>

Use device_property_read_u32 instead of of_property_read_u32_index to
lookup the "clock-frequency" property.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- move call to device_property_read_u32 to above platform_data usage.
  This allows the device property/device tree to go first and
  platform_data (if present) can override things. Eventually when all
  the platforms using this driver are converted to either use device
  properties or a device tree then the platform_data can simply be
  deleted.

 drivers/i2c/busses/i2c-pca-platform.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index b90193d09d4b..bc2707ffd409 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -177,16 +177,15 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	if (IS_ERR(i2c->gpio))
 		return PTR_ERR(i2c->gpio);
 
+	i2c->adap.timeout = HZ;
+	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
+				       &i2c->algo_data.i2c_clock);
+	if (ret)
+		i2c->algo_data.i2c_clock = 59000;
+
 	if (platform_data) {
 		i2c->adap.timeout = platform_data->timeout;
 		i2c->algo_data.i2c_clock = platform_data->i2c_clock_speed;
-	} else if (np) {
-		i2c->adap.timeout = HZ;
-		of_property_read_u32_index(np, "clock-frequency", 0,
-					   &i2c->algo_data.i2c_clock);
-	} else {
-		i2c->adap.timeout = HZ;
-		i2c->algo_data.i2c_clock = 59000;
 	}
 
 	i2c->algo_data.data = i2c;
-- 
2.13.0

