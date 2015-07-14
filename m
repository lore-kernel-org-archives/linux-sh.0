From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 14 Jul 2015 21:56:52 +0000
Subject: [PATCH] ravb: do not invalidate cache for RX buffer twice
Message-Id: <4759713.2ulGRKsd9L@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

First, dma_sync_single_for_cpu() shouldn't have been called in the first place
(it's a streaming DMA API). dma_unmap_single() should have been called instead.
Second, dma_unmap_single() call after handing the buffer to napi_gro_receive()
makes little sense.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Dave Miller's 'net.git' repo.

Don't know why I missed this DMA API misuse while working on the driver. :-<

 drivers/net/ethernet/renesas/ravb_main.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

Index: net/drivers/net/ethernet/renesas/ravb_main.c
=================================--- net.orig/drivers/net/ethernet/renesas/ravb_main.c
+++ net/drivers/net/ethernet/renesas/ravb_main.c
@@ -543,10 +543,9 @@ static bool ravb_rx(struct net_device *n
 
 			skb = priv->rx_skb[q][entry];
 			priv->rx_skb[q][entry] = NULL;
-			dma_sync_single_for_cpu(&ndev->dev,
-						le32_to_cpu(desc->dptr),
-						ALIGN(PKT_BUF_SZ, 16),
-						DMA_FROM_DEVICE);
+			dma_unmap_single(&ndev->dev, le32_to_cpu(desc->dptr),
+					 ALIGN(PKT_BUF_SZ, 16),
+					 DMA_FROM_DEVICE);
 			get_ts &= (q = RAVB_NC) ?
 					RAVB_RXTSTAMP_TYPE_V2_L2_EVENT :
 					~RAVB_RXTSTAMP_TYPE_V2_L2_EVENT;
@@ -584,9 +583,6 @@ static bool ravb_rx(struct net_device *n
 			if (!skb)
 				break;	/* Better luck next round. */
 			ravb_set_buffer_align(skb);
-			dma_unmap_single(&ndev->dev, le32_to_cpu(desc->dptr),
-					 ALIGN(PKT_BUF_SZ, 16),
-					 DMA_FROM_DEVICE);
 			dma_addr = dma_map_single(&ndev->dev, skb->data,
 						  le16_to_cpu(desc->ds_cc),
 						  DMA_FROM_DEVICE);

