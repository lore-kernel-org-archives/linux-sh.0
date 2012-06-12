From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 12 Jun 2012 05:18:53 +0000
Subject: [PATCH net-next 1/5] net: sh_eth: remove unnecessary function
Message-Id: <4FD6D13D.50701@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev <netdev@vger.kernel.org>
Cc: SH-Linux <linux-sh@vger.kernel.org>

The sh_eth_timer() called mod_timer() for itself.
So, this patch removes the function.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/net/ethernet/renesas/sh_eth.c |   22 ----------------------
 drivers/net/ethernet/renesas/sh_eth.h |    1 -
 2 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 667169b..4ccfd0f 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -1291,14 +1291,6 @@ other_irq:
 	return ret;
 }

-static void sh_eth_timer(unsigned long data)
-{
-	struct net_device *ndev = (struct net_device *)data;
-	struct sh_eth_private *mdp = netdev_priv(ndev);
-
-	mod_timer(&mdp->timer, jiffies + (10 * HZ));
-}
-
 /* PHY state control function */
 static void sh_eth_adjust_link(struct net_device *ndev)
 {
@@ -1546,11 +1538,6 @@ static int sh_eth_open(struct net_device *ndev)
 	if (ret)
 		goto out_free_irq;

-	/* Set the timer to check for link beat. */
-	init_timer(&mdp->timer);
-	mdp->timer.expires = (jiffies + (24 * HZ)) / 10;/* 2.4 sec. */
-	setup_timer(&mdp->timer, sh_eth_timer, (unsigned long)ndev);
-
 	return ret;

 out_free_irq:
@@ -1575,9 +1562,6 @@ static void sh_eth_tx_timeout(struct net_device *ndev)
 	/* tx_errors count up */
 	ndev->stats.tx_errors++;

-	/* timer off */
-	del_timer_sync(&mdp->timer);
-
 	/* Free all the skbuffs in the Rx queue. */
 	for (i = 0; i < RX_RING_SIZE; i++) {
 		rxdesc = &mdp->rx_ring[i];
@@ -1595,10 +1579,6 @@ static void sh_eth_tx_timeout(struct net_device *ndev)

 	/* device init */
 	sh_eth_dev_init(ndev);
-
-	/* timer on */
-	mdp->timer.expires = (jiffies + (24 * HZ)) / 10;/* 2.4 sec. */
-	add_timer(&mdp->timer);
 }

 /* Packet transmit function */
@@ -1671,8 +1651,6 @@ static int sh_eth_close(struct net_device *ndev)

 	free_irq(ndev->irq, ndev);

-	del_timer_sync(&mdp->timer);
-
 	/* Free all the skbuffs in the Rx queue. */
 	sh_eth_ring_free(ndev);

diff --git a/drivers/net/ethernet/renesas/sh_eth.h b/drivers/net/ethernet/renesas/sh_eth.h
index 57b8e1f..9e8e4d5 100644
--- a/drivers/net/ethernet/renesas/sh_eth.h
+++ b/drivers/net/ethernet/renesas/sh_eth.h
@@ -771,7 +771,6 @@ struct sh_eth_private {
 	struct sh_eth_txdesc *tx_ring;
 	struct sk_buff **rx_skbuff;
 	struct sk_buff **tx_skbuff;
-	struct timer_list timer;
 	spinlock_t lock;
 	u32 cur_rx, dirty_rx;	/* Producer/consumer ring indices */
 	u32 cur_tx, dirty_tx;
-- 
1.7.1
