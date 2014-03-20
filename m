From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 20 Mar 2014 13:59:06 +0000
Subject: [PATCH 4/5] sh_eth: Register MDIO bus before registering the network device
Message-Id: <1395324035-22918-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395324035-22918-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1395324035-22918-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Ben Dooks <ben.dooks@codethink.co.uk>

Network API functions that rely on the MDIO bus can be called as soon as
the driver calls register_netdev(). Register the MDIO bus before the
network device to avoid race conditions.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/net/ethernet/renesas/sh_eth.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index e9224f2..ace6da2 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2891,6 +2891,13 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* MDIO bus init */
+	ret = sh_mdio_init(mdp, pd);
+	if (ret) {
+		dev_err(&ndev->dev, "failed to initialise MDIO\n");
+		goto out_release;
+	}
+
 	netif_napi_add(ndev, &mdp->napi, sh_eth_poll, 64);
 
 	/* network device register */
@@ -2898,13 +2905,6 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_napi_del;
 
-	/* mdio bus init */
-	ret = sh_mdio_init(mdp, pd);
-	if (ret) {
-		dev_err(&ndev->dev, "failed to initialise MDIO\n");
-		goto out_unregister;
-	}
-
 	/* print device information */
 	netdev_info(ndev, "Base address at 0x%x, %pM, IRQ %d.\n",
 		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
@@ -2913,11 +2913,9 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 
 	return ret;
 
-out_unregister:
-	unregister_netdev(ndev);
-
 out_napi_del:
 	netif_napi_del(&mdp->napi);
+	sh_mdio_release(mdp);
 
 out_release:
 	/* net_dev free */
@@ -2933,9 +2931,9 @@ static int sh_eth_drv_remove(struct platform_device *pdev)
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

