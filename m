From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon, 16 Nov 2015 04:27:46 +0000
Subject: [PATCH] sh: sh-sci build failure fix.
Message-Id: <1447648066-1761-1-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We need little update.

Build failed on CONFIG_SERIAL_EARLYCON=y and CONFIG_SERIAL_SH_SCI=m.
I think it only COMPILE_TEST.

earlycon code depend on CONFIG_SERIAL_SH_SCI_EARLYCON

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 39e5358..9078443 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2412,7 +2412,7 @@ static void sci_cleanup_single(struct sci_port *port)
 	pm_runtime_disable(port->port.dev);
 }
 
-#if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || defined(CONFIG_SERIAL_EARLYCON)
+#if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
 static void serial_console_putchar(struct uart_port *port, int ch)
 {
 	sci_poll_put_char(port, ch);
@@ -2793,7 +2793,7 @@ static void __exit sci_exit(void)
 early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
-#ifdef CONFIG_SERIAL_EARLYCON
+#ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
 static struct __init plat_sci_port port_cfg;
 
 static int __init early_console_setup(struct earlycon_device *device,
-- 
2.6.1

