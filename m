From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Mon, 26 Jan 2015 11:53:29 +0000
Subject: [PATCH] serial: sh-sci: Use dev_dbg() to log an error message
Message-Id: <1422273209-3473-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Since the driver cannot return from overrun error if characters
are output during overrun process, use dev_dbg() instead of
dev_notice() to log the error message of overrun in syslog.

Based on a patch by Hisashi Nakamura.

Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
tree.

 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 69f6bf3..9688e74 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -864,7 +864,7 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
 		tty_flip_buffer_push(tport);
 
-		dev_notice(port->dev, "overrun error\n");
+		dev_dbg(port->dev, "overrun error\n");
 		copied++;
 	}
 
-- 
1.9.1

