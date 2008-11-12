From: michael <trimarchimichael@yahoo.it>
Date: Wed, 12 Nov 2008 16:22:15 +0000
Subject: [RFC PATCH] Cleanup code of sh-sci serial driver
Message-Id: <491B02B7.3050007@yahoo.it>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070108040705080808010300"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------070108040705080808010300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch does not fix any bug but clean up the coding style.

Regards Michael


--------------070108040705080808010300
Content-Type: text/x-patch;
 name="sh_sci_cleanup_code.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sh_sci_cleanup_code.patch"

Codestyle cleanup patch.

Signed-off-by: Michael Trimarchi <trimarchimichael@yahoo.it>

---
diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 5c0f32c..7e3281a 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -101,6 +101,12 @@ static void sci_stop_tx(struct uart_port *port);
 static struct sci_port sci_ports[SCI_NPORTS];
 static struct uart_driver sci_uart_driver;
 
+static inline struct sci_port *
+to_sci_port(struct uart_port *uart)
+{
+	return container_of(uart, struct sci_port, port);
+}
+
 #if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) && \
     defined(CONFIG_SH_STANDARD_BIOS) || defined(CONFIG_SH_KGDB)
 static inline void handle_error(struct uart_port *port)
@@ -124,7 +130,8 @@ static int get_char(struct uart_port *port)
 		}
 	} while (!(status & SCxSR_RDxF(port)));
 	c = sci_in(port, SCxRDR);
-	sci_in(port, SCxSR);            /* Dummy read */
+	/* Dummy read */
+	sci_in(port, SCxSR);
 	sci_out(port, SCxSR, SCxSR_RDxF_CLEAR(port));
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -161,7 +168,7 @@ static void put_string(struct sci_port *sci_port, const char *buffer, int count)
 
 #if defined(CONFIG_SH_STANDARD_BIOS) || defined(CONFIG_SH_KGDB)
 	int checksum;
-	int usegdb=0;
+	int usegdb = 0;
 
 #ifdef CONFIG_SH_STANDARD_BIOS
 	/* This call only does a trap the first time it is
@@ -181,7 +188,8 @@ static void put_string(struct sci_port *sci_port, const char *buffer, int count)
 		put_char(port, 'O'); /* 'O'utput to console */
 		checksum = 'O';
 
-		for (i=0; i<count; i++) { /* Don't use run length encoding */
+		/* Don't use run length encoding */
+		for (i = 0; i < count; i++) {
 			int h, l;
 
 			c = *p++;
@@ -197,7 +205,7 @@ static void put_string(struct sci_port *sci_port, const char *buffer, int count)
 	    } while  (get_char(port) != '+');
 	} else
 #endif /* CONFIG_SH_STANDARD_BIOS || CONFIG_SH_KGDB */
-	for (i=0; i<count; i++) {
+	for (i = 0; i < count; i++) {
 		if (*p == 10)
 			put_char(port, '\r');
 		put_char(port, *p++);
@@ -208,35 +216,34 @@ static void put_string(struct sci_port *sci_port, const char *buffer, int count)
 #ifdef CONFIG_SH_KGDB
 static int kgdb_sci_getchar(void)
 {
-        int c;
+	int c;
 
-        /* Keep trying to read a character, this could be neater */
-        while ((c = get_char(&kgdb_sci_port->port)) < 0)
+	/* Keep trying to read a character, this could be neater */
+	while ((c = get_char(&kgdb_sci_port->port)) < 0)
 		cpu_relax();
 
-        return c;
+	return c;
 }
 
 static inline void kgdb_sci_putchar(int c)
 {
-        put_char(&kgdb_sci_port->port, c);
+	put_char(&kgdb_sci_port->port, c);
 }
 #endif /* CONFIG_SH_KGDB */
 
 #if defined(__H8300S__)
 enum { sci_disable, sci_enable };
 
-static void h8300_sci_config(struct uart_port* port, unsigned int ctrl)
+static void h8300_sci_config(struct uart_port *port, unsigned int ctrl)
 {
-	volatile unsigned char *mstpcrl=(volatile unsigned char *)MSTPCRL;
+	volatile unsigned char *mstpcrl = (volatile unsigned char *)MSTPCRL;
 	int ch = (port->mapbase  - SMR0) >> 3;
 	unsigned char mask = 1 << (ch+1);
 
-	if (ctrl == sci_disable) {
+	if (ctrl == sci_disable)
 		*mstpcrl |= mask;
-	} else {
+	else
 		*mstpcrl &= ~mask;
-	}
 }
 
 static inline void h8300_sci_enable(struct uart_port *port)
@@ -251,7 +258,7 @@ static inline void h8300_sci_disable(struct uart_port *port)
 #endif
 
 #if defined(__H8300H__) || defined(__H8300S__)
-static void sci_init_pins_sci(struct uart_port* port, unsigned int cflag)
+static void sci_init_pins_sci(struct uart_port *port, unsigned int cflag)
 {
 	int ch = (port->mapbase - SMR0) >> 3;
 
@@ -285,14 +292,13 @@ static void sci_init_pins_irda(struct uart_port *port, unsigned int cflag)
 #endif
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7710) || defined(CONFIG_CPU_SUBTYPE_SH7712)
-static void sci_init_pins_scif(struct uart_port* port, unsigned int cflag)
+static void sci_init_pins_scif(struct uart_port *port, unsigned int cflag)
 {
 	unsigned int fcr_val = 0;
 
 	set_sh771x_scif_pfc(port);
-	if (cflag & CRTSCTS) {
+	if (cflag & CRTSCTS)
 		fcr_val |= SCFCR_MCE;
-	}
 	sci_out(port, SCFCR, fcr_val);
 }
 #elif defined(CONFIG_CPU_SUBTYPE_SH7720) || defined(CONFIG_CPU_SUBTYPE_SH7721)
@@ -419,18 +425,26 @@ static inline int scif_rxroom(struct uart_port *port)
 #elif defined(CONFIG_CPU_SUBTYPE_SH7763)
 static inline int scif_txroom(struct uart_port *port)
 {
-	if((port->mapbase == 0xffe00000) || (port->mapbase == 0xffe08000)) /* SCIF0/1*/
+	if ((port->mapbase == 0xffe00000) ||
+	    (port->mapbase == 0xffe08000)) {
+		/* SCIF0/1*/
 		return SCIF_TXROOM_MAX - (sci_in(port, SCTFDR) & 0xff);
-	else /* SCIF2 */
+	} else {
+		/* SCIF2 */
 		return SCIF2_TXROOM_MAX - (sci_in(port, SCFDR) >> 8);
+	}
 }
 
 static inline int scif_rxroom(struct uart_port *port)
 {
-	if((port->mapbase == 0xffe00000) || (port->mapbase == 0xffe08000)) /* SCIF0/1*/
+	if ((port->mapbase == 0xffe00000) ||
+	    (port->mapbase == 0xffe08000)) {
+		/* SCIF0/1*/
 		return sci_in(port, SCRFDR) & 0xff;
-	else /* SCIF2 */
+	} else {
+		/* SCIF2 */
 		return sci_in(port, SCFDR) & SCIF2_RFDC_MASK;
+	}
 }
 #else
 static inline int scif_txroom(struct uart_port *port)
@@ -446,12 +460,12 @@ static inline int scif_rxroom(struct uart_port *port)
 
 static inline int sci_txroom(struct uart_port *port)
 {
-	return ((sci_in(port, SCxSR) & SCI_TDRE) != 0);
+	return (sci_in(port, SCxSR) & SCI_TDRE) != 0;
 }
 
 static inline int sci_rxroom(struct uart_port *port)
 {
-	return ((sci_in(port, SCxSR) & SCxSR_RDxF(port)) != 0);
+	return (sci_in(port, SCxSR) & SCxSR_RDxF(port)) != 0;
 }
 
 /* ********************************************************************** *
@@ -469,11 +483,10 @@ static void sci_transmit_chars(struct uart_port *port)
 	status = sci_in(port, SCxSR);
 	if (!(status & SCxSR_TDxE(port))) {
 		ctrl = sci_in(port, SCSCR);
-		if (uart_circ_empty(xmit)) {
+		if (uart_circ_empty(xmit))
 			ctrl &= ~SCI_CTRL_FLAGS_TIE;
-		} else {
+		else
 			ctrl |= SCI_CTRL_FLAGS_TIE;
-		}
 		sci_out(port, SCSCR, ctrl);
 		return;
 	}
@@ -521,11 +534,11 @@ static void sci_transmit_chars(struct uart_port *port)
 }
 
 /* On SH3, SCIF may read end-of-break as a space->mark char */
-#define STEPFN(c)  ({int __c=(c); (((__c-1)|(__c)) == -1); })
+#define STEPFN(c)  ({int __c = (c); (((__c-1)|(__c)) == -1); })
 
 static inline void sci_receive_chars(struct uart_port *port)
 {
-	struct sci_port *sci_port = (struct sci_port *)port;
+	struct sci_port *sci_port = to_sci_port(port);
 	struct tty_struct *tty = port->info->port.tty;
 	int i, count, copied = 0;
 	unsigned short status;
@@ -550,13 +563,13 @@ static inline void sci_receive_chars(struct uart_port *port)
 
 		if (port->type == PORT_SCI) {
 			char c = sci_in(port, SCxRDR);
-			if (uart_handle_sysrq_char(port, c) || sci_port->break_flag)
+			if (uart_handle_sysrq_char(port, c) ||
+			    sci_port->break_flag)
 				count = 0;
-			else {
+			else
 				tty_insert_flip_char(tty, c, TTY_NORMAL);
-			}
 		} else {
-			for (i=0; i<count; i++) {
+			for (i = 0; i < count; i++) {
 				char c = sci_in(port, SCxRDR);
 				status = sci_in(port, SCxSR);
 #if defined(CONFIG_CPU_SH3)
@@ -657,7 +670,7 @@ static inline int sci_handle_errors(struct uart_port *port)
 	if (status & SCxSR_FER(port)) {
 		if (sci_rxd_in(port) == 0) {
 			/* Notify of BREAK */
-			struct sci_port *sci_port = (struct sci_port *)port;
+			struct sci_port *sci_port = to_sci_port(port);
 
 			if (!sci_port->break_flag) {
 				sci_port->break_flag = 1;
@@ -666,10 +679,11 @@ static inline int sci_handle_errors(struct uart_port *port)
 				/* Do sysrq handling. */
 				if (uart_handle_break(port))
 					return 0;
-			        pr_debug("sci: BREAK detected\n");
+				pr_debug("sci: BREAK detected\n");
 				if (tty_insert_flip_char(tty, 0, TTY_BREAK))
-				        copied++;
-                       }
+					copied++;
+			}
+
 		} else {
 			/* frame error */
 			if (tty_insert_flip_char(tty, 0, TTY_FRAME))
@@ -764,7 +778,7 @@ static irqreturn_t sci_er_interrupt(int irq, void *ptr)
 		}
 	} else {
 #if defined(SCIF_ORER)
-		if((sci_in(port, SCLSR) & SCIF_ORER) != 0) {
+		if ((sci_in(port, SCLSR) & SCIF_ORER) != 0) {
 			struct tty_struct *tty = port->info->port.tty;
 
 			sci_out(port, SCLSR, 0);
@@ -801,8 +815,8 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 	struct uart_port *port = ptr;
 	irqreturn_t ret = IRQ_NONE;
 
-        ssr_status = sci_in(port,SCxSR);
-        scr_status = sci_in(port,SCSCR);
+	ssr_status = sci_in(port, SCxSR);
+	scr_status = sci_in(port, SCSCR);
 
 	/* Tx Interrupt */
 	if ((ssr_status & 0x0020) && (scr_status & SCI_CTRL_FLAGS_TIE))
@@ -832,7 +846,7 @@ static int sci_notifier(struct notifier_block *self,
 	int i;
 
 	if ((phase == CPUFREQ_POSTCHANGE) ||
-	    (phase == CPUFREQ_RESUMECHANGE)){
+	    (phase == CPUFREQ_RESUMECHANGE)) {
 		for (i = 0; i < SCI_NPORTS; i++) {
 			struct uart_port *port = &sci_ports[i].port;
 			struct clk *clk;
@@ -904,12 +918,12 @@ static void sci_free_irq(struct sci_port *port)
 {
 	int i;
 
-        if (port->irqs[0] == port->irqs[1]) {
-                if (!port->irqs[0])
-                        printk("sci: sci_free_irq error\n");
+	if (port->irqs[0] == port->irqs[1]) {
+		if (!port->irqs[0])
+			printk(KERN_ERR "sci: sci_free_irq error\n");
 		else
-                        free_irq(port->irqs[0], port);
-        } else {
+			free_irq(port->irqs[0], port);
+	} else {
 		for (i = 0; i < ARRAY_SIZE(port->irqs); i++) {
 			if (!port->irqs[i])
 				continue;
@@ -1060,12 +1074,12 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	sci_out(port, SCSMR, smr_val);
 
 	if (t > 0) {
-		if(t >= 256) {
+		if (t >= 256) {
 			sci_out(port, SCSMR, (sci_in(port, SCSMR) & ~3) | 1);
 			t >>= 2;
-		} else {
+		} else
 			sci_out(port, SCSMR, sci_in(port, SCSMR) & ~3);
-		}
+
 		sci_out(port, SCBRR, t);
 		udelay((1000000+(baud-1)) / baud); /* Wait one bit interval */
 	}
@@ -1076,15 +1090,15 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	sci_out(port, SCSCR, SCSCR_INIT(port));
 
 	if ((termios->c_cflag & CREAD) != 0)
-              sci_start_rx(port,0);
+		sci_start_rx(port, 0);
 }
 
 static const char *sci_type(struct uart_port *port)
 {
 	switch (port->type) {
-		case PORT_SCI:	return "sci";
-		case PORT_SCIF:	return "scif";
-		case PORT_IRDA: return "irda";
+	case PORT_SCI:	return "sci";
+	case PORT_SCIF:	return "scif";
+	case PORT_IRDA: return "irda";
 	}
 
 	return NULL;
@@ -1385,9 +1399,9 @@ console_initcall(kgdb_console_init);
 #endif /* CONFIG_SH_KGDB_CONSOLE */
 
 #if defined(CONFIG_SH_KGDB_CONSOLE)
-#define SCI_CONSOLE	&kgdb_console
+#define SCI_CONSOLE	(&kgdb_console)
 #elif defined(CONFIG_SERIAL_SH_SCI_CONSOLE)
-#define SCI_CONSOLE	&serial_console
+#define SCI_CONSOLE	(&serial_console)
 #else
 #define SCI_CONSOLE	0
 #endif

--------------070108040705080808010300--
