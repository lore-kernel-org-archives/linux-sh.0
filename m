From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 26 Nov 2013 07:32:13 +0000
Subject: [PATCH RFC v2 11/17] ARM: shmobile: r8a7779: Do not include sh_clk.h in r8a7779.h
Message-Id: <1385451139-29686-12-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

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

