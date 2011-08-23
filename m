From: Yoshii Takashi <takashi.yoshii.zj@renesas.com>
Date: Tue, 23 Aug 2011 08:27:18 +0000
Subject: [PATCH] serial: sh-sci: report CTS as active for get_mctrl
Message-Id: <4E536466.6020604@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, anybody want to use RTS/CTS on sh-sci?

It does not seems to have been working for long time.
Here is the one-line fix.

I'm not sure what is the optimal set of the "false" signal for get_mctrl.
I guess it might be CD|DSR|CTS, but this patch does only minimum change.

Description follows...

sh-sci.c sets hardware up and then let the HW do all flow controls.
There is no software code, nor needs to get/set real CTS signal.

But, when turning CRTSCTS on through termios, uart_set_termios() in
serial_core.c checks CTS, and stops TX if it is inactive at the moment.

Because sci_get_mctrl() returns a fixed value DTR|RTS|DSR but CTS,
the sequence
  open -> set CRTSCTS -> write
hit the case and stop working, no more outputs.

This patch makes sci_get_mctrl() report CTS in addition.

Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
---
 drivers/tty/serial/sh-sci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7149a2c..e0229a4 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1076,7 +1076,7 @@ static unsigned int sci_get_mctrl(struct uart_port *port)
 	/* This routine is used for getting signals of: DTR, DCD, DSR, RI,
 	   and CTS/RTS */
 
-	return TIOCM_DTR | TIOCM_RTS | TIOCM_DSR;
+	return TIOCM_DTR | TIOCM_RTS | TIOCM_CTS | TIOCM_DSR;
 }
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-- 1.7.3.4

