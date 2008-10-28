From: Michael Trimarchi <trimarchimichael@yahoo.it>
Date: Tue, 28 Oct 2008 18:12:06 +0000
Subject: [RFC PATCH] Correct the interrupt handler in sh4 serial device.
Message-Id: <490755F6.7060100@yahoo.it>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010807050507060900060503"
List-Id: <linux-sh.vger.kernel.org>
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010807050507060900060503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------010807050507060900060503
Content-Type: text/x-patch;
 name="correct-interrupt-handler-sh4-serial.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="correct-interrupt-handler-sh4-serial.patch"

Correct the interrupt handler in sh4 serial device,
return the correct value and check for what is anabled
 in the SCSCR register. The sh7722 is broken just sending
a break using minicom. I'm not sure for the value of
SCI_CTRL_FLAGS_REIE in all architecture.

Signed-off-by: Michael Trimarchi <trimarchimichael@yahoo.it>

---
 drivers/serial/sh-sci.c |   23 ++++++++++++-----------
 drivers/serial/sh-sci.h |    1 +
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index f0658d2..b67f219 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -810,26 +810,27 @@ static irqreturn_t sci_br_interrupt(int irq, void *ptr)
 
 static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 {
-        unsigned short ssr_status, scr_status;
-        struct uart_port *port = ptr;
+	unsigned short ssr_status, scr_status;
+	struct uart_port *port = ptr;
+	irqreturn_t ret = IRQ_NONE;
 
         ssr_status = sci_in(port,SCxSR);
         scr_status = sci_in(port,SCSCR);
 
 	/* Tx Interrupt */
-        if ((ssr_status & 0x0020) && (scr_status & 0x0080))
-                sci_tx_interrupt(irq, ptr);
+	if ((ssr_status & 0x0020) && (scr_status & SCI_CTRL_FLAGS_TIE))
+		ret = sci_tx_interrupt(irq, ptr);
 	/* Rx Interrupt */
-        if ((ssr_status & 0x0002) && (scr_status & 0x0040))
-                sci_rx_interrupt(irq, ptr);
+	if ((ssr_status & 0x0002) && (scr_status & SCI_CTRL_FLAGS_RIE))
+		ret = sci_rx_interrupt(irq, ptr);
 	/* Error Interrupt */
-        if ((ssr_status & 0x0080) && (scr_status & 0x0400))
-                sci_er_interrupt(irq, ptr);
+	if ((ssr_status & 0x0080) && (scr_status & SCI_CTRL_FLAGS_REIE))
+		ret = sci_er_interrupt(irq, ptr);
 	/* Break Interrupt */
-        if ((ssr_status & 0x0010) && (scr_status & 0x0200))
-                sci_br_interrupt(irq, ptr);
+	if ((ssr_status & 0x0010) && (scr_status & SCI_CTRL_FLAGS_REIE))
+		ret = sci_br_interrupt(irq, ptr);
 
-	return IRQ_HANDLED;
+	return ret;
 }
 
 #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_HAVE_CLK)
diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index 7cd28b2..bce713f 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -186,6 +186,7 @@
 #if defined(CONFIG_CPU_SUBTYPE_SH7750)  || \
     defined(CONFIG_CPU_SUBTYPE_SH7091)  || \
     defined(CONFIG_CPU_SUBTYPE_SH7750R) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7722)  || \
     defined(CONFIG_CPU_SUBTYPE_SH7750S) || \
     defined(CONFIG_CPU_SUBTYPE_SH7751)  || \
     defined(CONFIG_CPU_SUBTYPE_SH7751R) || \
-- 
1.5.6.5


--------------010807050507060900060503--
