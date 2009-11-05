From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Nov 2009 14:34:57 +0000
Subject: [PATCH 01/05] sh-sci: disable callback typo fix
Message-Id: <20091105143457.9902.39456.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Avoid invoking the disable callback in case of NULL.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/serial/sh-sci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2009-11-05 22:27:47.000000000 +0900
@@ -1143,7 +1143,7 @@ static void serial_console_write(struct 
 	while ((sci_in(port, SCxSR) & bits) != bits)
 		cpu_relax();
 
-	if (sci_port->disable);
+	if (sci_port->disable)
 		sci_port->disable(port);
 }
 
