From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 17 Nov 2014 13:53:07 +0000
Subject: [PATCH 3/4] ARM: shmobile: armadillo legacy: Migrate to generic l2c OF initialization
Message-Id: <1416232388-2611-4-git-send-email-geert+renesas@glider.be>
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
 arch/arm/mach-shmobile/board-armadillo800eva.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 6d949f1c850bda8b..11feea1da28a03b1 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -41,7 +41,6 @@
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/videodev2.h>
 
-#include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -1309,12 +1308,6 @@ static void __init eva_init(void)
 		sdhi1 = &sdhi1_device;
 	}
 
-
-#ifdef CONFIG_CACHE_L2X0
-	/* Shared attribute override enable, 32K*8way */
-	l2x0_init(IOMEM(0xf0002000), 0x00400000, 0xc20f0fff);
-#endif
-
 	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
 	i2c_register_board_info(2, i2c2_devices, ARRAY_SIZE(i2c2_devices));
 
@@ -1355,6 +1348,9 @@ static const char *eva_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva")
+	/* Shared attribute override enable, 32K*8way */
+	.l2c_aux_val	= 0x00400000,
+	.l2c_aux_mask	= 0xc20f0fff,
 	.map_io		= r8a7740_map_io,
 	.init_early	= r8a7740_add_early_devices,
 	.init_irq	= r8a7740_init_irq_of,
-- 
1.9.1

