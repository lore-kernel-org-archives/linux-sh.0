From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 29 Aug 2014 18:16:41 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7779 dtsi: sort it
Message-Id: <1409336201-708-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409336201-708-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409336201-708-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: horms@verge.net.au, devicetree@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

- move #include to the top
- "compatible" goes first
- sort nodes by address

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7779.dtsi | 472 ++++++++++++++++++++---------------------
 1 file changed, 236 insertions(+), 236 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 559788b..175df52 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -9,11 +9,11 @@
  * kind, whether express or implied.
  */
 
-/include/ "skeleton.dtsi"
-
 #include <dt-bindings/clock/r8a7779-clock.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
+/include/ "skeleton.dtsi"
+
 / {
 	compatible = "renesas,r8a7779";
 	interrupt-parent = <&gic>;
@@ -23,26 +23,26 @@
 		#size-cells = <0>;
 
 		cpu@0 {
-			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <0>;
 			clock-frequency = <1000000000>;
 		};
 		cpu@1 {
-			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <1>;
 			clock-frequency = <1000000000>;
 		};
 		cpu@2 {
-			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <2>;
 			clock-frequency = <1000000000>;
 		};
 		cpu@3 {
-			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			device_type = "cpu";
 			reg = <3>;
 			clock-frequency = <1000000000>;
 		};
@@ -54,6 +54,149 @@
 		spi2 = &hspi2;
 	};
 
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/* External root clock */
+		extal_clk: extal_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overriden by the board. */
+			clock-frequency = <0>;
+			clock-output-names = "extal";
+		};
+
+		/* Fixed factor clocks */
+		i_clk: i_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "i";
+		};
+		s3_clk: s3_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+			clock-output-names = "s3";
+		};
+		s4_clk: s4_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
+			#clock-cells = <0>;
+			clock-div = <16>;
+			clock-mult = <1>;
+			clock-output-names = "s4";
+		};
+		g_clk: g_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
+			#clock-cells = <0>;
+			clock-div = <24>;
+			clock-mult = <1>;
+			clock-output-names = "g";
+		};
+
+		/* Special CPG clocks */
+		cpg_clocks: clocks@ffc80000 {
+			compatible = "renesas,r8a7779-cpg-clocks";
+			reg = <0xffc80000 0x30>;
+			clocks = <&extal_clk>;
+			#clock-cells = <1>;
+			clock-output-names = "plla", "z", "zs", "s",
+					     "s1", "p", "b", "out";
+		};
+
+		/* Gate clocks */
+		mstp0_clks: clocks@ffc80030 {
+			compatible = "renesas,r8a7779-mstp-clocks",
+			             "renesas,cpg-mstp-clocks";
+			reg = <0xffc80030 4>;
+			clocks = <&cpg_clocks R8A7779_CLK_S>,
+			         <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_S>,
+				 <&cpg_clocks R8A7779_CLK_S>,
+				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_S1>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7779_CLK_HSPI R8A7779_CLK_TMU2
+				R8A7779_CLK_TMU1 R8A7779_CLK_TMU0
+				R8A7779_CLK_HSCIF1 R8A7779_CLK_HSCIF0
+				R8A7779_CLK_SCIF5 R8A7779_CLK_SCIF4
+				R8A7779_CLK_SCIF3 R8A7779_CLK_SCIF2
+				R8A7779_CLK_SCIF1 R8A7779_CLK_SCIF0
+				R8A7779_CLK_I2C3 R8A7779_CLK_I2C2
+				R8A7779_CLK_I2C1 R8A7779_CLK_I2C0
+			>;
+			clock-output-names +				"hspi", "tmu2", "tmu1", "tmu0", "hscif1",
+				"hscif0", "scif5", "scif4", "scif3", "scif2",
+				"scif1", "scif0", "i2c3", "i2c2", "i2c1",
+				"i2c0";
+		};
+		mstp1_clks: clocks@ffc80034 {
+			compatible = "renesas,r8a7779-mstp-clocks",
+			             "renesas,cpg-mstp-clocks";
+			reg = <0xffc80034 4>, <0xffc80044 4>;
+			clocks = <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_S>,
+				 <&cpg_clocks R8A7779_CLK_S>,
+				 <&cpg_clocks R8A7779_CLK_S>,
+				 <&cpg_clocks R8A7779_CLK_S>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_S>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7779_CLK_USB01 R8A7779_CLK_USB2
+				R8A7779_CLK_DU R8A7779_CLK_VIN2
+				R8A7779_CLK_VIN1 R8A7779_CLK_VIN0
+				R8A7779_CLK_ETHER R8A7779_CLK_SATA
+				R8A7779_CLK_PCIE R8A7779_CLK_VIN3
+			>;
+			clock-output-names +				"usb01", "usb2",
+				"du", "vin2",
+				"vin1", "vin0",
+				"ether", "sata",
+				"pcie", "vin3";
+		};
+		mstp3_clks: clocks@ffc8003c {
+			compatible = "renesas,r8a7779-mstp-clocks",
+			             "renesas,cpg-mstp-clocks";
+			reg = <0xffc8003c 4>;
+			clocks = <&s4_clk>, <&s4_clk>, <&s4_clk>, <&s4_clk>,
+				 <&s4_clk>, <&s4_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7779_CLK_SDHI3 R8A7779_CLK_SDHI2
+				R8A7779_CLK_SDHI1 R8A7779_CLK_SDHI0
+				R8A7779_CLK_MMC1 R8A7779_CLK_MMC0
+			>;
+			clock-output-names +				"sdhi3", "sdhi2", "sdhi1", "sdhi0",
+				"mmc1", "mmc0";
+		};
+	};
+
 	gic: interrupt-controller@f0001000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
@@ -62,6 +205,30 @@
 		      <0xf0000100 0x100>;
 	};
 
+	sata: sata@fc600000 {
+		compatible = "renesas,rcar-sata";
+		reg = <0xfc600000 0x2000>;
+		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
+	};
+
+	irqpin0: irqpin@fe780010 {
+		compatible = "renesas,intc-irqpin-r8a7779", "renesas,intc-irqpin";
+		#interrupt-cells = <2>;
+		status = "disabled";
+		interrupt-controller;
+		reg = <0xfe78001c 4>,
+			<0xfe780010 4>,
+			<0xfe780024 4>,
+			<0xfe780044 4>,
+			<0xfe780064 4>;
+		interrupts = <0 27 IRQ_TYPE_LEVEL_HIGH
+			      0 28 IRQ_TYPE_LEVEL_HIGH
+			      0 29 IRQ_TYPE_LEVEL_HIGH
+			      0 30 IRQ_TYPE_LEVEL_HIGH>;
+		sense-bitfield-width = <2>;
+	};
+
 	gpio0: gpio@ffc40000 {
 		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
 		reg = <0xffc40000 0x2c>;
@@ -139,27 +306,15 @@
 		interrupt-controller;
 	};
 
-	irqpin0: irqpin@fe780010 {
-		compatible = "renesas,intc-irqpin-r8a7779", "renesas,intc-irqpin";
-		#interrupt-cells = <2>;
-		status = "disabled";
-		interrupt-controller;
-		reg = <0xfe78001c 4>,
-			<0xfe780010 4>,
-			<0xfe780024 4>,
-			<0xfe780044 4>,
-			<0xfe780064 4>;
-		interrupts = <0 27 IRQ_TYPE_LEVEL_HIGH
-			      0 28 IRQ_TYPE_LEVEL_HIGH
-			      0 29 IRQ_TYPE_LEVEL_HIGH
-			      0 30 IRQ_TYPE_LEVEL_HIGH>;
-		sense-bitfield-width = <2>;
+	thermal@ffc48000 {
+		compatible = "renesas,rcar-thermal";
+		reg = <0xffc48000 0x38>;
 	};
 
 	i2c0: i2c@ffc70000 {
+		compatible = "renesas,i2c-r8a7779";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc70000 0x1000>;
 		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C0>;
@@ -167,9 +322,9 @@
 	};
 
 	i2c1: i2c@ffc71000 {
+		compatible = "renesas,i2c-r8a7779";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc71000 0x1000>;
 		interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C1>;
@@ -177,9 +332,9 @@
 	};
 
 	i2c2: i2c@ffc72000 {
+		compatible = "renesas,i2c-r8a7779";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc72000 0x1000>;
 		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C2>;
@@ -187,15 +342,57 @@
 	};
 
 	i2c3: i2c@ffc73000 {
+		compatible = "renesas,i2c-r8a7779";
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc73000 0x1000>;
 		interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C3>;
 		status = "disabled";
 	};
 
+	tmu0: timer@ffd80000 {
+		compatible = "renesas,tmu";
+		reg = <0xffd80000 0x30>;
+		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
+		clock-names = "fck";
+
+		#renesas,channels = <3>;
+
+		status = "disabled";
+	};
+
+	tmu1: timer@ffd81000 {
+		compatible = "renesas,tmu";
+		reg = <0xffd81000 0x30>;
+		interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_TMU1>;
+		clock-names = "fck";
+
+		#renesas,channels = <3>;
+
+		status = "disabled";
+	};
+
+	tmu2: timer@ffd82000 {
+		compatible = "renesas,tmu";
+		reg = <0xffd82000 0x30>;
+		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks R8A7779_CLK_TMU2>;
+		clock-names = "fck";
+
+		#renesas,channels = <3>;
+
+		status = "disabled";
+	};
+
 	scif0: serial@ffe40000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe40000 0x100>;
@@ -250,65 +447,6 @@
 		status = "disabled";
 	};
 
-	pfc: pfc@fffc0000 {
-		compatible = "renesas,pfc-r8a7779";
-		reg = <0xfffc0000 0x23c>;
-	};
-
-	thermal@ffc48000 {
-		compatible = "renesas,rcar-thermal";
-		reg = <0xffc48000 0x38>;
-	};
-
-	tmu0: timer@ffd80000 {
-		compatible = "renesas,tmu";
-		reg = <0xffd80000 0x30>;
-		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
-		clock-names = "fck";
-
-		#renesas,channels = <3>;
-
-		status = "disabled";
-	};
-
-	tmu1: timer@ffd81000 {
-		compatible = "renesas,tmu";
-		reg = <0xffd81000 0x30>;
-		interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_TMU1>;
-		clock-names = "fck";
-
-		#renesas,channels = <3>;
-
-		status = "disabled";
-	};
-
-	tmu2: timer@ffd82000 {
-		compatible = "renesas,tmu";
-		reg = <0xffd82000 0x30>;
-		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_TMU2>;
-		clock-names = "fck";
-
-		#renesas,channels = <3>;
-
-		status = "disabled";
-	};
-
-	sata: sata@fc600000 {
-		compatible = "renesas,rcar-sata";
-		reg = <0xfc600000 0x2000>;
-		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
-	};
-
 	sdhi0: sd@ffe4c000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4c000 0x100>;
@@ -349,176 +487,38 @@
 		status = "disabled";
 	};
 
-	hspi0: spi@fffc7000 {
+	pfc: pfc@fffc0000 {
+		compatible = "renesas,pfc-r8a7779";
+		reg = <0xfffc0000 0x23c>;
+	};
+
+	hspi2: spi@fffc6000 {
 		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
-		reg = <0xfffc7000 0x18>;
-		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xfffc6000 0x18>;
+		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
 		status = "disabled";
 	};
 
-	hspi1: spi@fffc8000 {
+	hspi0: spi@fffc7000 {
 		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
-		reg = <0xfffc8000 0x18>;
-		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xfffc7000 0x18>;
+		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
 		status = "disabled";
 	};
 
-	hspi2: spi@fffc6000 {
+	hspi1: spi@fffc8000 {
 		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
-		reg = <0xfffc6000 0x18>;
-		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0xfffc8000 0x18>;
+		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
 		status = "disabled";
 	};
-
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		/* External root clock */
-		extal_clk: extal_clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			/* This value must be overriden by the board. */
-			clock-frequency = <0>;
-			clock-output-names = "extal";
-		};
-
-		/* Special CPG clocks */
-		cpg_clocks: clocks@ffc80000 {
-			compatible = "renesas,r8a7779-cpg-clocks";
-			reg = <0xffc80000 0x30>;
-			clocks = <&extal_clk>;
-			#clock-cells = <1>;
-			clock-output-names = "plla", "z", "zs", "s",
-					     "s1", "p", "b", "out";
-		};
-
-		/* Fixed factor clocks */
-		i_clk: i_clk {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
-			#clock-cells = <0>;
-			clock-div = <2>;
-			clock-mult = <1>;
-			clock-output-names = "i";
-		};
-		s3_clk: s3_clk {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
-			#clock-cells = <0>;
-			clock-div = <8>;
-			clock-mult = <1>;
-			clock-output-names = "s3";
-		};
-		s4_clk: s4_clk {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
-			#clock-cells = <0>;
-			clock-div = <16>;
-			clock-mult = <1>;
-			clock-output-names = "s4";
-		};
-		g_clk: g_clk {
-			compatible = "fixed-factor-clock";
-			clocks = <&cpg_clocks R8A7779_CLK_PLLA>;
-			#clock-cells = <0>;
-			clock-div = <24>;
-			clock-mult = <1>;
-			clock-output-names = "g";
-		};
-
-		/* Gate clocks */
-		mstp0_clks: clocks@ffc80030 {
-			compatible = "renesas,r8a7779-mstp-clocks",
-			             "renesas,cpg-mstp-clocks";
-			reg = <0xffc80030 4>;
-			clocks = <&cpg_clocks R8A7779_CLK_S>,
-			         <&cpg_clocks R8A7779_CLK_P>,
-				 <&cpg_clocks R8A7779_CLK_P>,
-				 <&cpg_clocks R8A7779_CLK_P>,
-				 <&cpg_clocks R8A7779_CLK_S>,
-				 <&cpg_clocks R8A7779_CLK_S>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_S1>,
-				 <&cpg_clocks R8A7779_CLK_P>,
-				 <&cpg_clocks R8A7779_CLK_P>,
-				 <&cpg_clocks R8A7779_CLK_P>,
-				 <&cpg_clocks R8A7779_CLK_P>;
-			#clock-cells = <1>;
-			renesas,clock-indices = <
-				R8A7779_CLK_HSPI R8A7779_CLK_TMU2
-				R8A7779_CLK_TMU1 R8A7779_CLK_TMU0
-				R8A7779_CLK_HSCIF1 R8A7779_CLK_HSCIF0
-				R8A7779_CLK_SCIF5 R8A7779_CLK_SCIF4
-				R8A7779_CLK_SCIF3 R8A7779_CLK_SCIF2
-				R8A7779_CLK_SCIF1 R8A7779_CLK_SCIF0
-				R8A7779_CLK_I2C3 R8A7779_CLK_I2C2
-				R8A7779_CLK_I2C1 R8A7779_CLK_I2C0
-			>;
-			clock-output-names -				"hspi", "tmu2", "tmu1", "tmu0", "hscif1",
-				"hscif0", "scif5", "scif4", "scif3", "scif2",
-				"scif1", "scif0", "i2c3", "i2c2", "i2c1",
-				"i2c0";
-		};
-		mstp1_clks: clocks@ffc80034 {
-			compatible = "renesas,r8a7779-mstp-clocks",
-			             "renesas,cpg-mstp-clocks";
-			reg = <0xffc80034 4>, <0xffc80044 4>;
-			clocks = <&cpg_clocks R8A7779_CLK_P>,
-				 <&cpg_clocks R8A7779_CLK_P>,
-				 <&cpg_clocks R8A7779_CLK_S>,
-				 <&cpg_clocks R8A7779_CLK_S>,
-				 <&cpg_clocks R8A7779_CLK_S>,
-				 <&cpg_clocks R8A7779_CLK_S>,
-				 <&cpg_clocks R8A7779_CLK_P>,
-				 <&cpg_clocks R8A7779_CLK_P>,
-				 <&cpg_clocks R8A7779_CLK_P>,
-				 <&cpg_clocks R8A7779_CLK_S>;
-			#clock-cells = <1>;
-			renesas,clock-indices = <
-				R8A7779_CLK_USB01 R8A7779_CLK_USB2
-				R8A7779_CLK_DU R8A7779_CLK_VIN2
-				R8A7779_CLK_VIN1 R8A7779_CLK_VIN0
-				R8A7779_CLK_ETHER R8A7779_CLK_SATA
-				R8A7779_CLK_PCIE R8A7779_CLK_VIN3
-			>;
-			clock-output-names -				"usb01", "usb2",
-				"du", "vin2",
-				"vin1", "vin0",
-				"ether", "sata",
-				"pcie", "vin3";
-		};
-		mstp3_clks: clocks@ffc8003c {
-			compatible = "renesas,r8a7779-mstp-clocks",
-			             "renesas,cpg-mstp-clocks";
-			reg = <0xffc8003c 4>;
-			clocks = <&s4_clk>, <&s4_clk>, <&s4_clk>, <&s4_clk>,
-				 <&s4_clk>, <&s4_clk>;
-			#clock-cells = <1>;
-			renesas,clock-indices = <
-				R8A7779_CLK_SDHI3 R8A7779_CLK_SDHI2
-				R8A7779_CLK_SDHI1 R8A7779_CLK_SDHI0
-				R8A7779_CLK_MMC1 R8A7779_CLK_MMC0
-			>;
-			clock-output-names -				"sdhi3", "sdhi2", "sdhi1", "sdhi0",
-				"mmc1", "mmc0";
-		};
-	};
 };
-- 
1.8.4.5

