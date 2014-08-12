From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 12 Aug 2014 00:04:40 +0000
Subject: [PATCH v2 3/5] ARM: shmobile: armadillo800eva-reference: Sort includes
Message-Id: <1407801882-2561-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1407801882-2561-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1407801882-2561-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Sorted includes seems to be the done thing these days.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 84bc6cb..c392632 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -21,9 +21,9 @@
 
 #include <linux/clk.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
-- 
2.0.0.rc2

