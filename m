From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 04 Oct 2013 01:32:01 +0000
Subject: [PATCH 4/7] ARM: shmobile: bockw: remove manual PFC settings on reference
Message-Id: <87y569zur5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current Bock-W reference is calling PFC initializer manually,
but now, it can use DTS PFC.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw-reference.c |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index ae88fda..972f951 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -28,14 +28,6 @@
  *	see board-bock.c for checking detail of dip-switch
  */
 
-static const struct pinctrl_map bockw_pinctrl_map[] = {
-	/* SCIF0 */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
-				  "scif0_data_a", "scif0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
-				  "scif0_ctrl", "scif0"),
-};
-
 #define FPGA	0x18200000
 #define IRQ0MR	0x30
 #define COMCTLR	0x101c
@@ -45,10 +37,6 @@ static void __init bockw_init(void)
 
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin_dt(1);
-
-	pinctrl_register_mappings(bockw_pinctrl_map,
-				  ARRAY_SIZE(bockw_pinctrl_map));
-	r8a7778_pinmux_init();
 	r8a7778_add_dt_devices();
 
 	fpga = ioremap_nocache(FPGA, SZ_1M);
-- 
1.7.9.5

