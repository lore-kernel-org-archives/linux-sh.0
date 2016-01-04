From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 04 Jan 2016 13:45:19 +0000
Subject: [PATCH 2/5] serial: sh-sci: Preserve SCIFA/SCIFB bit rate config for serial console
Message-Id: <1451915122-30219-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1451915122-30219-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1451915122-30219-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

SCIFA and SCIFB have additional bit rate config bits in the Serial Mode
Register.  Don't touch them when using the port as a serial console, as
we rely on the boot loader to have configured the serial port config.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
I'm not aware of any boot loader setting these bits, but better safe
than sorry.
---
 drivers/tty/serial/sh-sci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index a7c062192e2d3130..e8d6fa77e11208d4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2229,7 +2229,8 @@ done:
 	} else {
 		/* Don't touch the bit rate configuration */
 		scr_val = s->cfg->scscr & (SCSCR_CKE1 | SCSCR_CKE0);
-		smr_val |= serial_port_in(port, SCSMR) & SCSMR_CKS;
+		smr_val |= serial_port_in(port, SCSMR) &
+			   (SCSMR_CKEDG | SCSMR_SRC_MASK | SCSMR_CKS);
 		dev_dbg(port->dev, "SCR 0x%x SMR 0x%x\n", scr_val, smr_val);
 		serial_port_out(port, SCSCR, scr_val);
 		serial_port_out(port, SCSMR, smr_val);
-- 
1.9.1

