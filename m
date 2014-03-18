From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 18 Mar 2014 23:25:55 +0000
Subject: [PATCH/RFC 4/5] sh_eth: Register MDIO bus before registering the network device
Message-Id: <1395185156-6681-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Network API functions that rely on the MDIO bus can be called as soon as
the driver calls register_netdev(). Register the MDIO bus before the
network device to avoid race conditions.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/net/ethernet/renesas/sh_eth.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 55715f3..d8cc78c 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2894,6 +2894,13 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* MDIO bus init */
+	ret = sh_mdio_init(mdp, pdev->id, pd);
+	if (ret) {
+		dev_err(&ndev->dev, "failed to initialise MDIO\n");
+		goto out_release;
+	}
+
 	netif_napi_add(ndev, &mdp->napi, sh_eth_poll, 64);
 
 	/* network device register */
@@ -2901,13 +2908,6 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_napi_del;
 
-	/* mdio bus init */
-	ret = sh_mdio_init(mdp, pdev->id, pd);
-	if (ret) {
-		dev_err(&ndev->dev, "failed to initialise MDIO\n");
-		goto out_unregister;
-	}
-
 	/* print device information */
 	pr_info("Base address at 0x%x, %pM, IRQ %d.\n",
 		(u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
@@ -2916,11 +2916,9 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 
 	return ret;
 
-out_unregister:
-	unregister_netdev(ndev);
-
 out_napi_del:
 	netif_napi_del(&mdp->napi);
+	sh_mdio_release(mdp);
 
 out_release:
 	/* net_dev free */
@@ -2936,9 +2934,9 @@ static int sh_eth_drv_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct sh_eth_private *mdp = netdev_priv(ndev);
 
-	sh_mdio_release(mdp);
 	unregister_netdev(ndev);
 	netif_napi_del(&mdp->napi);
+	sh_mdio_release(mdp);
 	pm_runtime_disable(&pdev->dev);
 	free_netdev(ndev);
 
-- 
1.8.3.2

