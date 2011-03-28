From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Mon, 28 Mar 2011 02:34:35 +0000
Subject: [PATCH] sh: sh-sci: Check initialization for earlyprintk
Message-Id: <1301279675-16519-1-git-send-email-iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When user do not set earlyprink, initialization is performed in the state
that setting is not performed. In this case sh-sci does not work.
This checks the initialization.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/tty/serial/sh-sci.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index eb7958c..cc4c329 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1836,6 +1836,9 @@ static int __devinit serial_console_setup(struct console *co, char *options)
 	sci_port = &sci_ports[co->index];
 	port = &sci_port->port;
 
+	if (port->ops = NULL)
+		return -ENODEV;
+
 	ret = sci_remap_port(port);
 	if (unlikely(ret != 0))
 		return ret;
-- 
1.7.4.1

