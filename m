From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 20 Jun 2013 21:12:21 +0000
Subject: [PATCH 1/2] sh_eth: fix unhandled RFE interrupt
Message-Id: <201306210112.22352.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

EESR.RFE (receive FIFO overflow) interrupt is enabled by the driver on all SoCs
and sh_eth_error() handles it but it's not present in any initializer/assignment
of the 'eesr_err_check' field of 'struct sh_eth_cpu_data'. This leads to that
interrupt not being handled and cleared, and finally to disabling IRQ and the
driver being non-functional.

Modify DEFAULT_EESR_ERR_CHECK macro and all explicit initializers of the above
mentioned field to contain the EESR.RFE bit. Remove useless backslashes from the
initializers, while at it.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Dave Miller's 'net.git' repo.
The bug is 100% reproducible (with added NAPI support) while running certain
'netperf' test.

 drivers/net/ethernet/renesas/sh_eth.c |   33 ++++++++++++++++++---------------
 drivers/net/ethernet/renesas/sh_eth.h |    2 +-
 2 files changed, 19 insertions(+), 16 deletions(-)

Index: net/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net/drivers/net/ethernet/renesas/sh_eth.c
@@ -380,8 +380,9 @@ static struct sh_eth_cpu_data sh_eth_my_
 	.eesipr_value	= 0x01ff009f,
 
 	.tx_check	= EESR_FTC | EESR_CND | EESR_DLC | EESR_CD | EESR_RTO,
-	.eesr_err_check	= EESR_TWB | EESR_TABT | EESR_RABT | EESR_RDE |
-			  EESR_RFRMER | EESR_TFE | EESR_TDE | EESR_ECI,
+	.eesr_err_check	= EESR_TWB | EESR_TABT | EESR_RABT | EESR_RFE |
+			  EESR_RDE | EESR_RFRMER | EESR_TFE | EESR_TDE |
+			  EESR_ECI,
 	.tx_error_check	= EESR_TWB | EESR_TABT | EESR_TDE | EESR_TFE,
 
 	.apr		= 1,
@@ -427,8 +428,9 @@ static struct sh_eth_cpu_data sh_eth_my_
 	.eesipr_value	= DMAC_M_RFRMER | DMAC_M_ECI | 0x01ff009f,
 
 	.tx_check	= EESR_FTC | EESR_CND | EESR_DLC | EESR_CD | EESR_RTO,
-	.eesr_err_check	= EESR_TWB | EESR_TABT | EESR_RABT | EESR_RDE |
-			  EESR_RFRMER | EESR_TFE | EESR_TDE | EESR_ECI,
+	.eesr_err_check	= EESR_TWB | EESR_TABT | EESR_RABT | EESR_RFE |
+			  EESR_RDE | EESR_RFRMER | EESR_TFE | EESR_TDE |
+			  EESR_ECI,
 	.tx_error_check	= EESR_TWB | EESR_TABT | EESR_TDE | EESR_TFE,
 
 	.apr		= 1,
@@ -478,8 +480,9 @@ static struct sh_eth_cpu_data sh_eth_my_
 	.rmcr_value	= 0x00000001,
 
 	.tx_check	= EESR_FTC | EESR_CND | EESR_DLC | EESR_CD | EESR_RTO,
-	.eesr_err_check	= EESR_TWB | EESR_TABT | EESR_RABT | EESR_RDE |
-			  EESR_RFRMER | EESR_TFE | EESR_TDE | EESR_ECI,
+	.eesr_err_check	= EESR_TWB | EESR_TABT | EESR_RABT | EESR_RFE |
+			  EESR_RDE | EESR_RFRMER | EESR_TFE | EESR_TDE |
+			  EESR_ECI,
 	.tx_error_check	= EESR_TWB | EESR_TABT | EESR_TDE | EESR_TFE,
 
 	.apr		= 1,
@@ -592,9 +595,9 @@ static struct sh_eth_cpu_data sh_eth_my_
 	.eesipr_value	= DMAC_M_RFRMER | DMAC_M_ECI | 0x003fffff,
 
 	.tx_check	= EESR_TC1 | EESR_FTC,
-	.eesr_err_check	= EESR_TWB1 | EESR_TWB | EESR_TABT | EESR_RABT | \
-			  EESR_RDE | EESR_RFRMER | EESR_TFE | EESR_TDE | \
-			  EESR_ECI,
+	.eesr_err_check	= EESR_TWB1 | EESR_TWB | EESR_TABT | EESR_RABT |
+			  EESR_RFE | EESR_RDE | EESR_RFRMER | EESR_TFE |
+			  EESR_TDE | EESR_ECI,
 	.tx_error_check	= EESR_TWB1 | EESR_TWB | EESR_TABT | EESR_TDE | \
 			  EESR_TFE,
 	.fdr_value	= 0x0000072f,
@@ -674,9 +677,9 @@ static struct sh_eth_cpu_data sh_eth_my_
 	.eesipr_value	= DMAC_M_RFRMER | DMAC_M_ECI | 0x003fffff,
 
 	.tx_check	= EESR_TC1 | EESR_FTC,
-	.eesr_err_check	= EESR_TWB1 | EESR_TWB | EESR_TABT | EESR_RABT | \
-			  EESR_RDE | EESR_RFRMER | EESR_TFE | EESR_TDE | \
-			  EESR_ECI,
+	.eesr_err_check	= EESR_TWB1 | EESR_TWB | EESR_TABT | EESR_RABT |
+			  EESR_RFE | EESR_RDE | EESR_RFRMER | EESR_TFE |
+			  EESR_TDE | EESR_ECI,
 	.tx_error_check	= EESR_TWB1 | EESR_TWB | EESR_TABT | EESR_TDE | \
 			  EESR_TFE,
 
@@ -811,9 +814,9 @@ static struct sh_eth_cpu_data sh_eth_my_
 	.eesipr_value	= DMAC_M_RFRMER | DMAC_M_ECI | 0x003fffff,
 
 	.tx_check	= EESR_TC1 | EESR_FTC,
-	.eesr_err_check	= EESR_TWB1 | EESR_TWB | EESR_TABT | EESR_RABT | \
-			  EESR_RDE | EESR_RFRMER | EESR_TFE | EESR_TDE | \
-			  EESR_ECI,
+	.eesr_err_check	= EESR_TWB1 | EESR_TWB | EESR_TABT | EESR_RABT |
+			  EESR_RFE | EESR_RDE | EESR_RFRMER | EESR_TFE |
+			  EESR_TDE | EESR_ECI,
 	.tx_error_check	= EESR_TWB1 | EESR_TWB | EESR_TABT | EESR_TDE | \
 			  EESR_TFE,
 
Index: net/drivers/net/ethernet/renesas/sh_eth.h
=================================--- net.orig/drivers/net/ethernet/renesas/sh_eth.h
+++ net/drivers/net/ethernet/renesas/sh_eth.h
@@ -253,7 +253,7 @@ enum EESR_BIT {
 
 #define DEFAULT_TX_CHECK	(EESR_FTC | EESR_CND | EESR_DLC | EESR_CD | \
 				 EESR_RTO)
-#define DEFAULT_EESR_ERR_CHECK	(EESR_TWB | EESR_TABT | EESR_RABT | \
+#define DEFAULT_EESR_ERR_CHECK	(EESR_TWB | EESR_TABT | EESR_RABT | EESR_RFE | \
 				 EESR_RDE | EESR_RFRMER | EESR_ADE | \
 				 EESR_TFE | EESR_TDE | EESR_ECI)
 #define DEFAULT_TX_ERROR_CHECK	(EESR_TWB | EESR_TABT | EESR_ADE | EESR_TDE | \
