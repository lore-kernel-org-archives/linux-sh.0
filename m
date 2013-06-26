From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 26 Jun 2013 14:40:54 +0000
Subject: [PATCH v3 5/7] ARM: shmobile: r8a7740: add DT nodes for three DMAC instance
Message-Id: <1372257656-9944-6-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1372257656-9944-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1372257656-9944-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

This patch adds Device Tree support for the three DMA controller instances
on r8a7740 in a DMA multiplexer node.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7740.dtsi         |   62 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c |   12 ++++++
 2 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 25dc930..683751c 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -112,6 +112,68 @@
 			      0 149 0x4>;
 	};
 
+	dmac: dma-mux0 {
+		compatible = "renesas,shdma-mux";
+		#dma-cells = <1>;
+		dma-channels = <6>;
+		dma-requests = <256>;
+		reg = <0 0>;
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
+		};
+	};
+
 	i2c0: i2c@fff20000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 6b3ed42..de55161 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -996,7 +996,19 @@ void __init r8a7740_add_early_devices(void)
 
 #ifdef CONFIG_USE_OF
 
+static struct of_dev_auxdata r8a7740_dmac_auxdata[] = {
+	OF_DEV_AUXDATA("renesas,shdma", 0xfe008020, "sh-dma-engine.0",
+		       &dma_platform_data),
+	OF_DEV_AUXDATA("renesas,shdma", 0xfe018020, "sh-dma-engine.1",
+		       &dma_platform_data),
+	OF_DEV_AUXDATA("renesas,shdma", 0xfe028020, "sh-dma-engine.2",
+		       &dma_platform_data),
+	{ }
+};
+
 static const struct of_dev_auxdata r8a7740_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("renesas,shdma-mux", 0, "shdma-of.0",
+		       r8a7740_dmac_auxdata),
 	{ }
 };
 
-- 
1.7.2.5

