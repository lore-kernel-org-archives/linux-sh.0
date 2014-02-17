From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 17 Feb 2014 16:57:46 +0000
Subject: [PATCH] [PATCH v2] sh_eth: call of_mdiobus_register() to register phys
Message-Id: <1392656266-5244-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If the sh_eth device is registered using OF, then the driver
should call of_mdiobus_register() to register any PHYs connected
to the system.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

--
v2:
	- allocate mdio->irq array at init time
	- set devdata after succesful mdio registration
---
 drivers/net/ethernet/renesas/sh_eth.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 06970ac..1244509 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -40,6 +40,7 @@
 #include <linux/if_vlan.h>
 #include <linux/clk.h>
 #include <linux/sh_eth.h>
+#include <linux/of_mdio.h>
 
 #include "sh_eth.h"
 
@@ -2638,6 +2639,18 @@ static int sh_mdio_init(struct net_device *ndev, int id,
 		goto out_free_bus;
 	}
 
+	if (ndev->dev.parent->of_node) {
+		ret = of_mdiobus_register(mdp->mii_bus,
+					  ndev->dev.parent->of_node);
+		if (ret != 0) {
+			dev_err(&ndev->dev, "of_mdiobus_register() failed\n");
+			goto out_free_bus;
+		}
+
+		dev_set_drvdata(&ndev->dev, mdp->mii_bus);
+		return 0;
+	}
+
 	for (i = 0; i < PHY_MAX_ADDR; i++)
 		mdp->mii_bus->irq[i] = PHY_POLL;
 	if (pd->phy_irq > 0)
-- 
1.8.5.3

