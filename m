From: Sasha Levin <sashal@kernel.org>
Date: Thu, 29 Aug 2019 18:17:58 +0000
Subject: [PATCH AUTOSEL 4.4 11/15] ravb: Fix use-after-free ravb_tstamp_skb
Message-Id: <20190829181802.9619-11-sashal@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20190829181802.9619-1-sashal@kernel.org>
In-Reply-To: <20190829181802.9619-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Tho Vu <tho.vu.wh@rvc.renesas.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Simon Horman <horms+renesas@verge.net.au>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Tho Vu <tho.vu.wh@rvc.renesas.com>

[ Upstream commit cfef46d692efd852a0da6803f920cc756eea2855 ]

When a Tx timestamp is requested, a pointer to the skb is stored in the
ravb_tstamp_skb struct. This was done without an skb_get. There exists
the possibility that the skb could be freed by ravb_tx_free (when
ravb_tx_free is called from ravb_start_xmit) before the timestamp was
processed, leading to a use-after-free bug.

Use skb_get when filling a ravb_tstamp_skb struct, and add appropriate
frees/consumes when a ravb_tstamp_skb struct is freed.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Tho Vu <tho.vu.wh@rvc.renesas.com>
Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 29d31eb995d7f..fedfd94699cb8 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1,6 +1,6 @@
 /* Renesas Ethernet AVB device driver
  *
- * Copyright (C) 2014-2015 Renesas Electronics Corporation
+ * Copyright (C) 2014-2019 Renesas Electronics Corporation
  * Copyright (C) 2015 Renesas Solutions Corp.
  * Copyright (C) 2015 Cogent Embedded, Inc. <source@cogentembedded.com>
  *
@@ -501,7 +501,10 @@ static void ravb_get_tx_tstamp(struct net_device *ndev)
 			kfree(ts_skb);
 			if (tag = tfa_tag) {
 				skb_tstamp_tx(skb, &shhwtstamps);
+				dev_consume_skb_any(skb);
 				break;
+			} else {
+				dev_kfree_skb_any(skb);
 			}
 		}
 		ravb_write(ndev, ravb_read(ndev, TCCR) | TCCR_TFR, TCCR);
@@ -1382,7 +1385,7 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 					 DMA_TO_DEVICE);
 			goto unmap;
 		}
-		ts_skb->skb = skb;
+		ts_skb->skb = skb_get(skb);
 		ts_skb->tag = priv->ts_skb_tag++;
 		priv->ts_skb_tag &= 0x3ff;
 		list_add_tail(&ts_skb->list, &priv->ts_skb_list);
@@ -1514,6 +1517,7 @@ static int ravb_close(struct net_device *ndev)
 	/* Clear the timestamp list */
 	list_for_each_entry_safe(ts_skb, ts_skb2, &priv->ts_skb_list, list) {
 		list_del(&ts_skb->list);
+		kfree_skb(ts_skb->skb);
 		kfree(ts_skb);
 	}
 
-- 
2.20.1
