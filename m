From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 24 Mar 2018 20:09:55 +0000
Subject: [PATCH 3/5] sh_eth: add sh_eth_cpu_data::xdfar_rw flag
Message-Id: <84d41287-b2ab-e4f5-5fb4-571820a7118b@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <b3706a51-27a4-d78b-998d-9440637ac216@cogentembedded.com>
In-Reply-To: <b3706a51-27a4-d78b-998d-9440637ac216@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

The GEther-like controllers have writeable RDFAR/TDFAR, on the others
they are read-only or just absent (on R-Car). Currently we are calling
sh_eth_is_{gether|rz_fast_ether}() in order to check if these registers
can be written to, however it would be simpler to check the new 'xdfar_rw'
bitfield in the 'struct sh_eth_cpu_data'...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |   11 +++++++----
 drivers/net/ethernet/renesas/sh_eth.h |    1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -611,6 +611,7 @@ static struct sh_eth_cpu_data r7s72100_d
 	.rpadir_value   = 2 << 16,
 	.no_trimd	= 1,
 	.no_ade		= 1,
+	.xdfar_rw	= 1,
 	.hw_checksum	= 1,
 	.tsu		= 1,
 };
@@ -659,6 +660,7 @@ static struct sh_eth_cpu_data r8a7740_da
 	.rpadir_value   = 2 << 16,
 	.no_trimd	= 1,
 	.no_ade		= 1,
+	.xdfar_rw	= 1,
 	.hw_checksum	= 1,
 	.tsu		= 1,
 	.select_mii	= 1,
@@ -918,6 +920,7 @@ static struct sh_eth_cpu_data sh7757_dat
 	.rpadir_value   = 2 << 16,
 	.no_trimd	= 1,
 	.no_ade		= 1,
+	.xdfar_rw	= 1,
 	.tsu		= 1,
 	.dual_port	= 1,
 };
@@ -955,6 +958,7 @@ static struct sh_eth_cpu_data sh7734_dat
 	.hw_swap	= 1,
 	.no_trimd	= 1,
 	.no_ade		= 1,
+	.xdfar_rw	= 1,
 	.tsu		= 1,
 	.hw_checksum	= 1,
 	.select_mii	= 1,
@@ -993,6 +997,7 @@ static struct sh_eth_cpu_data sh7763_dat
 	.hw_swap	= 1,
 	.no_trimd	= 1,
 	.no_ade		= 1,
+	.xdfar_rw	= 1,
 	.tsu		= 1,
 	.irq_flags	= IRQF_SHARED,
 	.magic		= 1,
@@ -1301,8 +1306,7 @@ static void sh_eth_ring_format(struct ne
 		/* Rx descriptor address set */
 		if (i = 0) {
 			sh_eth_write(ndev, mdp->rx_desc_dma, RDLAR);
-			if (sh_eth_is_gether(mdp) ||
-			    sh_eth_is_rz_fast_ether(mdp))
+			if (mdp->cd->xdfar_rw)
 				sh_eth_write(ndev, mdp->rx_desc_dma, RDFAR);
 		}
 	}
@@ -1324,8 +1328,7 @@ static void sh_eth_ring_format(struct ne
 		if (i = 0) {
 			/* Tx descriptor address set */
 			sh_eth_write(ndev, mdp->tx_desc_dma, TDLAR);
-			if (sh_eth_is_gether(mdp) ||
-			    sh_eth_is_rz_fast_ether(mdp))
+			if (mdp->cd->xdfar_rw)
 				sh_eth_write(ndev, mdp->tx_desc_dma, TDFAR);
 		}
 	}
Index: net-next/drivers/net/ethernet/renesas/sh_eth.h
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.h
+++ net-next/drivers/net/ethernet/renesas/sh_eth.h
@@ -508,6 +508,7 @@ struct sh_eth_cpu_data {
 	unsigned rpadir:1;	/* E-DMAC have RPADIR */
 	unsigned no_trimd:1;	/* E-DMAC DO NOT have TRIMD */
 	unsigned no_ade:1;	/* E-DMAC DO NOT have ADE bit in EESR */
+	unsigned xdfar_rw:1;	/* E-DMAC has writeable RDFAR/TDFAR */
 	unsigned hw_checksum:1;	/* E-DMAC has CSMR */
 	unsigned select_mii:1;	/* EtherC have RMII_MII (MII select register) */
 	unsigned rmiimode:1;	/* EtherC has RMIIMODE register */


