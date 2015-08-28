From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 28 Aug 2015 13:55:10 +0000
Subject: [PATCH 1/2] ravb: propagate platform_get_irq() error upstream
Message-Id: <1625516.DmSERANoIv@wasted.cogentembedded.com>
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
 drivers/net/ethernet/renesas/ravb_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: net/drivers/net/ethernet/renesas/ravb_main.c
=================================--- net.orig/drivers/net/ethernet/renesas/ravb_main.c
+++ net/drivers/net/ethernet/renesas/ravb_main.c
@@ -1643,7 +1643,7 @@ static int ravb_probe(struct platform_de
 	ndev->dma = -1;
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		error = -ENODEV;
+		error = irq;
 		goto out_release;
 	}
 	ndev->irq = irq;

