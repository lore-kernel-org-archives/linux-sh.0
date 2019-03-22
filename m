From: jagdsh.linux@gmail.com
Date: Fri, 22 Mar 2019 15:32:34 +0000
Subject: [PATCH] sh:mach-dreamcast/irq.c : Remove duplicate header
Message-Id: <1553288536-14470-1-git-send-email-jagdsh.linux@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org, akpm@linux-foundation.org, horms+renesas@verge.net.au, kuninori.morimoto.gx@renesas.com
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Jagadeesh Pagadala <jagdsh.linux@gmail.com>

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate header which is included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 arch/sh/boards/mach-dreamcast/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
index a929f76..cc06e4c 100644
--- a/arch/sh/boards/mach-dreamcast/irq.c
+++ b/arch/sh/boards/mach-dreamcast/irq.c
@@ -10,7 +10,6 @@
  */
 #include <linux/irq.h>
 #include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/export.h>
 #include <linux/err.h>
 #include <mach/sysasic.h>
-- 
1.8.3.1
