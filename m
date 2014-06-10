From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 10 Jun 2014 00:40:24 +0000
Subject: [PATCH v2 2/2] net: sh_eth: Fix timing of RACT setting in sh_eth_rx()
Message-Id: <539653F8.6020603@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

This patch fixes an issue that we cannot use nfs rootfs correctly
on r8a7790 when the command below runs on a host PC.

 $ sudo ping -f -l 8 $BOARD_IP_ADDR

Since the driver sets the RACT to 1 in the first while loop of
sh_eth_rx(), the controller accepts a next frame into the next RX
descriptor during the while loop. But, in the first while loop
doesn't allocate a next skb. So, this patch removes the RACT setting
in the first while loop of sh_eth_rx().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/net/ethernet/renesas/sh_eth.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 5761f8c..621c581 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -1460,7 +1460,6 @@ static int sh_eth_rx(struct net_device *ndev, u32 intr_status, int *quota)
 			ndev->stats.rx_packets++;
 			ndev->stats.rx_bytes += pkt_len;
 		}
-		rxdesc->status |= cpu_to_edmac(mdp, RD_RACT);
 		entry = (++mdp->cur_rx) % mdp->num_rx_ring;
 		rxdesc = &mdp->rx_ring[entry];
 	}
-- 
1.7.9.5

