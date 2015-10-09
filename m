From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 09 Oct 2015 06:54:50 +0000
Subject: [PATCH 1/4] i2c: designware-platdrv: enable RuntimePM before registering to the core
Message-Id: <1444373693-2372-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The core may register clients attached to this master which may use
funtionality from the master. So, RuntimePM must be enabled before, otherwise
this will fail.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Not tested on HW. Found by code review.

 drivers/i2c/busses/i2c-designware-platdrv.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 3dd2de31a2f8d3..920d35ab5cd5d1 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -253,12 +253,6 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
 
-	r = i2c_add_numbered_adapter(adap);
-	if (r) {
-		dev_err(&pdev->dev, "failure adding adapter\n");
-		return r;
-	}
-
 	if (dev->pm_runtime_disabled) {
 		pm_runtime_forbid(&pdev->dev);
 	} else {
@@ -268,6 +262,12 @@ static int dw_i2c_probe(struct platform_device *pdev)
 		pm_runtime_enable(&pdev->dev);
 	}
 
+	r = i2c_add_numbered_adapter(adap);
+	if (r) {
+		dev_err(&pdev->dev, "failure adding adapter\n");
+		return r;
+	}
+
 	return 0;
 }
 
-- 
2.1.4

