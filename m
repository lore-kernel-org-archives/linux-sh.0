From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Tue, 18 Nov 2008 06:29:58 +0000
Subject: [PATCH  v2.6.28] sh: sh_eth: Update to change of mii_bus
Message-Id: <492260E6.5010305@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: Linux-sh <linux-sh@vger.kernel.org>

Update to change of mii_bus interface and fix some warning.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 drivers/net/sh_eth.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index a24bb68..59f242a 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -927,7 +927,7 @@ static int sh_eth_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	struct sh_eth_private *mdp = netdev_priv(ndev);
 	struct sh_eth_txdesc *txdesc;
 	u32 entry;
-	int flags;
+	unsigned long flags;

 	spin_lock_irqsave(&mdp->lock, flags);
 	if ((mdp->cur_tx - mdp->dirty_tx) >= (TX_RING_SIZE - 4)) {
@@ -1141,7 +1141,7 @@ static int sh_mdio_init(struct net_device *ndev, int id)
 	/* Hook up MII support for ethtool */
 	mdp->mii_bus->name = "sh_mii";
 	mdp->mii_bus->parent = &ndev->dev;
-	mdp->mii_bus->id[0] = id;
+	snprintf(mdp->mii_bus->id, MII_BUS_ID_SIZE, "%x", id);

 	/* PHY IRQ */
 	mdp->mii_bus->irq = kmalloc(sizeof(int)*PHY_MAX_ADDR, GFP_KERNEL);
-- 
1.5.6.5
