From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date: Mon, 11 Mar 2019 15:58:49 +0000
Subject: [PATCH] arch/sh/boards/mach-dreamcast/irq.c: Remove duplicate header
Message-Id: <5c8682ef.1c69fb81.5a1ea.2e7f@mx.google.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, jrdr.linux@gmail.com

Remove  linux/irq.h which is included more than once.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/sh/boards/mach-dreamcast/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
index 2789647..69fa91c 100644
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
2.7.4
