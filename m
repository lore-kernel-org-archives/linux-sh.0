From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Apr 2013 05:34:07 +0000
Subject: [RFC][PATCH 4/4] ARM: shmobile: bockw: add pinctrl support
Message-Id: <871uakb73n.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SCIF0 support as 1st step

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 38e5e50..dac4365 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
 #include <mach/common.h>
@@ -37,6 +38,14 @@ static struct resource smsc911x_resources[] = {
 	DEFINE_RES_IRQ(irq_pin(0)), /* IRQ 0 */
 };
 
+static const struct pinctrl_map bockw_pinctrl_map[] = {
+	/* SCIF0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
+				  "scif0_data_a", "scif0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a7778",
+				  "scif0_ctrl", "scif0"),
+};
+
 #define IRQ0MR	0x30
 static void __init bockw_init(void)
 {
@@ -46,6 +55,10 @@ static void __init bockw_init(void)
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
 
+	pinctrl_register_mappings(bockw_pinctrl_map,
+				  ARRAY_SIZE(bockw_pinctrl_map));
+	r8a7778_pinmux_init();
+
 	fpga = ioremap_nocache(0x18200000, SZ_1M);
 	if (fpga) {
 		/*
-- 
1.7.9.5

