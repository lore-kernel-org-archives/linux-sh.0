From: Nguyen Hong Ky <nh-ky@jinso.co.jp>
Date: Fri, 04 Oct 2013 05:39:19 +0000
Subject: [PATCH] ARM: mach-shmobile: armadillo800eva: Fix RX packets errors on sh_eth
Message-Id: <1380865159-5982-2-git-send-email-nh-ky@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1340189605-22074-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1340189605-22074-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch will fix RX packets errors when receiving big size
of data by set bit RNC = 1.

RNC - Receive Enable Control

0: Upon completion of reception of one frame, the E-DMAC writes
the receive status to the descriptor and clears the RR bit in
EDRRR to 0.

1: Upon completion of reception of one frame, the E-DMAC writes
(writes back) the receive status to the descriptor. In addition,
the E-DMAC reads the next descriptor and prepares for reception
of the next frame.

Signed-off-by: Nguyen Hong Ky <nh-ky@jinso.co.jp>
---
 drivers/net/ethernet/renesas/sh_eth.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index a753928..11d34f0 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -649,12 +649,16 @@ static struct sh_eth_cpu_data r8a7740_data = {
 	.eesr_err_check	= EESR_TWB1 | EESR_TWB | EESR_TABT | EESR_RABT |
 			  EESR_RFE | EESR_RDE | EESR_RFRMER | EESR_TFE |
 			  EESR_TDE | EESR_ECI,
+	.fdr_value	= 0x0000070f,
+	.rmcr_value	= 0x00000001,
 
 	.apr		= 1,
 	.mpr		= 1,
 	.tpauser	= 1,
 	.bculr		= 1,
 	.hw_swap	= 1,
+	.rpadir		= 1,
+	.rpadir_value   = 2 << 16,
 	.no_trimd	= 1,
 	.no_ade		= 1,
 	.tsu		= 1,
-- 
1.7.5.4

