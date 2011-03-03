From: Alexandre Courbot <gnurou@gmail.com>
Date: Thu, 03 Mar 2011 08:04:42 +0000
Subject: [PATCH] serial: sh-sci: fix deadlock when resuming from S3 sleep
Message-Id: <1299139482-5235-1-git-send-email-gnurou@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

S3 sleep invokes the shutdown callback of the sh-sci driver, which
suspends the clocks until they are reactivated by a call to startup.
However, before the latter is invoked, sci_set_termios may be called on
the port by uart_resume_port. In such cases it will endlessly wait for
the TEND bit to raise, which will never happen since the clocks are
disabled.

This patch ensures that clocks are enabled when ports registers are
manipulated within sci_set_termios.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 drivers/tty/serial/sh-sci.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e180bc9..264209c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1504,6 +1504,9 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (likely(baud && port->uartclk))
 		t = sci_scbrr_calc(s->cfg->scbrr_algo_id, baud, port->uartclk);
 
+	if (s->enable)
+		s->enable(port);
+
 	do {
 		status = sci_in(port, SCxSR);
 	} while (!(status & SCxSR_TEND(port)));
@@ -1571,6 +1574,9 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if ((termios->c_cflag & CREAD) != 0)
 		sci_start_rx(port);
+
+	if (s->disable)
+		s->disable(port);
 }
 
 static const char *sci_type(struct uart_port *port)
-- 
1.7.4.1

