From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 09 Oct 2013 06:50:54 +0000
Subject: [PATCH 06/14] ARM: shmobile: Use arch timer on Koelsch
Message-Id: <f9c9eb7e768d049d2ae360be9e09f6a0be03e317.1381299817.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381299817.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1381299817.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Make use of the R-Car Gen2 arch timer workaround on Koelsch.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 278f12e..ea5846e 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <mach/common.h>
 #include <mach/r8a7791.h>
+#include <mach/rcar-gen2.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -40,5 +41,6 @@ static const char * const koelsch_boards_compat_dt[] __initconst = {
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.init_early	= r8a7791_init_early,
 	.init_machine	= koelsch_add_standard_devices,
+	.init_time	= rcar_gen2_timer_init,
 	.dt_compat	= koelsch_boards_compat_dt,
 MACHINE_END
-- 
1.8.4

