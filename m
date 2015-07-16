From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:46 +0000
Subject: [PATCH/RFC v2 15/29] serial: sh-sci: Improve sampling rate readability
Message-Id: <1437070920-28069-16-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Reorder sampling_rate assignment for consistency in all cases of the
switch statement.
Avoid using the ternary conditional operator to make it more clear that
the value is overridden by platform data.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d8a851b913dcadd7..3b29489bc0805a7c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2237,7 +2237,6 @@ static int sci_init_single(struct platform_device *dev,
 {
 	struct uart_port *port = &sci_port->port;
 	const struct resource *res;
-	unsigned int sampling_rate;
 	unsigned int i;
 	int ret;
 
@@ -2282,38 +2281,38 @@ static int sci_init_single(struct platform_device *dev,
 		port->fifosize = 256;
 		sci_port->overrun_reg = SCxSR;
 		sci_port->overrun_mask = SCIFA_ORER;
-		sampling_rate = 16;
+		sci_port->sampling_rate = 16;
 		break;
 	case PORT_HSCIF:
 		port->fifosize = 128;
-		sampling_rate = 0;
 		sci_port->overrun_reg = SCLSR;
 		sci_port->overrun_mask = SCLSR_ORER;
+		sci_port->sampling_rate = 0;
 		break;
 	case PORT_SCIFA:
 		port->fifosize = 64;
 		sci_port->overrun_reg = SCxSR;
 		sci_port->overrun_mask = SCIFA_ORER;
-		sampling_rate = 16;
+		sci_port->sampling_rate = 16;
 		break;
 	case PORT_SCIF:
 		if (p->regtype = SCIx_SH7705_SCIF_REGTYPE) {
 			port->fifosize = 64;
 			sci_port->overrun_reg = SCxSR;
 			sci_port->overrun_mask = SCIFA_ORER;
-			sampling_rate = 16;
+			sci_port->sampling_rate = 16;
 		} else {
 			port->fifosize = 16;
 			sci_port->overrun_reg = SCLSR;
 			sci_port->overrun_mask = SCLSR_ORER;
-			sampling_rate = 32;
+			sci_port->sampling_rate = 32;
 		}
 		break;
 	default:
 		port->fifosize = 1;
 		sci_port->overrun_reg = SCxSR;
 		sci_port->overrun_mask = SCI_ORER;
-		sampling_rate = 32;
+		sci_port->sampling_rate = 32;
 		break;
 	}
 
@@ -2321,8 +2320,8 @@ static int sci_init_single(struct platform_device *dev,
 	 * match the SoC datasheet, this should be investigated. Let platform
 	 * data override the sampling rate for now.
 	 */
-	sci_port->sampling_rate = p->sampling_rate ? p->sampling_rate
-				: sampling_rate;
+	if (p->sampling_rate)
+		sci_port->sampling_rate = p->sampling_rate;
 
 	if (!early) {
 		sci_port->iclk = clk_get(&dev->dev, "sci_ick");
-- 
1.9.1

