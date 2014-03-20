From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 20 Mar 2014 13:59:18 +0000
Subject: [PATCH 2/5] sh_eth: Use the platform device as the MDIO bus parent
Message-Id: <1395324035-22918-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395324035-22918-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1395324035-22918-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Ben Dooks <ben.dooks@codethink.co.uk>

The MDIO bus parent is set to the network device. Beside not reflecting
the hardware topology, this prevents registering the MDIO bus before
initializing the network device. Fix it by setting the MDIO bus parent
to the platform device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/net/ethernet/renesas/sh_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index f669e2a..443f14f 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2633,7 +2633,7 @@ static int sh_mdio_init(struct net_device *ndev, int id,
 
 	/* Hook up MII support for ethtool */
 	mdp->mii_bus->name = "sh_mii";
-	mdp->mii_bus->parent = &ndev->dev;
+	mdp->mii_bus->parent = dev;
 	snprintf(mdp->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
 		 mdp->pdev->name, id);
 
-- 
1.8.3.2

