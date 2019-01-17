From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date: Thu, 17 Jan 2019 16:39:27 +0000
Subject: [PATCH] sh: Remove duplicate header
Message-Id: <5c40acf3.1c69fb81.5b02f.880c@mx.google.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: jrdr.linux@gmail.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com

Remove linux/irq.h which is included more than once.

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
