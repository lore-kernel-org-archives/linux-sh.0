From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 11 Aug 2014 02:52:47 +0000
Subject: [PATCH repost 3/5] ARM: shmobile: armadillo800eva-reference: Sort includes
Message-Id: <1407725569-31413-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1407725569-31413-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1407725569-31413-1-git-send-email-horms+renesas@verge.net.au>
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
2.0.1

