From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 24 Mar 2011 02:20:56 +0000
Subject: [RFC/PATCH] sh: sh-sci: Fix double initialization by serial_console_setup
Message-Id: <1300933256-32372-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The driver is initialized in a state with an unknown value by
serial_console_setup. And initialization fails.

This is caused by the initialization by sci_console_init.
This function does not seem to be necessary for the present sh-sci driver.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/tty/serial/sh-sci.c |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0257fd5..846e209 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1860,13 +1860,6 @@ static struct console serial_console = {
 	.data		= &sci_uart_driver,
 };
 
-static int __init sci_console_init(void)
-{
-	register_console(&serial_console);
-	return 0;
-}
-console_initcall(sci_console_init);
-
 static struct console early_serial_console = {
 	.name           = "early_ttySC",
 	.write          = serial_console_write,
@@ -1895,18 +1888,18 @@ static int __devinit sci_probe_earlyprintk(struct platform_device *pdev)
 	register_console(&early_serial_console);
 	return 0;
 }
+
+#define SCI_CONSOLE	(&serial_console)
+
 #else
 static inline int __devinit sci_probe_earlyprintk(struct platform_device *pdev)
 {
 	return -EINVAL;
 }
-#endif /* CONFIG_SERIAL_SH_SCI_CONSOLE */
 
-#if defined(CONFIG_SERIAL_SH_SCI_CONSOLE)
-#define SCI_CONSOLE	(&serial_console)
-#else
-#define SCI_CONSOLE	0
-#endif
+#define SCI_CONSOLE	NULL
+
+#endif /* CONFIG_SERIAL_SH_SCI_CONSOLE */
 
 static char banner[] __initdata  	KERN_INFO "SuperH SCI(F) driver initialized\n";
-- 
1.7.2.3

