From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 01 Aug 2013 08:26:27 +0000
Subject: [PATCH 05/14] ARM: shmobile: Remove EMEV2 use of <mach/hardware.h>
Message-Id: <7ffdc70e14756135da5949a6c9bc32e2086f3d02.1375344714.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375344714.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375344714.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on EMEV2.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-emev2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 19980be..fed753d 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -27,7 +27,6 @@
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/irqchip/arm-gic.h>
-#include <mach/hardware.h>
 #include <mach/common.h>
 #include <mach/emev2.h>
 #include <mach/irqs.h>
-- 
1.8.3.2

