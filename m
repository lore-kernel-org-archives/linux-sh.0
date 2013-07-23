From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 23 Jul 2013 10:50:06 +0000
Subject: [PATCH v4 12/15] ARM: shmobile: r8a7740: add DT nodes and clock aliases for three DMAC instances
Message-Id: <1374576609-27748-13-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1374576609-27748-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374576609-27748-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, linux-sh@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

This patch adds Device Tree support for the three generic DMA controller
instances on r8a7740 in a DMA multiplexer node.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7740.dtsi         |   61 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7740.c |    3 ++
 2 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index e18a195..4797f1e 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -116,6 +116,67 @@
 			      0 149 0x4>;
 	};
 
+	dmac: dma-multiplexer@0 {
+		compatible = "renesas,shdma-mux";
+		#dma-cells = <1>;
+		dma-channels = <6>;
+		dma-requests = <256>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		dma0: dma-controller@fe008020 {
+			compatible = "renesas,shdma-r8a7740";
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
+		dma1: dma-controller@fe018020 {
+			compatible = "renesas,shdma-r8a7740";
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
+		dma2: dma-controller@fe028020 {
+			compatible = "renesas,shdma-r8a7740";
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
diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index f32a22d..b355018 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -576,8 +576,11 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6cb0000.sci",		&mstp_clks[MSTP207]),
 	CLKDEV_DEV_ID("sh-dma-engine.3",	&mstp_clks[MSTP214]),
 	CLKDEV_DEV_ID("shdma-r8a7740.2",	&mstp_clks[MSTP216]),
+	CLKDEV_DEV_ID("fe028020.dma-controller",&mstp_clks[MSTP216]),
 	CLKDEV_DEV_ID("shdma-r8a7740.1",	&mstp_clks[MSTP217]),
+	CLKDEV_DEV_ID("fe018020.dma-controller",&mstp_clks[MSTP217]),
 	CLKDEV_DEV_ID("shdma-r8a7740.0",	&mstp_clks[MSTP218]),
+	CLKDEV_DEV_ID("fe008020.dma-controller",&mstp_clks[MSTP218]),
 	CLKDEV_DEV_ID("sh-sci.7",		&mstp_clks[MSTP222]),
 	CLKDEV_DEV_ID("e6cd0000.sci",		&mstp_clks[MSTP222]),
 	CLKDEV_DEV_ID("sh-sci.6",		&mstp_clks[MSTP230]),
-- 
1.7.2.5

