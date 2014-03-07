From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Mar 2014 16:00:42 +0000
Subject: [PATCH V3 06/12] ARM: shmobile: r7s72100: add scif nodes to dtsi
Message-Id: <1394208048-32495-7-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1394208048-32495-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/boot/dts/r7s72100.dtsi | 104 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 6af5c28c670e..d49afe30c1d7 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -23,6 +23,14 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		serial0 = &scif0;
+		serial1 = &scif1;
+		serial2 = &scif2;
+		serial3 = &scif3;
+		serial4 = &scif4;
+		serial5 = &scif5;
+		serial6 = &scif6;
+		serial7 = &scif7;
 		spi0 = &spi0;
 		spi1 = &spi1;
 		spi2 = &spi2;
@@ -200,6 +208,102 @@
 		status = "disabled";
 	};
 
+	scif0: serial@e8007000 {
+		compatible = "renesas,scif-r7s72100", "renesas,scif";
+		reg = <0xe8007000 64>;
+		interrupts = <0 190 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 191 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 192 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 189 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R7S72100_CLK_SCIF0>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif1: serial@e8007800 {
+		compatible = "renesas,scif-r7s72100", "renesas,scif";
+		reg = <0xe8007800 64>;
+		interrupts = <0 194 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 195 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 196 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 193 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R7S72100_CLK_SCIF1>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif2: serial@e8008000 {
+		compatible = "renesas,scif-r7s72100", "renesas,scif";
+		reg = <0xe8008000 64>;
+		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 199 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 200 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 197 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R7S72100_CLK_SCIF2>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif3: serial@e8008800 {
+		compatible = "renesas,scif-r7s72100", "renesas,scif";
+		reg = <0xe8008800 64>;
+		interrupts = <0 202 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 203 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 204 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 201 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R7S72100_CLK_SCIF3>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif4: serial@e8009000 {
+		compatible = "renesas,scif-r7s72100", "renesas,scif";
+		reg = <0xe8009000 64>;
+		interrupts = <0 206 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 207 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 208 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 205 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R7S72100_CLK_SCIF4>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif5: serial@e8009800 {
+		compatible = "renesas,scif-r7s72100", "renesas,scif";
+		reg = <0xe8009800 64>;
+		interrupts = <0 210 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 211 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 212 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 209 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R7S72100_CLK_SCIF5>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif6: serial@e800a000 {
+		compatible = "renesas,scif-r7s72100", "renesas,scif";
+		reg = <0xe800a000 64>;
+		interrupts = <0 214 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 215 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 216 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 213 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R7S72100_CLK_SCIF6>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif7: serial@e800a800 {
+		compatible = "renesas,scif-r7s72100", "renesas,scif";
+		reg = <0xe800a800 64>;
+		interrupts = <0 218 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 219 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 220 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 217 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R7S72100_CLK_SCIF7>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
 	spi0: spi@e800c800 {
 		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
 		reg = <0xe800c800 0x24>;
-- 
1.9.0

