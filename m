From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 06 Aug 2018 14:07:55 +0000
Subject: [PATCH/RFC 4/4] sh-sci: Derive regshift value from DT compatible value
Message-Id: <20180806140755.24087-5-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20180806140755.24087-1-geert+renesas@glider.be>
In-Reply-To: <20180806140755.24087-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Brandt <chris.brandt@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <uli@fpond.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Deriving the proper regshift value from the register block size is
fragile (it may have been rounded up in DT, and the mapping granularity
is usually PAGE_SIZE anyway), and turned out to be inappropriate for
earlycon support (the size is not easily available).

On DT systems, derive it from the compatible value instead.
This requires adding an entry for RZ/A2 serial ports, which use an
atypical regshift value.

On non-DT systems the regshift value is still derived from the register
block size, as before.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
  - Sato-san: I assume this fixes SCI on H8/300, too?
    Cfr. your patch "serial: sh-sci: byte allocated register support"
    (https://www.spinics.net/lists/linux-sh/msg53175.html).

  - Getting rid of the regshift setup for non-DT systems probably means
    we'll have to add ".regshift = 1" to each and every SH board file
    describing SCIF serial ports :-(

Any other suggestions?
---
 drivers/tty/serial/sh-sci.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 955c057dff6e8c78..c4342e61b8db72c3 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2898,9 +2898,10 @@ static int sci_init_single(struct platform_device *dev,
 	port->regshift		= p->regshift;
 	port->fifosize		= sci_port->params->fifosize;
 
-	if (regtype = SCIx_SH4_SCIF_REGTYPE)
+	if (!dev->dev.of_node && regtype = SCIx_SH4_SCIF_REGTYPE) {
 		if (sci_port->reg_size >= 0x20)
 			port->regshift = 1;
+	}
 
 	/*
 	 * The UART port needs an IRQ value, so we peg this to the RX IRQ
@@ -3100,43 +3101,49 @@ static int sci_remove(struct platform_device *dev)
 }
 
 
-#define SCI_OF_DATA(type, regtype)	(void *)((type) << 16 | (regtype))
+#define SCI_OF_DATA(type, regtype, regshift)	\
+			(void *)((type) << 16 | (regtype) << 8 | (regshift))
 #define SCI_OF_TYPE(data)		((unsigned long)(data) >> 16)
-#define SCI_OF_REGTYPE(data)		((unsigned long)(data) & 0xffff)
+#define SCI_OF_REGTYPE(data)		(((unsigned long)(data) >> 8) & 0xff)
+#define SCI_OF_REGSHIFT(data)		((unsigned long)(data) & 0xff)
 
 static const struct of_device_id of_sci_match[] = {
 	/* SoC-specific types */
 	{
 		.compatible = "renesas,scif-r7s72100",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH2_SCIF_FIFODATA_REGTYPE),
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH2_SCIF_FIFODATA_REGTYPE,
+				    0),
+	}, {
+		.compatible = "renesas,scif-r7s9210",
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_REGTYPE, 0),
 	},
 	/* Family-specific types */
 	{
 		.compatible = "renesas,rcar-gen1-scif",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE, 0),
 	}, {
 		.compatible = "renesas,rcar-gen2-scif",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE, 0),
 	}, {
 		.compatible = "renesas,rcar-gen3-scif",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE, 0),
 	},
 	/* Generic types */
 	{
 		.compatible = "renesas,scif",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_REGTYPE),
+		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_REGTYPE, 1),
 	}, {
 		.compatible = "renesas,scifa",
-		.data = SCI_OF_DATA(PORT_SCIFA, SCIx_SCIFA_REGTYPE),
+		.data = SCI_OF_DATA(PORT_SCIFA, SCIx_SCIFA_REGTYPE, 0),
 	}, {
 		.compatible = "renesas,scifb",
-		.data = SCI_OF_DATA(PORT_SCIFB, SCIx_SCIFB_REGTYPE),
+		.data = SCI_OF_DATA(PORT_SCIFB, SCIx_SCIFB_REGTYPE, 0),
 	}, {
 		.compatible = "renesas,hscif",
-		.data = SCI_OF_DATA(PORT_HSCIF, SCIx_HSCIF_REGTYPE),
+		.data = SCI_OF_DATA(PORT_HSCIF, SCIx_HSCIF_REGTYPE, 0),
 	}, {
 		.compatible = "renesas,sci",
-		.data = SCI_OF_DATA(PORT_SCI, SCIx_SCI_REGTYPE),
+		.data = SCI_OF_DATA(PORT_SCI, SCIx_SCI_REGTYPE, 0),
 	}, {
 		/* Terminator */
 	},
@@ -3179,6 +3186,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 
 	p->type = SCI_OF_TYPE(data);
 	p->regtype = SCI_OF_REGTYPE(data);
+	p->regshift = SCI_OF_REGSHIFT(data);
 
 	sp->has_rtscts = of_property_read_bool(np, "uart-has-rtscts");
 
-- 
2.17.1

