From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Mon, 25 May 2009 09:53:40 +0000
Subject: [PATCH 3/5] net: sh_eth: fix receive desciptor loop
Message-Id: <4A1A6AA4.3030507@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: SH-Linux <linux-sh@vger.kernel.org>, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Fix the problem that this driver not update rxdesc in sh_eth_rx.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 drivers/net/sh_eth.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index eb76835..728c419 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -536,6 +536,7 @@ static int sh_eth_rx(struct net_device *ndev)
 		}
 		rxdesc->status |= cpu_to_edmac(mdp, RD_RACT);
 		entry = (++mdp->cur_rx) % RX_RING_SIZE;
+		rxdesc = &mdp->rx_ring[entry];
 	}

 	/* Refill the Rx ring buffers. */
-- 
1.5.5

