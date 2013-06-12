From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 12 Jun 2013 20:55:34 +0000
Subject: [PATCH] sh_eth: split 'sh_eth_netdev_ops'
Message-Id: <201306130055.34780.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

Commit 9f86134155047720a3685cda21467f68695152d2 (sh_eth: remove SH_ETH_HAS_TSU)
removes 'const' from 'sh_eth_netdev_ops'  and modifies it in case TSU registers
are present. I've originally suggested to Iwamatsu-san to split  this structure
in two instead and afterwards Dave M. suggested doing the same.
Split 'sh_eth_netdev_ops_tsu' from 'sh_eth_netdev_ops', making both 'const', and
assigning 'ndev->detdev_ops'  depending on the presence of TSU registers.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Dave Miller's 'net-next.git' repo.

 drivers/net/ethernet/renesas/sh_eth.c |   29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -2486,7 +2486,7 @@ static const u16 *sh_eth_get_register_of
 	return reg_offset;
 }
 
-static struct net_device_ops sh_eth_netdev_ops = {
+static const struct net_device_ops sh_eth_netdev_ops = {
 	.ndo_open		= sh_eth_open,
 	.ndo_stop		= sh_eth_close,
 	.ndo_start_xmit		= sh_eth_start_xmit,
@@ -2498,6 +2498,21 @@ static struct net_device_ops sh_eth_netd
 	.ndo_change_mtu		= eth_change_mtu,
 };
 
+static const struct net_device_ops sh_eth_netdev_ops_tsu = {
+	.ndo_open		= sh_eth_open,
+	.ndo_stop		= sh_eth_close,
+	.ndo_start_xmit		= sh_eth_start_xmit,
+	.ndo_get_stats		= sh_eth_get_stats,
+	.ndo_set_rx_mode	= sh_eth_set_multicast_list,
+	.ndo_vlan_rx_add_vid	= sh_eth_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= sh_eth_vlan_rx_kill_vid,
+	.ndo_tx_timeout		= sh_eth_tx_timeout,
+	.ndo_do_ioctl		= sh_eth_do_ioctl,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_set_mac_address	= eth_mac_addr,
+	.ndo_change_mtu		= eth_change_mtu,
+};
+
 static int sh_eth_drv_probe(struct platform_device *pdev)
 {
 	int ret, devno = 0;
@@ -2568,14 +2583,10 @@ static int sh_eth_drv_probe(struct platf
 	sh_eth_set_default_cpu_data(mdp->cd);
 
 	/* set function */
-	if (mdp->cd->tsu) {
-		sh_eth_netdev_ops.ndo_set_rx_mode = sh_eth_set_multicast_list;
-		sh_eth_netdev_ops.ndo_vlan_rx_add_vid = sh_eth_vlan_rx_add_vid;
-		sh_eth_netdev_ops.ndo_vlan_rx_kill_vid -			sh_eth_vlan_rx_kill_vid;
-	}
-
-	ndev->netdev_ops = &sh_eth_netdev_ops;
+	if (mdp->cd->tsu)
+		ndev->netdev_ops = &sh_eth_netdev_ops_tsu;
+	else
+		ndev->netdev_ops = &sh_eth_netdev_ops;
 	SET_ETHTOOL_OPS(ndev, &sh_eth_ethtool_ops);
 	ndev->watchdog_timeo = TX_TIMEOUT;
 
