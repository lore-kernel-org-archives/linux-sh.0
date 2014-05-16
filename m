From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 16 May 2014 00:58:44 +0000
Subject: [PATCH 3/9] ARM: shmobile: Use r8a7740 DT CPU Frequency for Armadillo DT Ref
Message-Id: <e568802d13eb1dbcbe688aa4e7cf1db866a52e3e.1400200838.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1400200838.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1400200838.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert the Armadillo r8a7740 DT reference board support
to use shmobile_init_delay() to be able to migrate away
from per-SoC delay setup functions.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Tested-by: Geert Uytterhoeven <geert@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 57d1a78..57d246e 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -187,7 +187,7 @@ static const char *eva_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva-reference")
 	.map_io		= r8a7740_map_io,
-	.init_early	= r8a7740_init_delay,
+	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
 	.init_machine	= eva_init,
 	.init_late	= shmobile_init_late,
-- 
1.8.5.2

