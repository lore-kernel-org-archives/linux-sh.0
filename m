From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Mar 2015 02:05:12 +0000
Subject: [PATCH] sh73a0 KZM9G CTS/RTS prototype
Message-Id: <20150319020512.14288.13653.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

This is a hack that enables console serial port hardware
flow control for the KZM9G board. Not for upstream merge.

Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/sh73a0-kzm9g.dts |    1 +
 drivers/tty/serial/sh-sci.c        |   12 ++++++++++++
 2 files changed, 13 insertions(+)

--- 0001/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ work/arch/arm/boot/dts/sh73a0-kzm9g.dts	2015-03-19 10:05:46.586786623 +0900
@@ -370,6 +370,7 @@
 	pinctrl-0 = <&scifa4_pins>;
 	pinctrl-names = "default";
 
+	ctsrts;
 	status = "okay";
 };
 
--- 0006/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2015-03-19 10:09:14.726785875 +0900
@@ -573,6 +573,9 @@ static void sci_init_ctsrts_scifab(struc
 {
 	unsigned short control, data;
 
+	printk("xxx SCIFAB hw flow control: %s\n",
+	       hwflow_enabled ? "on" : "off");
+
 	/* SCIFA/SCIFB CTS/RTS pin configuration depends on user space.
 	 *
 	 * In case of CTS - (SCPDR.CTSD is always accessible):
@@ -2048,6 +2051,9 @@ static void sci_set_termios(struct uart_
 	} else
 		serial_port_out(port, SCSMR, smr_val);
 
+	/* hard code modem control enablement for now */
+	termios->c_cflag |= CRTSCTS;
+
 	sci_init_pins(port, termios->c_cflag);
 
 	reg = sci_getreg(port, SCFCR);
@@ -2055,6 +2061,10 @@ static void sci_set_termios(struct uart_
 		unsigned short ctrl = serial_port_in(port, SCFCR);
 
 		if (s->cfg->capabilities & SCIx_HAVE_RTSCTS) {
+
+		  printk("xxx enabling hw flow control: %s\n",
+			 (termios->c_cflag & CRTSCTS) ? "on" : "off");
+
 			if (termios->c_cflag & CRTSCTS)
 				ctrl |= SCFCR_MCE;
 			else
@@ -2640,6 +2650,8 @@ sci_parse_dt(struct platform_device *pde
 	p->type = info->type;
 	p->regtype = info->regtype;
 	p->scscr = SCSCR_RE | SCSCR_TE;
+	if (of_property_read_bool(np, "ctsrts"))
+		p->capabilities = SCIx_HAVE_RTSCTS;
 
 	return p;
 }
