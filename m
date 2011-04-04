From: Simon Horman <horms@verge.net.au>
Date: Mon, 04 Apr 2011 06:45:21 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: Correctly check for CONFIG_MACH_MACKEREL
Message-Id: <1301899522-20546-2-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I made a bit of a thinko when adding Mackerel to the boards
that support zboot using MMCIF.

Reported-by: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/mmc.h   |    2 +-
 arch/arm/mach-shmobile/include/mach/zboot.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/mmc.h b/arch/arm/mach-shmobile/include/mach/mmc.h
index e11560a..21a59db 100644
--- a/arch/arm/mach-shmobile/include/mach/mmc.h
+++ b/arch/arm/mach-shmobile/include/mach/mmc.h
@@ -9,7 +9,7 @@
 
 #ifdef CONFIG_MACH_AP4EVB
 #include "mach/mmc-ap4eb.h"
-#elif CONFIG_MACH_MACKEREL
+#elif defined(CONFIG_MACH_MACKEREL)
 #include "mach/mmc-mackerel.h"
 #else
 #error "unsupported board."
diff --git a/arch/arm/mach-shmobile/include/mach/zboot.h b/arch/arm/mach-shmobile/include/mach/zboot.h
index 6d6a205..9320aff 100644
--- a/arch/arm/mach-shmobile/include/mach/zboot.h
+++ b/arch/arm/mach-shmobile/include/mach/zboot.h
@@ -13,7 +13,7 @@
 #ifdef CONFIG_MACH_AP4EVB
 #define MACH_TYPE	MACH_TYPE_AP4EVB
 #include "mach/head-ap4evb.txt"
-#elif CONFIG_MACH_MACKEREL
+#elif defined(CONFIG_MACH_MACKEREL)
 #define MACH_TYPE	MACH_TYPE_MACKEREL
 #include "mach/head-mackerel.txt"
 #else
-- 
1.7.4.1

