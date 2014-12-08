From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Mon, 08 Dec 2014 10:46:21 +0000
Subject: [PATCH v2] sh_eth: Remove redundant alignment adjustment
Message-Id: <1418035581-3805-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>

PTR_ALIGN macro after skb_reserve is redundant, because skb_reserve
function adjusts the alignment of skb->data.

Signed-off-by: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This series is based on net-next tree.

v2 [Yoshihiro Kaneko]
* re-spin for net-next.

 drivers/net/ethernet/renesas/sh_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index dbe8606..a0e737f 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -1141,7 +1141,7 @@ static void sh_eth_ring_format(struct net_device *ndev)
 
 		/* RX descriptor */
 		rxdesc = &mdp->rx_ring[i];
-		rxdesc->addr = virt_to_phys(PTR_ALIGN(skb->data, 4));
+		rxdesc->addr = virt_to_phys(skb->data);
 		rxdesc->status = cpu_to_edmac(mdp, RD_RACT | RD_RFP);
 
 		/* The size of the buffer is 16 byte boundary. */
@@ -1477,7 +1477,7 @@ static int sh_eth_rx(struct net_device *ndev, u32 intr_status, int *quota)
 			sh_eth_set_receive_align(skb);
 
 			skb_checksum_none_assert(skb);
-			rxdesc->addr = virt_to_phys(PTR_ALIGN(skb->data, 4));
+			rxdesc->addr = virt_to_phys(skb->data);
 		}
 		if (entry >= mdp->num_rx_ring - 1)
 			rxdesc->status |-- 
1.9.1

