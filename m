From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Jun 2013 15:48:23 +0000
Subject: [PATCH v2 5/6] ARM: shmobile: r8a7740: add DT nodes for three DMAC instance
Message-Id: <1370533704-23734-6-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds Device Tree support for the three DMA controller instances
on r8a7740 in a DMA multiplexer node.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7740.dtsi         |   67 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c |    6 +++
 2 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index e9a90d8..848eb02 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -112,6 +112,73 @@
 			      0 149 0x4>;
 	};
 
+	dmac: dma-mux0 {
+		compatible = "simple-bus", "dma-mux";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		dma0: shdma@fe008020 {
+			compatible = "renesas,shdma";
+			reg = <0xfe008020 0x270>,
+				<0xfe009000 0xc>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 34 4
+					0 28 4
+					0 29 4
+					0 30 4
+					0 31 4
+					0 32 4
+					0 33 4>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5";
+			#dma-cells = <1>;
+			dma-channels = <6>;
+			dma-requests = <256>;
+		};
+
+		dma1: shdma@fe018020 {
+			compatible = "renesas,shdma";
+			reg = <0xfe018020 0x270>,
+				<0xfe019000 0xc>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 41 4
+					0 35 4
+					0 36 4
+					0 37 4
+					0 38 4
+					0 39 4
+					0 40 4>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5";
+			#dma-cells = <1>;
+			dma-channels = <6>;
+			dma-requests = <256>;
+		};
+
+		dma2: shdma@fe028020 {
+			compatible = "renesas,shdma";
+			reg = <0xfe028020 0x270>,
+				<0xfe029000 0xc>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 48 4
+					0 42 4
+					0 43 4
+					0 44 4
+					0 45 4
+					0 46 4
+					0 47 4>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5";
+			#dma-cells = <1>;
+			dma-channels = <6>;
+			dma-requests = <256>;
+		};
+	};
+
 	i2c0: i2c@fff20000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 6b3ed42..dbe12db 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -997,6 +997,12 @@ void __init r8a7740_add_early_devices(void)
 #ifdef CONFIG_USE_OF
 
 static const struct of_dev_auxdata r8a7740_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("renesas,shdma", 0xfe008020, "sh-dma-engine.0",
+		       &dma_platform_data),
+	OF_DEV_AUXDATA("renesas,shdma", 0xfe018020, "sh-dma-engine.1",
+		       &dma_platform_data),
+	OF_DEV_AUXDATA("renesas,shdma", 0xfe028020, "sh-dma-engine.2",
+		       &dma_platform_data),
 	{ }
 };
 
-- 
1.7.2.5

