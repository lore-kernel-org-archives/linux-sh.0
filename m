From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 04 Feb 2019 18:05:55 +0000
Subject: [PATCH v2 1/7] sh_eth: rename sh_eth_cpu_data::hw_checksum
Message-Id: <49e422f5-08aa-cb39-b39f-7f963c2f15a5@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <a21deed1-35dc-f1be-6c7e-7061ebe4b56c@cogentembedded.com>
In-Reply-To: <a21deed1-35dc-f1be-6c7e-7061ebe4b56c@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

Commit 62e04b7e0e3c ("sh_eth: rename 'sh_eth_cpu_data::hw_crc'") renamed
the field to 'hw_checksum' for the Ether DMAC "intelligent checksum",
however some Ether MACs implement a simpler checksumming scheme, so that
name now seems misleading. Rename that field to 'csmr' as the "intelligent
checksum" is always controlled by the CSMR register.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- fixed typos in the patch description;
- added Geert's tag.

 drivers/net/ethernet/renesas/sh_eth.c |   14 +++++++-------
 drivers/net/ethernet/renesas/sh_eth.h |    2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

Index: renesas/drivers/net/ethernet/renesas/sh_eth.c
=================================--- renesas.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ renesas/drivers/net/ethernet/renesas/sh_eth.c
@@ -555,7 +555,7 @@ static int sh_eth_soft_reset_gether(stru
 	sh_eth_write(ndev, 0, RDFFR);
 
 	/* Reset HW CRC register */
-	if (mdp->cd->hw_checksum)
+	if (mdp->cd->csmr)
 		sh_eth_write(ndev, 0, CSMR);
 
 	/* Select MII mode */
@@ -619,7 +619,7 @@ static struct sh_eth_cpu_data r7s72100_d
 	.no_trimd	= 1,
 	.no_ade		= 1,
 	.xdfar_rw	= 1,
-	.hw_checksum	= 1,
+	.csmr		= 1,
 	.tsu		= 1,
 	.no_tx_cntrs	= 1,
 };
@@ -668,7 +668,7 @@ static struct sh_eth_cpu_data r8a7740_da
 	.no_trimd	= 1,
 	.no_ade		= 1,
 	.xdfar_rw	= 1,
-	.hw_checksum	= 1,
+	.csmr		= 1,
 	.tsu		= 1,
 	.select_mii	= 1,
 	.magic		= 1,
@@ -793,7 +793,7 @@ static struct sh_eth_cpu_data r8a77980_d
 	.no_trimd	= 1,
 	.no_ade		= 1,
 	.xdfar_rw	= 1,
-	.hw_checksum	= 1,
+	.csmr		= 1,
 	.select_mii	= 1,
 	.magic		= 1,
 	.cexcr		= 1,
@@ -1045,7 +1045,7 @@ static struct sh_eth_cpu_data sh7734_dat
 	.no_ade		= 1,
 	.xdfar_rw	= 1,
 	.tsu		= 1,
-	.hw_checksum	= 1,
+	.csmr		= 1,
 	.select_mii	= 1,
 	.magic		= 1,
 	.cexcr		= 1,
@@ -1633,7 +1633,7 @@ static int sh_eth_rx(struct net_device *
 		 * the RFS bits are from bit 25 to bit 16. So, the
 		 * driver needs right shifting by 16.
 		 */
-		if (mdp->cd->hw_checksum)
+		if (mdp->cd->csmr)
 			desc_status >>= 16;
 
 		skb = mdp->rx_skbuff[entry];
@@ -2173,7 +2173,7 @@ static size_t __sh_eth_get_regs(struct n
 	add_reg(MAFCR);
 	if (cd->rtrate)
 		add_reg(RTRATE);
-	if (cd->hw_checksum)
+	if (cd->csmr)
 		add_reg(CSMR);
 	if (cd->select_mii)
 		add_reg(RMII_MII);
Index: renesas/drivers/net/ethernet/renesas/sh_eth.h
=================================--- renesas.orig/drivers/net/ethernet/renesas/sh_eth.h
+++ renesas/drivers/net/ethernet/renesas/sh_eth.h
@@ -499,7 +499,7 @@ struct sh_eth_cpu_data {
 	unsigned no_ade:1;	/* E-DMAC DOES NOT have ADE bit in EESR */
 	unsigned no_xdfar:1;	/* E-DMAC DOES NOT have RDFAR/TDFAR */
 	unsigned xdfar_rw:1;	/* E-DMAC has writeable RDFAR/TDFAR */
-	unsigned hw_checksum:1;	/* E-DMAC has CSMR */
+	unsigned csmr:1;	/* E-DMAC has CSMR */
 	unsigned select_mii:1;	/* EtherC has RMII_MII (MII select register) */
 	unsigned rmiimode:1;	/* EtherC has RMIIMODE register */
 	unsigned rtrate:1;	/* EtherC has RTRATE register */
