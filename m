From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 16 May 2014 00:58:46 +0000
Subject: [PATCH 5/9] ARM: shmobile: Use r8a7791 DT CPU Frequency in common case
Message-Id: <648c687a6a43a6473caedba4785a16537bd21bfb.1400200838.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1400200838.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1400200838.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert the common C-code-less r8a7791 DT board support
to use shmobile_init_delay() to be able to migrate away
from per-SoC delay setup functions.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7791.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index a7e4966..2c84e74 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -225,7 +225,7 @@ static const char *r8a7791_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(R8A7791_DT, "Generic R8A7791 (Flattened Device Tree)")
 	.smp		= smp_ops(r8a7791_smp_ops),
-	.init_early	= r8a7791_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.dt_compat	= r8a7791_boards_compat_dt,
 MACHINE_END
-- 
1.8.5.2

