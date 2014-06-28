From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 28 Jun 2014 00:10:00 +0000
Subject: [PATCH] sh_eth: remove checks around dev_kfree_skb() calls
Message-Id: <201406280410.01146.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Since consume_skb() (and hence dev_kfree_skb() macro) checks the passed pointer
for NULL, there's no need to check for NULL before invoking dev_kfree_skb().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Dave Miller's 'net-next.git' repo.

 drivers/net/ethernet/renesas/sh_eth.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -1094,20 +1094,16 @@ static void sh_eth_ring_free(struct net_
 
 	/* Free Rx skb ringbuffer */
 	if (mdp->rx_skbuff) {
-		for (i = 0; i < mdp->num_rx_ring; i++) {
-			if (mdp->rx_skbuff[i])
-				dev_kfree_skb(mdp->rx_skbuff[i]);
-		}
+		for (i = 0; i < mdp->num_rx_ring; i++)
+			dev_kfree_skb(mdp->rx_skbuff[i]);
 	}
 	kfree(mdp->rx_skbuff);
 	mdp->rx_skbuff = NULL;
 
 	/* Free Tx skb ringbuffer */
 	if (mdp->tx_skbuff) {
-		for (i = 0; i < mdp->num_tx_ring; i++) {
-			if (mdp->tx_skbuff[i])
-				dev_kfree_skb(mdp->tx_skbuff[i]);
-		}
+		for (i = 0; i < mdp->num_tx_ring; i++)
+			dev_kfree_skb(mdp->tx_skbuff[i]);
 	}
 	kfree(mdp->tx_skbuff);
 	mdp->tx_skbuff = NULL;
@@ -2077,13 +2073,11 @@ static void sh_eth_tx_timeout(struct net
 		rxdesc = &mdp->rx_ring[i];
 		rxdesc->status = 0;
 		rxdesc->addr = 0xBADF00D0;
-		if (mdp->rx_skbuff[i])
-			dev_kfree_skb(mdp->rx_skbuff[i]);
+		dev_kfree_skb(mdp->rx_skbuff[i]);
 		mdp->rx_skbuff[i] = NULL;
 	}
 	for (i = 0; i < mdp->num_tx_ring; i++) {
-		if (mdp->tx_skbuff[i])
-			dev_kfree_skb(mdp->tx_skbuff[i]);
+		dev_kfree_skb(mdp->tx_skbuff[i]);
 		mdp->tx_skbuff[i] = NULL;
 	}
 
