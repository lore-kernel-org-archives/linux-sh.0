From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 03 Nov 2015 21:17:08 +0000
Subject: [PATCH] sh_eth: kill 'ret' variable in sh_eth_ring_init()
Message-Id: <3103690.zc6n37veWQ@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

The 'ret' local variable in sh_eth_ring_init() serves no useful purpose as
the only  values it gets assigned are 0 and -ENOMEM both of which could be
returned directly...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against DaveM's 'net-next.git' repo.

 drivers/net/ethernet/renesas/sh_eth.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -1199,7 +1199,7 @@ static void sh_eth_ring_format(struct ne
 static int sh_eth_ring_init(struct net_device *ndev)
 {
 	struct sh_eth_private *mdp = netdev_priv(ndev);
-	int rx_ringsize, tx_ringsize, ret = 0;
+	int rx_ringsize, tx_ringsize;
 
 	/* +26 gets the maximum ethernet encapsulation, +7 & ~7 because the
 	 * card needs room to do 8 byte alignment, +2 so we can reserve
@@ -1214,26 +1214,20 @@ static int sh_eth_ring_init(struct net_d
 	/* Allocate RX and TX skb rings */
 	mdp->rx_skbuff = kcalloc(mdp->num_rx_ring, sizeof(*mdp->rx_skbuff),
 				 GFP_KERNEL);
-	if (!mdp->rx_skbuff) {
-		ret = -ENOMEM;
-		return ret;
-	}
+	if (!mdp->rx_skbuff)
+		return -ENOMEM;
 
 	mdp->tx_skbuff = kcalloc(mdp->num_tx_ring, sizeof(*mdp->tx_skbuff),
 				 GFP_KERNEL);
-	if (!mdp->tx_skbuff) {
-		ret = -ENOMEM;
+	if (!mdp->tx_skbuff)
 		goto skb_ring_free;
-	}
 
 	/* Allocate all Rx descriptors. */
 	rx_ringsize = sizeof(struct sh_eth_rxdesc) * mdp->num_rx_ring;
 	mdp->rx_ring = dma_alloc_coherent(NULL, rx_ringsize, &mdp->rx_desc_dma,
 					  GFP_KERNEL);
-	if (!mdp->rx_ring) {
-		ret = -ENOMEM;
+	if (!mdp->rx_ring)
 		goto skb_ring_free;
-	}
 
 	mdp->dirty_rx = 0;
 
@@ -1241,11 +1235,9 @@ static int sh_eth_ring_init(struct net_d
 	tx_ringsize = sizeof(struct sh_eth_txdesc) * mdp->num_tx_ring;
 	mdp->tx_ring = dma_alloc_coherent(NULL, tx_ringsize, &mdp->tx_desc_dma,
 					  GFP_KERNEL);
-	if (!mdp->tx_ring) {
-		ret = -ENOMEM;
+	if (!mdp->tx_ring)
 		goto desc_ring_free;
-	}
-	return ret;
+	return 0;
 
 desc_ring_free:
 	/* free DMA buffer */
@@ -1257,7 +1249,7 @@ skb_ring_free:
 	mdp->tx_ring = NULL;
 	mdp->rx_ring = NULL;
 
-	return ret;
+	return -ENOMEM;
 }
 
 static void sh_eth_free_dma_buffer(struct sh_eth_private *mdp)

