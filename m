From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue, 08 Dec 2015 18:39:29 +0000
Subject: [PATCH net-next] ravb: ptp: fix misplaced ravb_ptp_stop() calling in ravb_probe()
Message-Id: <1449599969-20628-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

'commit <f5d7837f96e5> ("ravb: ptp: Add CONFIG mode support")' added
a calling of ravb_ptp_stop() in a wrong place in ravb_probe().

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the master branch of David Miller's next networking
tree.

Compile tested only.

 drivers/net/ethernet/renesas/ravb_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 1cf1226..93be519 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1875,12 +1875,12 @@ out_napi_del:
 	netif_napi_del(&priv->napi[RAVB_BE]);
 	ravb_mdio_release(priv);
 out_dma_free:
-	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
-			  priv->desc_bat_dma);
-
 	/* Stop PTP Clock driver */
 	if (chip_id != RCAR_GEN2)
 		ravb_ptp_stop(ndev);
+
+	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
+			  priv->desc_bat_dma);
 out_release:
 	if (ndev)
 		free_netdev(ndev);
-- 
1.9.1

