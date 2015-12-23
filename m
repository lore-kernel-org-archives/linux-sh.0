From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 23 Dec 2015 17:19:29 +0000
Subject: [PATCH 2/2] i2c: s3c2410: remove superfluous runtime PM calls
Message-Id: <1450891169-13708-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

RuntimePM of the adapter device is now taken care of by the core. So, we
can remove these calls.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-s3c2410.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 5df819610d5280..362a6de548336b 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -784,7 +784,6 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
 	int retry;
 	int ret;
 
-	pm_runtime_get_sync(&adap->dev);
 	ret = clk_enable(i2c->clk);
 	if (ret)
 		return ret;
@@ -795,7 +794,6 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
 
 		if (ret != -EAGAIN) {
 			clk_disable(i2c->clk);
-			pm_runtime_put(&adap->dev);
 			return ret;
 		}
 
@@ -805,7 +803,6 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
 	}
 
 	clk_disable(i2c->clk);
-	pm_runtime_put(&adap->dev);
 	return -EREMOTEIO;
 }
 
@@ -1256,8 +1253,6 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pm_runtime_enable(&i2c->adap.dev);
-
 	dev_info(&pdev->dev, "%s: S3C I2C adapter\n", dev_name(&i2c->adap.dev));
 	return 0;
 }
@@ -1273,7 +1268,6 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
 
 	clk_unprepare(i2c->clk);
 
-	pm_runtime_disable(&i2c->adap.dev);
 	pm_runtime_disable(&pdev->dev);
 
 	s3c24xx_i2c_deregister_cpufreq(i2c);
-- 
2.1.4

