From: roel kluin <roel.kluin@gmail.com>
Date: Wed, 10 Sep 2008 17:22:44 +0000
Subject: [PATCH] sh_eth: unsigned ndev->irq cannot be negative
Message-Id: <48C80264.2070205@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

unsigned ndev->irq cannot be negative

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 6a06b95..c52cc82 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -1182,11 +1182,12 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 		devno = 0;
 
 	ndev->dma = -1;
-	ndev->irq = platform_get_irq(pdev, 0);
-	if (ndev->irq < 0) {
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
 		ret = -ENODEV;
 		goto out_release;
 	}
+	ndev->irq = ret;
 
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
