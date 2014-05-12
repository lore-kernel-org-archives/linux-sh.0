From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 12 May 2014 22:30:14 +0000
Subject: [PATCH v2] sh_eth: replace devm_kzalloc() with devm_kmalloc_array()
Message-Id: <201405130230.14743.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

When I was converting the driver to the managed device API, only devm_kzalloc()
was available for memory allocation, so I had to use it, despite zeroing out the
PHY IRQ array right before initializing all  its entries to PHY_POLL was quite
stupid.   Now that devm_kmalloc_array() has become available, we can avoid the
needless zeroing out...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against DaveM's 'net-next.git' repo.

Changes in version 2:
- switched to calling devm_kmalloc_array().

 drivers/net/ethernet/renesas/sh_eth.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: renesas/drivers/net/ethernet/renesas/sh_eth.c
=================================--- renesas.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ renesas/drivers/net/ethernet/renesas/sh_eth.c
@@ -2627,8 +2627,8 @@ static int sh_mdio_init(struct sh_eth_pr
 		 pdev->name, pdev->id);
 
 	/* PHY IRQ */
-	mdp->mii_bus->irq = devm_kzalloc(dev, sizeof(int) * PHY_MAX_ADDR,
-					 GFP_KERNEL);
+	mdp->mii_bus->irq = devm_kmalloc_array(dev, PHY_MAX_ADDR, sizeof(int),
+					       GFP_KERNEL);
 	if (!mdp->mii_bus->irq) {
 		ret = -ENOMEM;
 		goto out_free_bus;
