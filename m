From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 06 Aug 2018 14:07:53 +0000
Subject: [PATCH/RFC 2/4] sh-sci: Take into account regshift to fix earlycon breakage
Message-Id: <20180806140755.24087-3-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20180806140755.24087-1-geert+renesas@glider.be>
In-Reply-To: <20180806140755.24087-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Brandt <chris.brandt@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <uli@fpond.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

With the compressed SCIF address range, the SCIF ports on most Renesas
SoCs now use regshift 1.

However, the earlycon setup code always assumes regshift zero, breaking
earlycon on R-Car, RZ/A1, and RZ/G SoCs.

Fix this by initializing regshift to 1 for the generic SCIF case, and
adding a special entry for RZ/A2 SoCs that do need regshift 0.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 2d4dd0da45401c7a ("serial: sh-sci: Allow for compressed SCIF address")
---
Tested on R-Car Gen2 and Gen3.

This depends on the previous patch.  Else the kernel hangs when
initializing SCIF0 (why??).
---
 drivers/tty/serial/sh-sci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index cf3195bed0246a3d..caf4422d9e2e59e4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3390,9 +3390,17 @@ static int __init sci_early_console_setup(struct earlycon_device *device,
 {
 	return early_console_setup(device, PORT_SCI);
 }
+static int __init rza2_early_console_setup(struct earlycon_device *device,
+					  const char *opt)
+{
+	/* RZ/A2 uses the default regshift zero */
+	return early_console_setup(device, PORT_SCIF);
+}
 static int __init scif_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
+	/* Other plain SCIF variants */
+	device->port.regshift = 1;
 	return early_console_setup(device, PORT_SCIF);
 }
 static int __init scifa_early_console_setup(struct earlycon_device *device,
@@ -3412,6 +3420,7 @@ static int __init hscif_early_console_setup(struct earlycon_device *device,
 }
 
 OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
+OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rza2_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
 OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
-- 
2.17.1

