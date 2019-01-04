From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 04 Jan 2019 12:53:24 +0000
Subject: [PATCH RFT v2] net: sh_eth: add support for SH7786
Message-Id: <cbc7976d-2376-15d4-0fc1-febdf142887b@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This commit adds the sh_eth_cpu_data structure that describes the
SH7786 variant of the IP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

---
The patch is against DaveM's 'net-next.git' repo.
Not posting it to netdev@vger.kernel.org this time since the 'net-next' repo
is still closed.

Changes in version 2:
- added a comment before 'sh7786_data' initializer;
- added now mandatory soft_reset() method;
- changed the 'register_type' initializer to SH_ETH_REG_FAST_RCAR;
- added the 'ecsr_value' field initializer;
- renamed EESR_RTO to EESR_TRO;
- added the 'fdr_value' field initializer;
- added the 'no_xdfar'  field initializer.

 drivers/net/ethernet/renesas/sh_eth.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -879,6 +879,36 @@ static struct sh_eth_cpu_data sh7724_dat
 	.rpadir		= 1,
 };
 
+/* SH7786 */
+static struct sh_eth_cpu_data sh7786_data = {
+	.soft_reset	= sh_eth_soft_reset,
+
+	.set_duplex	= sh_eth_set_duplex,
+
+	.register_type	= SH_ETH_REG_FAST_RCAR,
+
+	.edtrr_trns	= EDTRR_TRNS_ETHER,
+	.ecsr_value	= ECSR_PSRTO | ECSR_LCHNG | ECSR_ICD,
+	.ecsipr_value	= ECSIPR_PSRTOIP | ECSIPR_LCHNGIP | ECSIPR_ICDIP,
+	.eesipr_value	= EESIPR_RFCOFIP | EESIPR_ADEIP | EESIPR_ECIIP |
+			  EESIPR_FTCIP | EESIPR_TDEIP | EESIPR_TFUFIP |
+			  EESIPR_FRIP | EESIPR_RDEIP | EESIPR_RFOFIP |
+			  EESIPR_RMAFIP | EESIPR_RRFIP |
+			  EESIPR_RTLFIP | EESIPR_RTSFIP |
+			  EESIPR_PREIP | EESIPR_CERFIP,
+
+	.tx_check	= EESR_FTC | EESR_CND | EESR_DLC | EESR_CD | EESR_TRO,
+	.eesr_err_check	= EESR_TWB | EESR_TABT | EESR_RABT | EESR_RFE |
+			  EESR_RDE | EESR_RFRMER | EESR_TFE | EESR_TDE,
+	.fdr_value	= 0x00000f0f,
+
+	.apr		= 1,
+	.mpr		= 1,
+	.tpauser	= 1,
+	.hw_swap	= 1,
+	.no_xdfar	= 1,
+};
+
 static void sh_eth_set_rate_sh7757(struct net_device *ndev)
 {
 	struct sh_eth_private *mdp = netdev_priv(ndev);
@@ -3476,6 +3506,7 @@ static const struct platform_device_id s
 	{ "sh7757-ether", (kernel_ulong_t)&sh7757_data },
 	{ "sh7757-gether", (kernel_ulong_t)&sh7757_data_giga },
 	{ "sh7763-gether", (kernel_ulong_t)&sh7763_data },
+	{ "sh7786-ether", (kernel_ulong_t)&sh7786_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, sh_eth_id_table);
