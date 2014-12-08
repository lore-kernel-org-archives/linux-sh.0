From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Mon, 08 Dec 2014 10:48:21 +0000
Subject: [PATCH v2] sh_eth: Optimization for RX excess judgement
Message-Id: <1418035701-3871-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>

Both of 'boguscnt' and 'quota' have nearly meaning as the condition of
the reception loop.
In order to cut down redundant processing, this patch changes excess
judgement.

Signed-off-by: Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on net-next tree.

v2 [Yoshihiro Kaneko]
* re-spin for net-next.
* remove unneeded check of "quota".

 drivers/net/ethernet/renesas/sh_eth.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index dbe8606..266c9b2 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -1394,10 +1394,13 @@ static int sh_eth_rx(struct net_device *ndev, u32 intr_status, int *quota)
 
 	int entry = mdp->cur_rx % mdp->num_rx_ring;
 	int boguscnt = (mdp->dirty_rx + mdp->num_rx_ring) - mdp->cur_rx;
+	int limit;
 	struct sk_buff *skb;
 	u16 pkt_len = 0;
 	u32 desc_status;
 
+	boguscnt = min(boguscnt, *quota);
+	limit = boguscnt;
 	rxdesc = &mdp->rx_ring[entry];
 	while (!(rxdesc->status & cpu_to_edmac(mdp, RD_RACT))) {
 		desc_status = edmac_to_cpu(mdp, rxdesc->status);
@@ -1406,11 +1409,6 @@ static int sh_eth_rx(struct net_device *ndev, u32 intr_status, int *quota)
 		if (--boguscnt < 0)
 			break;
 
-		if (*quota <= 0)
-			break;
-
-		(*quota)--;
-
 		if (!(desc_status & RDFEND))
 			ndev->stats.rx_length_errors++;
 
@@ -1501,6 +1499,8 @@ static int sh_eth_rx(struct net_device *ndev, u32 intr_status, int *quota)
 		sh_eth_write(ndev, EDRRR_R, EDRRR);
 	}
 
+	*quota -= limit - boguscnt + 1;
+
 	return *quota <= 0;
 }
 
-- 
1.9.1

