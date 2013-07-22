From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 22 Jul 2013 13:16:20 +0000
Subject: [PATCH 5/6] ARM: shmobile: sh73a0: add support for the DMA0 controller in DT
Message-Id: <1374498981-5263-6-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a Device Tree node for the DMA0 controller on sh73a0 and a clock
alias. To enable the DMA0 controller it also has to be taken out of reset.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/sh73a0.dtsi         |   43 +++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh73a0.c |    1 +
 arch/arm/mach-shmobile/setup-sh73a0.c |    3 ++
 3 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 86e79fe..5016c93 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -119,6 +119,49 @@
 			      0 32 0x4>;
 	};
 
+	dmac: dma-multiplexer@0 {
+		compatible = "renesas,shdma-mux";
+		#dma-cells = <1>;
+		dma-channels = <20>;
+		dma-requests = <256>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		dma0: dma-controller@fe000020 {
+			compatible = "renesas,shdma-sh73a0";
+			reg = <0xfe000020 0x89e0>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 129 4
+					0 109 4
+					0 110 4
+					0 111 4
+					0 112 4
+					0 113 4
+					0 114 4
+					0 115 4
+					0 116 4
+					0 117 4
+					0 118 4
+					0 119 4
+					0 120 4
+					0 121 4
+					0 122 4
+					0 123 4
+					0 124 4
+					0 125 4
+					0 126 4
+					0 127 4
+					0 128 4>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15",
+					"ch16", "ch17", "ch18", "ch19";
+		};
+	};
+
 	i2c0: i2c@e6820000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 04a32fc..28a5e02 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -645,6 +645,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6820000.i2c", &mstp_clks[MSTP116]), /* I2C0 */
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP100]), /* LCDC0 */
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP219]), /* SCIFA7 */
+	CLKDEV_DEV_ID("fe000020.dma-controller", &mstp_clks[MSTP218]), /* SY-DMAC */
 	CLKDEV_DEV_ID("shdma-sh73a0.0", &mstp_clks[MSTP218]), /* SY-DMAC */
 	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP217]), /* MP-DMAC */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 2e9f3cc..a83bdd4 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -771,6 +771,9 @@ void __init sh73a0_add_standard_devices_dt(void)
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
 
+	/* Clear software reset bit on SY-DMAC module */
+	__raw_writel(__raw_readl(SRCR2) & ~(1 << 18), SRCR2);
+
 	platform_add_devices(sh73a0_devices_dt,
 			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-- 
1.7.2.5

