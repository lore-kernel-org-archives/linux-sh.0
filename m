From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 31 Mar 2013 20:11:04 +0000
Subject: [PATCH] sh_eth: make 'link' field of 'struct sh_eth_private' *int*
Message-Id: <201304010011.04950.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

The 'link' field of 'struct sh_eth_private' has type 'enum phy_state' while the
'link' field of 'struct phy_device' is merely *int* (having values 0 and 1) and
the former field gets assigned from the latter. Make the field match, getting
rid of incorrectly used PHY_DOWN value in assignments/comparisons.  

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against David Miller's 'net-next.git' repo.

 drivers/net/ethernet/renesas/sh_eth.c |    8 ++++----
 drivers/net/ethernet/renesas/sh_eth.h |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -1674,7 +1674,7 @@ static void sh_eth_adjust_link(struct ne
 	struct phy_device *phydev = mdp->phydev;
 	int new_state = 0;
 
-	if (phydev->link != PHY_DOWN) {
+	if (phydev->link) {
 		if (phydev->duplex != mdp->duplex) {
 			new_state = 1;
 			mdp->duplex = phydev->duplex;
@@ -1688,7 +1688,7 @@ static void sh_eth_adjust_link(struct ne
 			if (mdp->cd->set_rate)
 				mdp->cd->set_rate(ndev);
 		}
-		if (mdp->link = PHY_DOWN) {
+		if (!mdp->link) {
 			sh_eth_write(ndev,
 				(sh_eth_read(ndev, ECMR) & ~ECMR_TXF), ECMR);
 			new_state = 1;
@@ -1696,7 +1696,7 @@ static void sh_eth_adjust_link(struct ne
 		}
 	} else if (mdp->link) {
 		new_state = 1;
-		mdp->link = PHY_DOWN;
+		mdp->link = 0;
 		mdp->speed = 0;
 		mdp->duplex = -1;
 	}
@@ -1715,7 +1715,7 @@ static int sh_eth_phy_init(struct net_de
 	snprintf(phy_id, sizeof(phy_id), PHY_ID_FMT,
 		mdp->mii_bus->id , mdp->phy_id);
 
-	mdp->link = PHY_DOWN;
+	mdp->link = 0;
 	mdp->speed = 0;
 	mdp->duplex = -1;
 
Index: net-next/drivers/net/ethernet/renesas/sh_eth.h
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.h
+++ net-next/drivers/net/ethernet/renesas/sh_eth.h
@@ -503,7 +503,7 @@ struct sh_eth_private {
 	u32 phy_id;					/* PHY ID */
 	struct mii_bus *mii_bus;	/* MDIO bus control */
 	struct phy_device *phydev;	/* PHY device control */
-	enum phy_state link;
+	int link;
 	phy_interface_t phy_interface;
 	int msg_enable;
 	int speed;
