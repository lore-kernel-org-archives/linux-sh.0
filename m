From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 13 Nov 2008 06:33:45 +0000
Subject: [PATCH] sh: early printk port type fix
Message-Id: <20081113063345.5011.52264.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add PORT_SCIF to unbreak the early printk code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/early_printk.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/sh/kernel/early_printk.c
+++ work/arch/sh/kernel/early_printk.c	2008-11-13 13:36:24.000000000 +0900
@@ -75,6 +75,7 @@ static struct console bios_console = {
 #endif
 
 static struct uart_port scif_port = {
+	.type		= PORT_SCIF,
 	.mapbase	= CONFIG_EARLY_SCIF_CONSOLE_PORT,
 	.membase	= (char __iomem *)CONFIG_EARLY_SCIF_CONSOLE_PORT,
 };
