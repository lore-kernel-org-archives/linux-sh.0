From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 17 Nov 2014 13:53:06 +0000
Subject: [PATCH 2/4] ARM: shmobile: r8a7740: Migrate to generic l2c OF initialization
Message-Id: <1416232388-2611-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1416232388-2611-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1416232388-2611-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Migrate the generic r8a7740 platform from calling l2x0_of_init() to the
generic l2c OF initialization.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 79ad93dfdae4ee70..f4a2997f55c0c4a4 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -32,7 +32,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <asm/hardware/cache-l2x0.h>
 
 #include "common.h"
 #include "dma-register.h"
@@ -828,10 +827,6 @@ static void __init r8a7740_generic_init(void)
 {
 	r8a7740_meram_workaround();
 
-#ifdef CONFIG_CACHE_L2X0
-	/* Shared attribute override enable, 32K*8way */
-	l2x0_init(IOMEM(0xf0002000), 0x00400000, 0xc20f0fff);
-#endif
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
@@ -848,6 +843,9 @@ static const char *r8a7740_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
+	/* Shared attribute override enable, 32K*8way */
+	.l2c_aux_val	= 0x00400000,
+	.l2c_aux_mask	= 0xc20f0fff,
 	.map_io		= r8a7740_map_io,
 	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7740_init_irq_of,
-- 
1.9.1

