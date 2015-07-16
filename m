From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:34 +0000
Subject: [PATCH/RFC v2 03/29] serial: sh-sci: Correct FIFO stages on sh7705/sh7720/sh7721
Message-Id: <1437070920-28069-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to the datasheet, SCIFs on SoCs using SCIx_SH7705_SCIF_REGTYPE
(sh7705, sh7720, and sh7721) have 64-stage FIFO registers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested due to lack of hardware.
---
 drivers/tty/serial/sh-sci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index fa26be7f9414dfc2..dc8d1b6a82684c17 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2264,12 +2264,13 @@ static int sci_init_single(struct platform_device *dev,
 		sampling_rate = 16;
 		break;
 	case PORT_SCIF:
-		port->fifosize = 16;
 		if (p->regtype = SCIx_SH7705_SCIF_REGTYPE) {
+			port->fifosize = 64;
 			sci_port->overrun_reg = SCxSR;
 			sci_port->overrun_mask = SCIFA_ORER;
 			sampling_rate = 16;
 		} else {
+			port->fifosize = 16;
 			sci_port->overrun_reg = SCLSR;
 			sci_port->overrun_mask = SCLSR_ORER;
 			sampling_rate = 32;
-- 
1.9.1

