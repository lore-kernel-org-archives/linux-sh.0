From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 19 Jun 2013 22:24:54 +0000
Subject: [PATCH 2/3] sh_eth: remove redundant bits from 'eesipr_value' field initializer
Message-Id: <201306200224.54487.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

For SH7724 'eesipr_value' field initializer includes DMAC_M_RFRMER & DMAC_M_ECI
bits which are already contained in 0x01ff009f -- remove them.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the Dave Miller's 'net-next.git' repo plus the NAPI patches
that I've reposted yesterday.

 drivers/net/ethernet/renesas/sh_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -414,7 +414,7 @@ static struct sh_eth_cpu_data sh7724_dat
 
 	.ecsr_value	= ECSR_PSRTO | ECSR_LCHNG | ECSR_ICD,
 	.ecsipr_value	= ECSIPR_PSRTOIP | ECSIPR_LCHNGIP | ECSIPR_ICDIP,
-	.eesipr_value	= DMAC_M_RFRMER | DMAC_M_ECI | 0x01ff009f,
+	.eesipr_value	= 0x01ff009f,
 
 	.tx_check	= EESR_FTC | EESR_CND | EESR_DLC | EESR_CD | EESR_RTO,
 	.eesr_err_check	= EESR_TWB | EESR_TABT | EESR_RABT | EESR_RDE |
