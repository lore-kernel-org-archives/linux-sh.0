From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 18 Mar 2014 23:25:52 +0000
Subject: [PATCH/RFC 1/5] sh_eth: Use the platform device for memory allocation
Message-Id: <1395185156-6681-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Memory allocated for the MDIO bus with the devm_kzalloc() API is
associated with the network device. While this will cause memory to be
freed at the right time, it doesn't allow allocating memory before the
network device is initialized.

Replace the network device with the parent platform device for memory
allocation to remove that dependency. This also improves consistency
with the other devm_* calls in the driver that all use the platform
device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/net/ethernet/renesas/sh_eth.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index be7211d..b80abb6 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2615,10 +2615,10 @@ static int sh_mdio_init(struct net_device *ndev, int id,
 	int ret, i;
 	struct bb_info *bitbang;
 	struct sh_eth_private *mdp = netdev_priv(ndev);
+	struct device *dev = &mdp->pdev->dev;
 
 	/* create bit control struct for PHY */
-	bitbang = devm_kzalloc(&ndev->dev, sizeof(struct bb_info),
-			       GFP_KERNEL);
+	bitbang = devm_kzalloc(dev, sizeof(struct bb_info), GFP_KERNEL);
 	if (!bitbang) {
 		ret = -ENOMEM;
 		goto out;
@@ -2647,8 +2647,7 @@ static int sh_mdio_init(struct net_device *ndev, int id,
 		 mdp->pdev->name, id);
 
 	/* PHY IRQ */
-	mdp->mii_bus->irq = devm_kzalloc(&ndev->dev,
-					 sizeof(int) * PHY_MAX_ADDR,
+	mdp->mii_bus->irq = devm_kzalloc(dev, sizeof(int) * PHY_MAX_ADDR,
 					 GFP_KERNEL);
 	if (!mdp->mii_bus->irq) {
 		ret = -ENOMEM;
-- 
1.8.3.2

