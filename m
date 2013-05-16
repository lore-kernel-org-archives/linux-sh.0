From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 16 May 2013 07:15:44 +0000
Subject: [PATCH 07/12] ARM: shmobile: bockw: add I2C device support
Message-Id: <878v3fwg2r.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 3958910..632717e 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -63,6 +63,13 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 };
 
+/* I2C */
+static struct i2c_board_info i2c0_devices[] = {
+	{
+		I2C_BOARD_INFO("rx8581", 0x51),
+	},
+};
+
 static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* SCIF0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
@@ -91,6 +98,10 @@ static void __init bockw_init(void)
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
+	r8a7778_add_i2c_device(0);
+
+	i2c_register_board_info(0, i2c0_devices,
+				ARRAY_SIZE(i2c0_devices));
 
 	pinctrl_register_mappings(bockw_pinctrl_map,
 				  ARRAY_SIZE(bockw_pinctrl_map));
-- 
1.7.9.5

