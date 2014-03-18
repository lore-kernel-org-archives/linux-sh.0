From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 18 Mar 2014 23:25:54 +0000
Subject: [PATCH/RFC 3/5] sh_eth: Simplify MDIO bus initialization and release
Message-Id: <1395185156-6681-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The network device passed to the sh_mdio_init and sh_mdio_release
functions is only used to access the sh_eth_private instance. Pass it
directly to those functions.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/net/ethernet/renesas/sh_eth.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 7f7085e..55715f3 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2592,29 +2592,23 @@ static void sh_eth_tsu_init(struct sh_eth_private *mdp)
 }
 
 /* MDIO bus release function */
-static int sh_mdio_release(struct net_device *ndev)
+static int sh_mdio_release(struct sh_eth_private *mdp)
 {
-	struct mii_bus *bus = dev_get_drvdata(&ndev->dev);
-
 	/* unregister mdio bus */
-	mdiobus_unregister(bus);
-
-	/* remove mdio bus info from net_device */
-	dev_set_drvdata(&ndev->dev, NULL);
+	mdiobus_unregister(mdp->mii_bus);
 
 	/* free bitbang info */
-	free_mdio_bitbang(bus);
+	free_mdio_bitbang(mdp->mii_bus);
 
 	return 0;
 }
 
 /* MDIO bus init function */
-static int sh_mdio_init(struct net_device *ndev, int id,
+static int sh_mdio_init(struct sh_eth_private *mdp, int id,
 			struct sh_eth_plat_data *pd)
 {
 	int ret, i;
 	struct bb_info *bitbang;
-	struct sh_eth_private *mdp = netdev_priv(ndev);
 	struct device *dev = &mdp->pdev->dev;
 
 	/* create bit control struct for PHY */
@@ -2654,10 +2648,9 @@ static int sh_mdio_init(struct net_device *ndev, int id,
 		goto out_free_bus;
 	}
 
-	/* register mdio bus */
-	if (ndev->dev.parent->of_node) {
-		ret = of_mdiobus_register(mdp->mii_bus,
-					  ndev->dev.parent->of_node);
+	/* register MDIO bus */
+	if (dev->of_node) {
+		ret = of_mdiobus_register(mdp->mii_bus, dev->of_node);
 	} else {
 		for (i = 0; i < PHY_MAX_ADDR; i++)
 			mdp->mii_bus->irq[i] = PHY_POLL;
@@ -2670,8 +2663,6 @@ static int sh_mdio_init(struct net_device *ndev, int id,
 	if (ret)
 		goto out_free_bus;
 
-	dev_set_drvdata(&ndev->dev, mdp->mii_bus);
-
 	return 0;
 
 out_free_bus:
@@ -2911,7 +2902,7 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 		goto out_napi_del;
 
 	/* mdio bus init */
-	ret = sh_mdio_init(ndev, pdev->id, pd);
+	ret = sh_mdio_init(mdp, pdev->id, pd);
 	if (ret) {
 		dev_err(&ndev->dev, "failed to initialise MDIO\n");
 		goto out_unregister;
@@ -2945,7 +2936,7 @@ static int sh_eth_drv_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct sh_eth_private *mdp = netdev_priv(ndev);
 
-	sh_mdio_release(ndev);
+	sh_mdio_release(mdp);
 	unregister_netdev(ndev);
 	netif_napi_del(&mdp->napi);
 	pm_runtime_disable(&pdev->dev);
-- 
1.8.3.2

