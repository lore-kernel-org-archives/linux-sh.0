From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 24 Mar 2018 20:07:41 +0000
Subject: [PATCH 1/5] sh_eth: add sh_eth_cpu_data::soft_reset() method
Message-Id: <bd34aa02-0393-d590-0774-d2d37bb2e414@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <b3706a51-27a4-d78b-998d-9440637ac216@cogentembedded.com>
In-Reply-To: <b3706a51-27a4-d78b-998d-9440637ac216@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

sh_eth_reset() performs a software reset which is implemented in a
completely different way for the GEther-like controllers vs the other
controllers due to a different layout of EDMR (and other factors) --
it therefore makes sense to convert this function to a mandatory
sh_eth_cpu_data::soft_reset() method and thus get rid of the runtime
controller type check via sh_eth_is_{gether|rz_fast_ether}().

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |  135 ++++++++++++++++++++--------------
 drivers/net/ethernet/renesas/sh_eth.h |    3 
 2 files changed, 83 insertions(+), 55 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -501,6 +501,62 @@ static void sh_eth_chip_reset(struct net
 	mdelay(1);
 }
 
+static int sh_eth_soft_reset(struct net_device *ndev)
+{
+	sh_eth_modify(ndev, EDMR, EDMR_SRST_ETHER, EDMR_SRST_ETHER);
+	mdelay(3);
+	sh_eth_modify(ndev, EDMR, EDMR_SRST_ETHER, 0);
+
+	return 0;
+}
+
+static int sh_eth_check_soft_reset(struct net_device *ndev)
+{
+	int cnt;
+
+	for (cnt = 100; cnt > 0; cnt--) {
+		if (!(sh_eth_read(ndev, EDMR) & EDMR_SRST_GETHER))
+			return 0;
+		mdelay(1);
+	}
+
+	netdev_err(ndev, "Device reset failed\n");
+	return -ETIMEDOUT;
+}
+
+static int sh_eth_soft_reset_gether(struct net_device *ndev)
+{
+	struct sh_eth_private *mdp = netdev_priv(ndev);
+	int ret;
+
+	sh_eth_write(ndev, EDSR_ENALL, EDSR);
+	sh_eth_modify(ndev, EDMR, EDMR_SRST_GETHER, EDMR_SRST_GETHER);
+
+	ret = sh_eth_check_soft_reset(ndev);
+	if (ret)
+		return ret;
+
+	/* Table Init */
+	sh_eth_write(ndev, 0, TDLAR);
+	sh_eth_write(ndev, 0, TDFAR);
+	sh_eth_write(ndev, 0, TDFXR);
+	sh_eth_write(ndev, 0, TDFFR);
+	sh_eth_write(ndev, 0, RDLAR);
+	sh_eth_write(ndev, 0, RDFAR);
+	sh_eth_write(ndev, 0, RDFXR);
+	sh_eth_write(ndev, 0, RDFFR);
+
+	/* Reset HW CRC register */
+	if (mdp->cd->hw_checksum)
+		sh_eth_write(ndev, 0, CSMR);
+
+	/* Select MII mode */
+	if (mdp->cd->select_mii)
+		sh_eth_select_mii(ndev);
+
+	return ret;
+}
+
 static void sh_eth_set_rate_gether(struct net_device *ndev)
 {
 	struct sh_eth_private *mdp = netdev_priv(ndev);
@@ -521,6 +577,8 @@ static void sh_eth_set_rate_gether(struc
 #ifdef CONFIG_OF
 /* R7S72100 */
 static struct sh_eth_cpu_data r7s72100_data = {
+	.soft_reset	= sh_eth_soft_reset_gether,
+
 	.chip_reset	= sh_eth_chip_reset,
 	.set_duplex	= sh_eth_set_duplex,
 
@@ -565,6 +623,8 @@ static void sh_eth_chip_reset_r8a7740(st
 
 /* R8A7740 */
 static struct sh_eth_cpu_data r8a7740_data = {
+	.soft_reset	= sh_eth_soft_reset_gether,
+
 	.chip_reset	= sh_eth_chip_reset_r8a7740,
 	.set_duplex	= sh_eth_set_duplex,
 	.set_rate	= sh_eth_set_rate_gether,
@@ -620,6 +680,8 @@ static void sh_eth_set_rate_rcar(struct
 
 /* R-Car Gen1 */
 static struct sh_eth_cpu_data rcar_gen1_data = {
+	.soft_reset	= sh_eth_soft_reset,
+
 	.set_duplex	= sh_eth_set_duplex,
 	.set_rate	= sh_eth_set_rate_rcar,
 
@@ -647,6 +709,8 @@ static struct sh_eth_cpu_data rcar_gen1_
 
 /* R-Car Gen2 and RZ/G1 */
 static struct sh_eth_cpu_data rcar_gen2_data = {
+	.soft_reset	= sh_eth_soft_reset,
+
 	.set_duplex	= sh_eth_set_duplex,
 	.set_rate	= sh_eth_set_rate_rcar,
 
@@ -694,6 +758,8 @@ static void sh_eth_set_rate_sh7724(struc
 
 /* SH7724 */
 static struct sh_eth_cpu_data sh7724_data = {
+	.soft_reset	= sh_eth_soft_reset,
+
 	.set_duplex	= sh_eth_set_duplex,
 	.set_rate	= sh_eth_set_rate_sh7724,
 
@@ -736,6 +802,8 @@ static void sh_eth_set_rate_sh7757(struc
 
 /* SH7757 */
 static struct sh_eth_cpu_data sh7757_data = {
+	.soft_reset	= sh_eth_soft_reset,
+
 	.set_duplex	= sh_eth_set_duplex,
 	.set_rate	= sh_eth_set_rate_sh7757,
 
@@ -808,6 +876,8 @@ static void sh_eth_set_rate_giga(struct
 
 /* SH7757(GETHERC) */
 static struct sh_eth_cpu_data sh7757_data_giga = {
+	.soft_reset	= sh_eth_soft_reset_gether,
+
 	.chip_reset	= sh_eth_chip_reset_giga,
 	.set_duplex	= sh_eth_set_duplex,
 	.set_rate	= sh_eth_set_rate_giga,
@@ -847,6 +917,8 @@ static struct sh_eth_cpu_data sh7757_dat
 
 /* SH7734 */
 static struct sh_eth_cpu_data sh7734_data = {
+	.soft_reset	= sh_eth_soft_reset_gether,
+
 	.chip_reset	= sh_eth_chip_reset,
 	.set_duplex	= sh_eth_set_duplex,
 	.set_rate	= sh_eth_set_rate_gether,
@@ -883,6 +955,8 @@ static struct sh_eth_cpu_data sh7734_dat
 
 /* SH7763 */
 static struct sh_eth_cpu_data sh7763_data = {
+	.soft_reset	= sh_eth_soft_reset_gether,
+
 	.chip_reset	= sh_eth_chip_reset,
 	.set_duplex	= sh_eth_set_duplex,
 	.set_rate	= sh_eth_set_rate_gether,
@@ -917,6 +991,8 @@ static struct sh_eth_cpu_data sh7763_dat
 };
 
 static struct sh_eth_cpu_data sh7619_data = {
+	.soft_reset	= sh_eth_soft_reset,
+
 	.register_type	= SH_ETH_REG_FAST_SH3_SH2,
 
 	.eesipr_value	= EESIPR_RFCOFIP | EESIPR_ECIIP |
@@ -935,6 +1011,8 @@ static struct sh_eth_cpu_data sh7619_dat
 };
 
 static struct sh_eth_cpu_data sh771x_data = {
+	.soft_reset	= sh_eth_soft_reset,
+
 	.register_type	= SH_ETH_REG_FAST_SH3_SH2,
 
 	.eesipr_value	= EESIPR_RFCOFIP | EESIPR_ECIIP |
@@ -974,59 +1052,6 @@ static void sh_eth_set_default_cpu_data(
 		cd->trscer_err_mask = DEFAULT_TRSCER_ERR_MASK;
 }
 
-static int sh_eth_check_reset(struct net_device *ndev)
-{
-	int cnt;
-
-	for (cnt = 100; cnt > 0; cnt--) {
-		if (!(sh_eth_read(ndev, EDMR) & EDMR_SRST_GETHER))
-			return 0;
-		mdelay(1);
-	}
-
-	netdev_err(ndev, "Device reset failed\n");
-	return -ETIMEDOUT;
-}
-
-static int sh_eth_reset(struct net_device *ndev)
-{
-	struct sh_eth_private *mdp = netdev_priv(ndev);
-	int ret = 0;
-
-	if (sh_eth_is_gether(mdp) || sh_eth_is_rz_fast_ether(mdp)) {
-		sh_eth_write(ndev, EDSR_ENALL, EDSR);
-		sh_eth_modify(ndev, EDMR, EDMR_SRST_GETHER, EDMR_SRST_GETHER);
-
-		ret = sh_eth_check_reset(ndev);
-		if (ret)
-			return ret;
-
-		/* Table Init */
-		sh_eth_write(ndev, 0x0, TDLAR);
-		sh_eth_write(ndev, 0x0, TDFAR);
-		sh_eth_write(ndev, 0x0, TDFXR);
-		sh_eth_write(ndev, 0x0, TDFFR);
-		sh_eth_write(ndev, 0x0, RDLAR);
-		sh_eth_write(ndev, 0x0, RDFAR);
-		sh_eth_write(ndev, 0x0, RDFXR);
-		sh_eth_write(ndev, 0x0, RDFFR);
-
-		/* Reset HW CRC register */
-		if (mdp->cd->hw_checksum)
-			sh_eth_write(ndev, 0x0, CSMR);
-
-		/* Select MII mode */
-		if (mdp->cd->select_mii)
-			sh_eth_select_mii(ndev);
-	} else {
-		sh_eth_modify(ndev, EDMR, EDMR_SRST_ETHER, EDMR_SRST_ETHER);
-		mdelay(3);
-		sh_eth_modify(ndev, EDMR, EDMR_SRST_ETHER, 0);
-	}
-
-	return ret;
-}
-
 static void sh_eth_set_receive_align(struct sk_buff *skb)
 {
 	uintptr_t reserve = (uintptr_t)skb->data & (SH_ETH_RX_ALIGN - 1);
@@ -1362,7 +1387,7 @@ static int sh_eth_dev_init(struct net_de
 	int ret;
 
 	/* Soft Reset */
-	ret = sh_eth_reset(ndev);
+	ret = mdp->cd->soft_reset(ndev);
 	if (ret)
 		return ret;
 
@@ -1463,7 +1488,7 @@ static void sh_eth_dev_exit(struct net_d
 	 */
 	msleep(2); /* max frame time at 10 Mbps < 1250 us */
 	sh_eth_get_stats(ndev);
-	sh_eth_reset(ndev);
+	mdp->cd->soft_reset(ndev);
 
 	/* Set MAC address again */
 	update_mac_address(ndev);
Index: net-next/drivers/net/ethernet/renesas/sh_eth.h
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.h
+++ net-next/drivers/net/ethernet/renesas/sh_eth.h
@@ -469,6 +469,9 @@ struct sh_eth_rxdesc {
 
 /* This structure is used by each CPU dependency handling. */
 struct sh_eth_cpu_data {
+	/* mandatory functions */
+	int (*soft_reset)(struct net_device *ndev);
+
 	/* optional functions */
 	void (*chip_reset)(struct net_device *ndev);
 	void (*set_duplex)(struct net_device *ndev);
