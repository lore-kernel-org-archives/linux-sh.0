From: "Pietrek, Markus" <Markus.Pietrek@emtrion.de>
Date: Wed, 13 Jan 2010 13:25:34 +0000
Subject: [PATCH] sh-sci: using correct fifo size for SCIF and SCIFA
Message-Id: <95F51F4B902CAC40AF459205F6322F0164298E5C37@BMK019S01.emtrion.local>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

the sh-sci driver used the wrong fifosize for PORT_SCIFA and PORT_SCIF. If an incorrect size is used, the serial core will enforce a shutdown of a device too early, especially on baudrates < 9600.

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index e218000..ff86ffb 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -1156,7 +1156,11 @@ static void __devinit sci_init_single(struct platform_device *dev,
        sci_port->port.ops      = &sci_uart_ops;
        sci_port->port.iotype   = UPIO_MEM;
        sci_port->port.line     = index;
-       sci_port->port.fifosize = 1;
+       switch (p->type) {
+           case PORT_SCIFA: sci_port->port.fifosize = 64; break;
+           case PORT_SCIF:  sci_port->port.fifosize = 16; break;
+           default:         sci_port->port.fifosize = 1;  break;
+       }

        if (dev) {
                sci_port->iclk = p->clk ? clk_get(&dev->dev, p->clk) : NULL;

_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or otherwise confidential information.
- If you have received this e-mail in error, you are hereby notified that any review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.
