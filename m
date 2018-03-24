From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 24 Mar 2018 20:11:19 +0000
Subject: [PATCH 4/5] sh_eth: add sh_eth_cpu_data::no_tx_cntr flag
Message-Id: <a6ddaada-59fa-3a38-7c69-87891bba9cad@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <b3706a51-27a4-d78b-998d-9440637ac216@cogentembedded.com>
In-Reply-To: <b3706a51-27a4-d78b-998d-9440637ac216@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

RZ/A1H (R7S72100) Ether controller doesn't  seem to have the TX counter
registers like TROCR/CDCR/LCCR (or at least they are still undocumented
like some TSU registers), so we bail out of sh_eth_get_stats() early in
this case.  Currently we are calling sh_eth_is_rz_fast_ether() in order
to check for this, but it would be simpler to check the new 'no_tx_cntrs'
bitfield in the 'struct sh_eth_cpu_data'; then we'd be able  to remove
sh_eth_is_rz_fast_ether() as there would be no callers left...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |    8 ++------
 drivers/net/ethernet/renesas/sh_eth.h |    1 +
 2 files changed, 3 insertions(+), 6 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -455,11 +455,6 @@ static bool sh_eth_is_gether(struct sh_e
 	return mdp->reg_offset = sh_eth_offset_gigabit;
 }
 
-static bool sh_eth_is_rz_fast_ether(struct sh_eth_private *mdp)
-{
-	return mdp->reg_offset = sh_eth_offset_fast_rz;
-}
-
 static void sh_eth_select_mii(struct net_device *ndev)
 {
 	struct sh_eth_private *mdp = netdev_priv(ndev);
@@ -614,6 +609,7 @@ static struct sh_eth_cpu_data r7s72100_d
 	.xdfar_rw	= 1,
 	.hw_checksum	= 1,
 	.tsu		= 1,
+	.no_tx_cntrs	= 1,
 };
 
 static void sh_eth_chip_reset_r8a7740(struct net_device *ndev)
@@ -2534,7 +2530,7 @@ static struct net_device_stats *sh_eth_g
 {
 	struct sh_eth_private *mdp = netdev_priv(ndev);
 
-	if (sh_eth_is_rz_fast_ether(mdp))
+	if (mdp->cd->no_tx_cntrs)
 		return &ndev->stats;
 
 	if (!mdp->is_opened)
Index: net-next/drivers/net/ethernet/renesas/sh_eth.h
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.h
+++ net-next/drivers/net/ethernet/renesas/sh_eth.h
@@ -514,6 +514,7 @@ struct sh_eth_cpu_data {
 	unsigned rmiimode:1;	/* EtherC has RMIIMODE register */
 	unsigned rtrate:1;	/* EtherC has RTRATE register */
 	unsigned magic:1;	/* EtherC has ECMR.MPDE and ECSR.MPD */
+	unsigned no_tx_cntrs:1;	/* EtherC DOES NOT have TX error counters */
 	unsigned dual_port:1;	/* Dual EtherC/E-DMAC */
 };
 
