From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 10 Oct 2013 05:51:16 +0000
Subject: [PATCH] net: sh_eth: Correct fix for RX packet errors on R8A7740
Message-Id: <1381384276-8077-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1381384276-8077-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1381384276-8077-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Nguyen Hong Ky <nh-ky@jinso.co.jp>, Simon Horman <horms+renesas@verge.net.au>

Nguyen Hong Ky posted a patch to correct RX packet errors on R8A7740 which
was applied as 2c6221e4a5aab417 ("net: sh_eth: Fix RX packets errors on
R8A7740"). Unfortunately sh_eth.c contains many similar instances
of struct sh_eth_cpu_data and the patch was miss-applied, updating
sh7734_data instead of r8a7740_data.

This patch corrects this problem by.
1. Reverting the change to sh7734_data and;
2. Applying the change to r8a7740_data.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/net/ethernet/renesas/sh_eth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index c7e1b8f..b57c278 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -620,16 +620,12 @@ static struct sh_eth_cpu_data sh7734_data = {
 	.eesr_err_check	= EESR_TWB1 | EESR_TWB | EESR_TABT | EESR_RABT |
 			  EESR_RFE | EESR_RDE | EESR_RFRMER | EESR_TFE |
 			  EESR_TDE | EESR_ECI,
-	.fdr_value	= 0x0000070f,
-	.rmcr_value	= 0x00000001,
 
 	.apr		= 1,
 	.mpr		= 1,
 	.tpauser	= 1,
 	.bculr		= 1,
 	.hw_swap	= 1,
-	.rpadir		= 1,
-	.rpadir_value   = 2 << 16,
 	.no_trimd	= 1,
 	.no_ade		= 1,
 	.tsu		= 1,
@@ -692,12 +688,16 @@ static struct sh_eth_cpu_data r8a7740_data = {
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
1.8.4

