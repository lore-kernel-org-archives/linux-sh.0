From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 31 Jul 2013 07:42:11 +0000
Subject: [PATCH/RESEND net-next] sh_eth: r8a7790: Handle the RFE (Receive FIFO overflow Error) interrupt
Message-Id: <1375256531-28884-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The RFE interrupt is enabled for the r8a7790 but isn't handled,
resulting in the interrupts core noticing unhandled interrupts, and
eventually disabling the ethernet IRQ.

Fix it by adding RFE to the bitmask of error interrupts to be handled
for r8a7790.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/net/ethernet/renesas/sh_eth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index fedc0a0..9e2afe8 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -403,8 +403,9 @@ static struct sh_eth_cpu_data r8a7790_data = {
 	.eesipr_value	= 0x01ff009f,
 
 	.tx_check	= EESR_FTC | EESR_CND | EESR_DLC | EESR_CD | EESR_RTO,
-	.eesr_err_check	= EESR_TWB | EESR_TABT | EESR_RABT | EESR_RDE |
-			  EESR_RFRMER | EESR_TFE | EESR_TDE | EESR_ECI,
+	.eesr_err_check	= EESR_TWB | EESR_TABT | EESR_RABT | EESR_RFE |
+			  EESR_RDE | EESR_RFRMER | EESR_TFE | EESR_TDE |
+			  EESR_ECI,
 
 	.apr		= 1,
 	.mpr		= 1,
-- 
1.8.3.2

