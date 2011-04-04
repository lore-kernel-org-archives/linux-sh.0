From: Simon Horman <horms@verge.net.au>
Date: Mon, 04 Apr 2011 06:45:22 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: rename mmc-ap4eb.h as mmc-ap4evb.h
Message-Id: <1301899522-20546-3-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The convention is to use the name of the board printedon the PCB,
in this case ap4evb. At the very least this is consistent with
usage elsewhere in the code.

Reported-by: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/mmc-ap4eb.h  |   29 ----------------------
 arch/arm/mach-shmobile/include/mach/mmc-ap4evb.h |   29 ++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/mmc.h        |    2 +-
 3 files changed, 30 insertions(+), 30 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/mmc-ap4eb.h
 create mode 100644 arch/arm/mach-shmobile/include/mach/mmc-ap4evb.h

diff --git a/arch/arm/mach-shmobile/include/mach/mmc-ap4eb.h b/arch/arm/mach-shmobile/include/mach/mmc-ap4eb.h
deleted file mode 100644
index db59fdb..0000000
--- a/arch/arm/mach-shmobile/include/mach/mmc-ap4eb.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef MMC_AP4EB_H
-#define MMC_AP4EB_H
-
-#define PORT185CR      (void __iomem *)0xe60520b9
-#define PORT186CR      (void __iomem *)0xe60520ba
-#define PORT187CR      (void __iomem *)0xe60520bb
-#define PORT188CR      (void __iomem *)0xe60520bc
-
-#define PORTR191_160DR (void __iomem *)0xe6056014
-
-static inline void mmc_init_progress(void)
-{
-       /* Initialise LEDS1-4
-        * registers: PORT185CR-PORT188CR (LED1-LED4 Control)
-        * value:     0x10 - enable output
-        */
-       __raw_writeb(0x10, PORT185CR);
-       __raw_writeb(0x10, PORT186CR);
-       __raw_writeb(0x10, PORT187CR);
-       __raw_writeb(0x10, PORT188CR);
-}
-
-static inline void mmc_update_progress(int n)
-{
-	__raw_writel((__raw_readl(PORTR191_160DR) & ~(0xf << 25)) |
-		     (1 << (25 + n)), PORTR191_160DR);
-}
-
-#endif /* MMC_AP4EB_H */
diff --git a/arch/arm/mach-shmobile/include/mach/mmc-ap4evb.h b/arch/arm/mach-shmobile/include/mach/mmc-ap4evb.h
new file mode 100644
index 0000000..32d6ec3
--- /dev/null
+++ b/arch/arm/mach-shmobile/include/mach/mmc-ap4evb.h
@@ -0,0 +1,29 @@
+#ifndef MMC_AP4EVB_H
+#define MMC_AP4EVB_H
+
+#define PORT185CR      (void __iomem *)0xe60520b9
+#define PORT186CR      (void __iomem *)0xe60520ba
+#define PORT187CR      (void __iomem *)0xe60520bb
+#define PORT188CR      (void __iomem *)0xe60520bc
+
+#define PORTR191_160DR (void __iomem *)0xe6056014
+
+static inline void mmc_init_progress(void)
+{
+       /* Initialise LEDS1-4
+        * registers: PORT185CR-PORT188CR (LED1-LED4 Control)
+        * value:     0x10 - enable output
+        */
+       __raw_writeb(0x10, PORT185CR);
+       __raw_writeb(0x10, PORT186CR);
+       __raw_writeb(0x10, PORT187CR);
+       __raw_writeb(0x10, PORT188CR);
+}
+
+static inline void mmc_update_progress(int n)
+{
+	__raw_writel((__raw_readl(PORTR191_160DR) & ~(0xf << 25)) |
+		     (1 << (25 + n)), PORTR191_160DR);
+}
+
+#endif /* MMC_AP4EVB_H */
diff --git a/arch/arm/mach-shmobile/include/mach/mmc.h b/arch/arm/mach-shmobile/include/mach/mmc.h
index 21a59db..906db06 100644
--- a/arch/arm/mach-shmobile/include/mach/mmc.h
+++ b/arch/arm/mach-shmobile/include/mach/mmc.h
@@ -8,7 +8,7 @@
  **************************************************/
 
 #ifdef CONFIG_MACH_AP4EVB
-#include "mach/mmc-ap4eb.h"
+#include "mach/mmc-ap4evb.h"
 #elif defined(CONFIG_MACH_MACKEREL)
 #include "mach/mmc-mackerel.h"
 #else
-- 
1.7.4.1

