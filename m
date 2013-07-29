From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 29 Jul 2013 19:24:06 +0000
Subject: [PATCH] ARM: shmobile: Remove unused mach/sdhi*.h headers
Message-Id: <1375125846-25149-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The headers are not used anymore, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h | 21 ---------------------
 arch/arm/mach-shmobile/include/mach/sdhi.h        | 16 ----------------
 2 files changed, 37 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/sdhi.h

diff --git a/arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h b/arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h
deleted file mode 100644
index 4a81b01..0000000
--- a/arch/arm/mach-shmobile/include/mach/sdhi-sh7372.h
+++ /dev/null
@@ -1,21 +0,0 @@
-#ifndef SDHI_SH7372_H
-#define SDHI_SH7372_H
-
-#define SDGENCNTA       0xfe40009c
-
-/* The countdown of SDGENCNTA is controlled by
- * ZB3D2CLK which runs at 149.5MHz.
- * That is 149.5ticks/us. Approximate this as 150ticks/us.
- */
-static void udelay(int us)
-{
-	__raw_writel(us * 150, SDGENCNTA);
-	while(__raw_readl(SDGENCNTA)) ;
-}
-
-static void msleep(int ms)
-{
-	udelay(ms * 1000);
-}
-
-#endif
diff --git a/arch/arm/mach-shmobile/include/mach/sdhi.h b/arch/arm/mach-shmobile/include/mach/sdhi.h
deleted file mode 100644
index 0ec9e69..0000000
--- a/arch/arm/mach-shmobile/include/mach/sdhi.h
+++ /dev/null
@@ -1,16 +0,0 @@
-#ifndef SDHI_H
-#define SDHI_H
-
-/**************************************************
- *
- *		CPU specific settings
- *
- **************************************************/
-
-#ifdef CONFIG_ARCH_SH7372
-#include "mach/sdhi-sh7372.h"
-#else
-#error "unsupported CPU."
-#endif
-
-#endif /* SDHI_H */
-- 
Regards,

Laurent Pinchart

