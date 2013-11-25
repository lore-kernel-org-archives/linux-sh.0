From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 25 Nov 2013 01:18:26 +0000
Subject: [RFC 11/17] ARM: shmobile: r8a7779: Do not include sh_clk.h in r8a7779.h
Message-Id: <1385342312-1967-12-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Do not include sh_clk.h in r8a7779.h as it is not necessary.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7779.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index bd66cd82..8284962 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -1,7 +1,6 @@
 #ifndef __ASM_R8A7779_H__
 #define __ASM_R8A7779_H__
 
-#include <linux/sh_clk.h>
 #include <linux/pm_domain.h>
 
 /* HPB-DMA slave IDs */
-- 
1.8.4

