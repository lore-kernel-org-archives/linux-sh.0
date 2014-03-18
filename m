From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 18 Mar 2014 23:25:56 +0000
Subject: [PATCH/RFC 5/5] sh_eth: Remove goto statements that jump straight to a return
Message-Id: <1395185156-6681-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

"goto" is well accepted for error paths in the kernel but should not be
used unnecessarily. Return the correct value directly instead of using a
goto when possible.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/net/ethernet/renesas/sh_eth.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index d8cc78c..e31a395 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -872,7 +872,7 @@ static int sh_eth_reset(struct net_device *ndev)
 
 		ret = sh_eth_check_reset(ndev);
 		if (ret)
-			goto out;
+			return ret;
 
 		/* Table Init */
 		sh_eth_write(ndev, 0x0, TDLAR);
@@ -899,7 +899,6 @@ static int sh_eth_reset(struct net_device *ndev)
 			     EDMR);
 	}
 
-out:
 	return ret;
 }
 
@@ -1263,7 +1262,7 @@ static int sh_eth_dev_init(struct net_device *ndev, bool start)
 	/* Soft Reset */
 	ret = sh_eth_reset(ndev);
 	if (ret)
-		goto out;
+		return ret;
 
 	if (mdp->cd->rmiimode)
 		sh_eth_write(ndev, 0x1, RMIIMODE);
@@ -1342,7 +1341,6 @@ static int sh_eth_dev_init(struct net_device *ndev, bool start)
 		netif_start_queue(ndev);
 	}
 
-out:
 	return ret;
 }
 
@@ -2613,10 +2611,8 @@ static int sh_mdio_init(struct sh_eth_private *mdp, int id,
 
 	/* create bit control struct for PHY */
 	bitbang = devm_kzalloc(dev, sizeof(struct bb_info), GFP_KERNEL);
-	if (!bitbang) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!bitbang)
+		return -ENOMEM;
 
 	/* bitbang init */
 	bitbang->addr = mdp->addr + mdp->reg_offset[PIR];
@@ -2629,10 +2625,8 @@ static int sh_mdio_init(struct sh_eth_private *mdp, int id,
 
 	/* MII controller setting */
 	mdp->mii_bus = alloc_mdio_bitbang(&bitbang->ctrl);
-	if (!mdp->mii_bus) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!mdp->mii_bus)
+		return -ENOMEM;
 
 	/* Hook up MII support for ethtool */
 	mdp->mii_bus->name = "sh_mii";
@@ -2667,8 +2661,6 @@ static int sh_mdio_init(struct sh_eth_private *mdp, int id,
 
 out_free_bus:
 	free_mdio_bitbang(mdp->mii_bus);
-
-out:
 	return ret;
 }
 
@@ -2782,15 +2774,12 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (unlikely(res = NULL)) {
 		dev_err(&pdev->dev, "invalid resource\n");
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	ndev = alloc_etherdev(sizeof(struct sh_eth_private));
-	if (!ndev) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!ndev)
+		return -ENOMEM;
 
 	/* The sh Ether-specific entries in the device structure. */
 	ndev->base_addr = res->start;
@@ -2925,7 +2914,6 @@ out_release:
 	if (ndev)
 		free_netdev(ndev);
 
-out:
 	return ret;
 }
 
-- 
1.8.3.2

