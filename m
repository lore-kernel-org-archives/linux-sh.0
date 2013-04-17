From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 17 Apr 2013 05:17:42 +0000
Subject: [PATCH 4/6] ARM: shmobile: bockw: define FPGA address and rename iomem variable
Message-Id: <87a9oxenwt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Bock-W board will needs more board specific ioremap() method.
This patch tidyup current FPGA specific settings

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 88fcdb3..4d65715 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -62,10 +62,11 @@ static const struct pinctrl_map bockw_pinctrl_map[] = {
 				  "scif0_ctrl", "scif0"),
 };
 
+#define FPGA	0x18200000
 #define IRQ0MR	0x30
 static void __init bockw_init(void)
 {
-	void __iomem *fpga;
+	void __iomem *base;
 
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin(1);
@@ -75,8 +76,8 @@ static void __init bockw_init(void)
 				  ARRAY_SIZE(bockw_pinctrl_map));
 	r8a7778_pinmux_init();
 
-	fpga = ioremap_nocache(0x18200000, SZ_1M);
-	if (fpga) {
+	base = ioremap_nocache(FPGA, SZ_1M);
+	if (base) {
 		/*
 		 * CAUTION
 		 *
@@ -84,10 +85,10 @@ static void __init bockw_init(void)
 		 * it should be cared in the future
 		 * Now, it is assuming IRQ0 was used only from SMSC.
 		 */
-		u16 val = ioread16(fpga + IRQ0MR);
+		u16 val = ioread16(base + IRQ0MR);
 		val &= ~(1 << 4); /* enable SMSC911x */
-		iowrite16(val, fpga + IRQ0MR);
-		iounmap(fpga);
+		iowrite16(val, base + IRQ0MR);
+		iounmap(base);
 
 		regulator_register_fixed(0, dummy_supplies,
 					 ARRAY_SIZE(dummy_supplies));
-- 
1.7.9.5

