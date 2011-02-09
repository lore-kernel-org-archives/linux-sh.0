From: Alexandre Courbot <gnurou@gmail.com>
Date: Wed, 09 Feb 2011 03:18:46 +0000
Subject: [PATCH] serial: sh-sci: prevent setup of uninitialized serial console
Message-Id: <1297221526-32283-1-git-send-email-gnurou@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Commit 906b17dc089f7fa87e37a9cfe6ee185efc90e0da introduced a condition
where the kernel will crash unless a earlyprintk parameter is specified.

Without this parameter, sci_console_init is called during early console
setup without any port being initialized, and the kernel crashes a
little bit later when uart_set_options attemps to invoke set_termios on a
port with an ops member equal to NULL.

This patch just checks in sci_console_init that the port is properly
initialized, and aborts the early console setup if it is not.

Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 drivers/tty/serial/sh-sci.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0257fd5..e180bc9 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1830,6 +1830,12 @@ static int __devinit serial_console_setup(struct console *co, char *options)
 	sci_port = &sci_ports[co->index];
 	port = &sci_port->port;
 
+	/*
+	 * Refuse to handle uninitialized ports.
+	 */
+	if (!port->ops)
+		return -ENODEV;
+
 	ret = sci_remap_port(port);
 	if (unlikely(ret != 0))
 		return ret;
-- 
1.7.4

