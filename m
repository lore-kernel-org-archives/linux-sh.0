From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 04 May 2015 15:24:30 +0000
Subject: [PATCH v3 4/6] ARM: shmobile: armadillo legacy: Migrate to generic l2c OF initialization
Message-Id: <1430753072-17145-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1430753072-17145-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430753072-17145-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Migrate the generic r8a7740 platform from calling l2x0_of_init() to the
generic l2c OF initialization.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Use 0/~0 now DT supports "arm,shared-override",

v2:
  - Keep only {,~}L2C_AUX_CTRL_SHARED_OVERRIDE.
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index bf37e3c532f661a6..e77fe29db4658357 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1308,12 +1308,6 @@ static void __init eva_init(void)
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
 
@@ -1354,6 +1348,8 @@ static const char *eva_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva")
+	.l2c_aux_val	= 0,
+	.l2c_aux_mask	= ~0,
 	.map_io		= r8a7740_map_io,
 	.init_early	= r8a7740_add_early_devices,
 	.init_irq	= r8a7740_init_irq_of,
-- 
1.9.1

