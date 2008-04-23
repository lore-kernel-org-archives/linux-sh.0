From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2008 12:37:39 +0000
Subject: [PATCH] sh-sci: avoid writing to nonexistent registers
Message-Id: <20080423123739.7941.53715.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Only write to hardware in SCI_OUT() if the register size is valid.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/serial/sh-sci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0011/drivers/serial/sh-sci.h
+++ work/drivers/serial/sh-sci.h	2008-04-23 19:45:46.000000000 +0900
@@ -321,7 +321,7 @@
   unsigned int addr = port->mapbase + (offset);			\
   if ((size) = 8) {						\
     ctrl_outb(value, addr);					\
-  } else {							\
+  } else if ((size) = 16) {					\
     ctrl_outw(value, addr);					\
   }
 
