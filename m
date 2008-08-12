From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 12 Aug 2008 23:23:57 +0000
Subject: [RFC] SCI(F) clock source select
Message-Id: <87vdy5zuk2.wl%ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SCI(F) clock source (Internal/External) selection is hard coding now.
And depend on CPU type.

But I think it's setting depend on target.

I hope add clock selection in platform_data.

Any comments?

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 3df2aae..6c0ceff 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -82,6 +82,8 @@ struct sci_port {
 	/* Port clock */
 	struct clk		*clk;
 #endif
+	/* clock source */
+	int			clock_source;
 };
 
 #ifdef CONFIG_SH_KGDB
@@ -1040,7 +1042,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
 	struct sci_port *s = &sci_ports[port->line];
-	unsigned int status, baud, smr_val;
+	unsigned int status, baud, smr_val, scscr_val;
 	int t;
 
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
@@ -1099,7 +1101,16 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (likely(s->init_pins))
 		s->init_pins(port, termios->c_cflag);
 
-	sci_out(port, SCSCR, SCSCR_INIT(port));
+	scscr_val = SCSCR_INIT(port);
+	switch (s->clock_source) {
+	case SCIx_CLOCK_INT:
+		scscr_val &= ~0x02;
+		break;
+	case SCIx_CLOCK_EXT:
+		scscr_val |= 0x02;
+		break;
+	}
+	sci_out(port, SCSCR, scscr_val);
 
 	if ((termios->c_cflag & CREAD) != 0)
               sci_start_rx(port,0);
@@ -1468,6 +1479,8 @@ static int __devinit sci_probe(struct platform_device *dev)
 
 		sciport->type		= sciport->port.type = p->type;
 
+		sciport->clock_source	= p->clock;
+
 		memcpy(&sciport->irqs, &p->irqs, sizeof(p->irqs));
 
 		uart_add_one_port(&sci_uart_driver, &sciport->port);
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 893cc53..8f08db1 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -16,6 +16,12 @@ enum {
 	SCIx_NR_IRQS,
 };
 
+/* clock source type */
+enum {
+	SCIx_CLOCK_INT,
+	SCIx_CLOCK_EXT,
+};
+
 /*
  * Platform device specific platform_data struct
  */
@@ -25,6 +31,7 @@ struct plat_sci_port {
 	unsigned int	irqs[SCIx_NR_IRQS];	/* ERI, RXI, TXI, BRI */
 	unsigned int	type;			/* SCI / SCIF / IRDA */
 	upf_t		flags;			/* UPF_* flags */
+	int		clock;			/* clock source */
 };
 
 int early_sci_setup(struct uart_port *port);

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
