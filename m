From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 21 Nov 2014 00:55:09 +0000
Subject: [PATCH 2/3] ARM: shmobile: sh7372: Spelling/grammar s/entity map/identity mapping/
Message-Id: <44091c118849811fadde5ce30a7518249b797668.1416530979.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1416530979.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1416530979.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh7372.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index d646c8d..a811675 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -47,7 +47,7 @@
 #include "sh7372.h"
 
 static struct map_desc sh7372_io_desc[] __initdata = {
-	/* create a 1:1 entity map for 0xe6xxxxxx
+	/* create a 1:1 identity mapping for 0xe6xxxxxx
 	 * used by CPGA, INTC and PFC.
 	 */
 	{
-- 
2.1.1

