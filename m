From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 19 Dec 2013 21:39:47 +0000
Subject: [PATCH 1/2] sh_eth: add PHY IRQ to platform data
Message-Id: <201312200139.52758.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312200138.09307.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201312200138.09307.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Allow the platform code to pass PHY's IRQ to the driver.  Print this IRQ along
with the other PHY datails in sh_eth_phy_init().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |    6 ++++--
 include/linux/sh_eth.h                |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -1685,8 +1685,8 @@ static int sh_eth_phy_init(struct net_de
 		return PTR_ERR(phydev);
 	}
 
-	dev_info(&ndev->dev, "attached phy %i to driver %s\n",
-		phydev->addr, phydev->drv->name);
+	dev_info(&ndev->dev, "attached PHY %d (IRQ %d) to driver %s\n",
+		 phydev->addr, phydev->irq, phydev->drv->name);
 
 	mdp->phydev = phydev;
 
@@ -2544,6 +2544,8 @@ static int sh_mdio_init(struct net_devic
 
 	for (i = 0; i < PHY_MAX_ADDR; i++)
 		mdp->mii_bus->irq[i] = PHY_POLL;
+	if (pd->phy_irq > 0)
+		mdp->mii_bus->irq[pd->phy] = pd->phy_irq;
 
 	/* register mdio bus */
 	ret = mdiobus_register(mdp->mii_bus);
Index: net-next/include/linux/sh_eth.h
=================================--- net-next.orig/include/linux/sh_eth.h
+++ net-next/include/linux/sh_eth.h
@@ -8,6 +8,7 @@ enum {EDMAC_LITTLE_ENDIAN, EDMAC_BIG_END
 
 struct sh_eth_plat_data {
 	int phy;
+	int phy_irq;
 	int edmac_endian;
 	phy_interface_t phy_interface;
 	void (*set_mdio_gate)(void *addr);
