From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 01 Aug 2013 08:26:29 +0000
Subject: [PATCH 07/14] ARM: shmobile: Remove Marzen use of <mach/hardware.h>
Message-Id: <85469abe4930fb001c79ac5f0ca17b65c7b2580d.1375344714.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on Marzen.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index a7d1010..1f57865 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -37,7 +37,6 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
-#include <mach/hardware.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
-- 
1.8.3.2

