From: SUGIOKA Toshinobu <sugioka@itonet.co.jp>
Date: Mon, 01 Jun 2009 03:53:41 +0000
Subject: [PATCH] Fix SCI console output
Message-Id: <4.2.0.58.J.20090601123439.00b52740@router.itonet.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix SCI transmission sequence in console output function.

Signed-off-by: Toshinobu Sugioka <sugioka@itonet.co.jp>

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index fa4d52a..a4cf107 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -151,9 +151,8 @@ static void sci_poll_put_char(struct uart_port *port, unsigned char c)
 		status = sci_in(port, SCxSR);
 	} while (!(status & SCxSR_TDxE(port)));
 
-	sci_in(port, SCxSR);            /* Dummy read */
-	sci_out(port, SCxSR, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
 	sci_out(port, SCxTDR, c);
+	sci_out(port, SCxSR, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
 }
 #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE */
 

SUGIOKA Toshinobu

