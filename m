From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat, 21 Jul 2018 14:34:36 +0000
Subject: [PATCH v2] serial: sh-sci: byte allocated register support
Message-Id: <20180721143436.43675-1-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

H8/300 SCI registers allocated byte address.
It must support to the case where shift count is 0.

Changes v2.
more simply code.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/tty/serial/sh-sci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c181eb37f985..3c7326e11d37 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2863,10 +2863,12 @@ static int sci_init_single(struct platform_device *dev,
 	port->fifosize		= sci_port->params->fifosize;
 
 	if (port->type = PORT_SCI) {
-		if (sci_port->reg_size >= 0x20)
-			port->regshift = 2;
-		else
-			port->regshift = 1;
+		/*
+		 * reg_size < 0x10: BYTE aligned (scale factor=1).
+		 * reg_size >= 0x10 and < 0x20: WORD aligned (scale factor=2).
+		 * reg_size >= 0x20: DWORD aligned (scale factor=4).
+		 */
+		port->regshift = sci_port->reg_size >> 4;
 	}
 
 	/*
-- 
2.11.0

