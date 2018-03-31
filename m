From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 31 Mar 2018 21:22:08 +0000
Subject: [PATCH net-next 1/2] sh_eth: add sh_eth_cpu_data::no_xdfar flag
Message-Id: <233e32d1-947b-2377-3d1f-39d5d83bd3f7@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <998029b4-9400-ebc3-51c1-623c3f72b6cc@cogentembedded.com>
In-Reply-To: <998029b4-9400-ebc3-51c1-623c3f72b6cc@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

The commit 6ded286555c2 ("sh_eth: Fix RX recovery on R-Car in case of RX
ring underrun") added a check for an bad RDFAR offset in sh_eth_rx(), so
that the code could work on the R-Car Ether controllers which don't have
this register (and TDFAR), then the commit 3365711df02 ("sh_eth: WARN on
access to a register not implemented in a particular chip") replaced
offset 0 with 0xffff. Adding/checking the 'no_xdfar' bit field in the
'struct sh_eth_cpu_data' instead results in less object code...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |    5 +++--
 drivers/net/ethernet/renesas/sh_eth.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -702,6 +702,7 @@ static struct sh_eth_cpu_data rcar_gen1_
 	.mpr		= 1,
 	.tpauser	= 1,
 	.hw_swap	= 1,
+	.no_xdfar	= 1,
 };
 
 /* R-Car Gen2 and RZ/G1 */
@@ -735,6 +736,7 @@ static struct sh_eth_cpu_data rcar_gen2_
 	.mpr		= 1,
 	.tpauser	= 1,
 	.hw_swap	= 1,
+	.no_xdfar	= 1,
 	.rmiimode	= 1,
 	.magic		= 1,
 };
@@ -1615,8 +1617,7 @@ static int sh_eth_rx(struct net_device *
 	/* If we don't need to check status, don't. -KDU */
 	if (!(sh_eth_read(ndev, EDRRR) & EDRRR_R)) {
 		/* fix the values for the next receiving if RDE is set */
-		if (intr_status & EESR_RDE &&
-		    mdp->reg_offset[RDFAR] != SH_ETH_OFFSET_INVALID) {
+		if (intr_status & EESR_RDE && !mdp->cd->no_xdfar) {
 			u32 count = (sh_eth_read(ndev, RDFAR) -
 				     sh_eth_read(ndev, RDLAR)) >> 4;
 
Index: net-next/drivers/net/ethernet/renesas/sh_eth.h
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.h
+++ net-next/drivers/net/ethernet/renesas/sh_eth.h
@@ -508,6 +508,7 @@ struct sh_eth_cpu_data {
 	unsigned rpadir:1;	/* E-DMAC have RPADIR */
 	unsigned no_trimd:1;	/* E-DMAC DO NOT have TRIMD */
 	unsigned no_ade:1;	/* E-DMAC DO NOT have ADE bit in EESR */
+	unsigned no_xdfar:1;	/* E-DMAC DOES NOT have RDFAR/TDFAR */
 	unsigned xdfar_rw:1;	/* E-DMAC has writeable RDFAR/TDFAR */
 	unsigned hw_checksum:1;	/* E-DMAC has CSMR */
 	unsigned select_mii:1;	/* EtherC have RMII_MII (MII select register) */
