From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 28 Aug 2015 13:56:01 +0000
Subject: [PATCH 2/2] sh_eth: propagate platform_get_irq() error upstream
Message-Id: <1774140.R12mtes975@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <9944836.IRPmWk4iN8@wasted.cogentembedded.com>
In-Reply-To: <9944836.IRPmWk4iN8@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org, horms@verge.net.au

The driver overrides the error returned by platform_get_irq() with -ENODEV
which e.g. precludes the deferred  probing from working. Propagate the real
error code to the driver core instead.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: net/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net/drivers/net/ethernet/renesas/sh_eth.c
@@ -3089,10 +3089,8 @@ static int sh_eth_drv_probe(struct platf
 
 	ndev->dma = -1;
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		ret = -ENODEV;
+	if (ret < 0)
 		goto out_release;
-	}
 	ndev->irq = ret;
 
 	SET_NETDEV_DEV(ndev, &pdev->dev);

