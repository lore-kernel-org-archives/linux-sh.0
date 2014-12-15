From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Mon, 15 Dec 2014 14:13:13 +0000
Subject: [PATCH/RFC] serial: sh-sci: Remove overrun message
Message-Id: <1418652793-6770-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

Since the driver cannot return from overrun error if characters
are output during overrun process, the error message of overrun
is removed.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
tree.

 drivers/tty/serial/sh-sci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index fccebbd..fe2bb08 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -858,7 +858,6 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
 		tty_flip_buffer_push(tport);
 
-		dev_notice(port->dev, "overrun error\n");
 		copied++;
 	}
 
-- 
1.9.1

