From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Sun, 26 Aug 2012 01:50:27 +0000
Subject: [PATCH] sh: mach-dreamcast: remove duplicated include from irq.c
Message-Id: <CAPgLHd-CLCwAruq8ruat8p-PahpEgS7nPXAj2UN0rq9wR4p+wg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove duplicated include.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
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

