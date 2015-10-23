From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 23 Oct 2015 21:46:40 +0000
Subject: [PATCH 2/2] sh_eth: fix RX buffer size calculation
Message-Id: <1571476.HbCo5gVB8j@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2249923.hKhT9K6gME@wasted.cogentembedded.com>
In-Reply-To: <2249923.hKhT9K6gME@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

The RX buffer size calulation failed to account for the length granularity
(which is now 32 bytes)...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: net/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net/drivers/net/ethernet/renesas/sh_eth.c
@@ -1127,7 +1127,7 @@ static void sh_eth_ring_format(struct ne
 	struct sh_eth_txdesc *txdesc = NULL;
 	int rx_ringsize = sizeof(*rxdesc) * mdp->num_rx_ring;
 	int tx_ringsize = sizeof(*txdesc) * mdp->num_tx_ring;
-	int skbuff_size = mdp->rx_buf_sz + SH_ETH_RX_ALIGN - 1;
+	int skbuff_size = mdp->rx_buf_sz + SH_ETH_RX_ALIGN + 32 - 1;
 	dma_addr_t dma_addr;
 
 	mdp->cur_rx = 0;
@@ -1450,7 +1450,7 @@ static int sh_eth_rx(struct net_device *
 	struct sk_buff *skb;
 	u16 pkt_len = 0;
 	u32 desc_status;
-	int skbuff_size = mdp->rx_buf_sz + SH_ETH_RX_ALIGN - 1;
+	int skbuff_size = mdp->rx_buf_sz + SH_ETH_RX_ALIGN + 32 - 1;
 	dma_addr_t dma_addr;
 
 	boguscnt = min(boguscnt, *quota);

