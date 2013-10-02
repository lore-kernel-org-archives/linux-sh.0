From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 08:33:36 +0000
Subject: [PATCH 3/4 v2] ARM: shmobile: bockw: add SMSC support on reference
Message-Id: <87eh84ysvj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch enables INTC IRQ, and SMSC IRQ.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - patch was splited, only -reference.c

 arch/arm/mach-shmobile/board-bockw-reference.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index 1a7c893..ae88fda 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -36,15 +36,35 @@ static const struct pinctrl_map bockw_pinctrl_map[] = {
 				  "scif0_ctrl", "scif0"),
 };
 
+#define FPGA	0x18200000
+#define IRQ0MR	0x30
+#define COMCTLR	0x101c
 static void __init bockw_init(void)
 {
+	static void __iomem *fpga;
+
 	r8a7778_clock_init();
+	r8a7778_init_irq_extpin_dt(1);
 
 	pinctrl_register_mappings(bockw_pinctrl_map,
 				  ARRAY_SIZE(bockw_pinctrl_map));
 	r8a7778_pinmux_init();
 	r8a7778_add_dt_devices();
 
+	fpga = ioremap_nocache(FPGA, SZ_1M);
+	if (fpga) {
+		/*
+		 * CAUTION
+		 *
+		 * IRQ0/1 is cascaded interrupt from FPGA.
+		 * it should be cared in the future
+		 * Now, it is assuming IRQ0 was used only from SMSC.
+		 */
+		u16 val = ioread16(fpga + IRQ0MR);
+		val &= ~(1 << 4); /* enable SMSC911x */
+		iowrite16(val, fpga + IRQ0MR);
+	}
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.7.9.5

