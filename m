From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 13 Dec 2015 18:27:04 +0000
Subject: [PATCH] sh_eth: fix TX buffer byte-swapping
Message-Id: <4052048.4A561jYI0l@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

For the little-endian SH771x kernels the driver has to byte-swap the RX/TX
buffers,  however yet unset physcial address from the TX descriptor is used
to call sh_eth_soft_swap(). Use 'skb->data' instead...

Fixes: 31fcb99d9958 ("net: sh_eth: remove __flush_purge_region")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Dave Miller's 'net.git' repo.
Although there have been no complaints during 4+ years of this being broken,
I  think it's  probably  worth queuing the patch for  the stable trees...

 drivers/net/ethernet/renesas/sh_eth.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: net/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net/drivers/net/ethernet/renesas/sh_eth.c
@@ -2372,8 +2372,7 @@ static int sh_eth_start_xmit(struct sk_b
 	txdesc = &mdp->tx_ring[entry];
 	/* soft swap. */
 	if (!mdp->cd->hw_swap)
-		sh_eth_soft_swap(phys_to_virt(ALIGN(txdesc->addr, 4)),
-				 skb->len + 2);
+		sh_eth_soft_swap(PTR_ALIGN(skb->data, 4), skb->len + 2);
 	txdesc->addr = dma_map_single(&ndev->dev, skb->data, skb->len,
 				      DMA_TO_DEVICE);
 	if (dma_mapping_error(&ndev->dev, txdesc->addr)) {

