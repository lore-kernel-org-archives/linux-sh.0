From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Wed, 11 Jul 2018 11:41:22 +0000
Subject: [PATCH] [RFC] serial: sh-sci: fix register alocation in h8300.
Message-Id: <20180711114121.10735-1-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

h8300's SCI registers aligned byte address.
Although it may be appropriate to put it in sci_port_params,
because I can not think of a good way, I did it like this.

Signei-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/tty/serial/sh-sci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c181eb37f985..827ef57cebb8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2862,12 +2862,16 @@ static int sci_init_single(struct platform_device *dev,
 	port->flags		= UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
 	port->fifosize		= sci_port->params->fifosize;
 
+#if !defined(CONFIG_H8300)
 	if (port->type = PORT_SCI) {
 		if (sci_port->reg_size >= 0x20)
 			port->regshift = 2;
 		else
 			port->regshift = 1;
 	}
+#else
+	port->regshift = 0;
+#endif
 
 	/*
 	 * The UART port needs an IRQ value, so we peg this to the RX IRQ
-- 
2.11.0

