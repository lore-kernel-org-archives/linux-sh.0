From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Sun, 13 Dec 2015 15:16:50 +0000
Subject: [PATCH net-next] ravb: Add fixed-link support
Message-Id: <1450019810-324-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

This patch adds support of the fixed PHY.
This patch is based on commit 87009814cdbb ("ucc_geth: use the new fixed
PHY helpers").

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the master branch of David Miller's next networking
tree.

 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 1cf1226..300acb3 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -880,6 +880,7 @@ static int ravb_phy_init(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	struct phy_device *phydev;
 	struct device_node *pn;
+	int err;
 
 	priv->link = 0;
 	priv->speed = 0;
@@ -887,6 +888,17 @@ static int ravb_phy_init(struct net_device *ndev)
 
 	/* Try connecting to PHY */
 	pn = of_parse_phandle(np, "phy-handle", 0);
+	if (!pn) {
+		/* In the case of a fixed PHY, the DT node associated
+		 * to the PHY is the Ethernet MAC DT node.
+		 */
+		if (of_phy_is_fixed_link(np)) {
+			err = of_phy_register_fixed_link(np);
+			if (err)
+				return err;
+		}
+		pn = np;
+	}
 	phydev = of_phy_connect(ndev, pn, ravb_adjust_link, 0,
 				priv->phy_interface);
 	if (!phydev) {
-- 
1.9.1

