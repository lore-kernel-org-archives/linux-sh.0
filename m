From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 06 Jul 2011 06:33:51 +0000
Subject: [PATCH 1/2] net: sh_eth: fix cannot work half-duplex mode
Message-Id: <4E1401CF.4080804@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

When link was down, the bit of DM in ECMR was always set.
So, we could not use half-duplex mode on the controller.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/net/sh_eth.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 09b5aa8..c08d9e1 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -1185,8 +1185,8 @@ static void sh_eth_adjust_link(struct net_device *ndev)
 				mdp->cd->set_rate(ndev);
 		}
 		if (mdp->link = PHY_DOWN) {
-			sh_eth_write(ndev, (sh_eth_read(ndev, ECMR) & ~ECMR_TXF)
-					| ECMR_DM, ECMR);
+			sh_eth_write(ndev,
+				(sh_eth_read(ndev, ECMR) & ~ECMR_TXF), ECMR);
 			new_state = 1;
 			mdp->link = phydev->link;
 		}
-- 
1.7.1

