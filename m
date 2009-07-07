From: SUGIOKA Toshinobu <sugioka@itonet.co.jp>
Date: Tue, 07 Jul 2009 05:32:07 +0000
Subject: [PATCH] fix sci interrupt handler
Message-Id: <4.2.0.58.J.20090707142727.03937f10@router.itonet.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It seems that interrupt handler in sh-sci.c does not work
for SCI.

Signed-off-by: SUGIOKA Toshinobu <sugioka@itonet.co.jp>

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 12bd646..8e2feb5 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -716,16 +716,16 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 	err_enabled = scr_status & (SCI_CTRL_FLAGS_REIE | SCI_CTRL_FLAGS_RIE);
 
 	/* Tx Interrupt */
-	if ((ssr_status & 0x0020) && (scr_status & SCI_CTRL_FLAGS_TIE))
+	if ((ssr_status & SCxSR_TDxE(port)) && (scr_status & SCI_CTRL_FLAGS_TIE))
 		ret = sci_tx_interrupt(irq, ptr);
 	/* Rx Interrupt */
-	if ((ssr_status & 0x0002) && (scr_status & SCI_CTRL_FLAGS_RIE))
+	if ((ssr_status & SCxSR_RDxF(port)) && (scr_status & SCI_CTRL_FLAGS_RIE))
 		ret = sci_rx_interrupt(irq, ptr);
 	/* Error Interrupt */
-	if ((ssr_status & 0x0080) && err_enabled)
+	if ((ssr_status & SCxSR_ERRORS(port)) && err_enabled)
 		ret = sci_er_interrupt(irq, ptr);
 	/* Break Interrupt */
-	if ((ssr_status & 0x0010) && err_enabled)
+	if ((ssr_status & SCxSR_BRK(port)) && err_enabled)
 		ret = sci_br_interrupt(irq, ptr);
 
 	return ret;

SUGIOKA Toshinobu

