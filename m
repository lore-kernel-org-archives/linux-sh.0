From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 15 Jul 2014 20:18:41 +0000
Subject: [PATCH 6/7] ARM: shmobile: r8a7790: Add DMAC devices to DT
Message-Id: <1405455522-20676-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Instantiate the two system DMA controllers in the r8a7790 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 59 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 220662f..0f15f7c 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -217,6 +217,65 @@
 			     <0 3 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	dmac0: dma-controller@e6700000 {
+		compatible = "renesas,rcar-dmac";
+		reg = <0 0xe6700000 0 0x20000>;
+		interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
+			      0 200 IRQ_TYPE_LEVEL_HIGH
+			      0 201 IRQ_TYPE_LEVEL_HIGH
+			      0 202 IRQ_TYPE_LEVEL_HIGH
+			      0 203 IRQ_TYPE_LEVEL_HIGH
+			      0 204 IRQ_TYPE_LEVEL_HIGH
+			      0 205 IRQ_TYPE_LEVEL_HIGH
+			      0 206 IRQ_TYPE_LEVEL_HIGH
+			      0 207 IRQ_TYPE_LEVEL_HIGH
+			      0 208 IRQ_TYPE_LEVEL_HIGH
+			      0 209 IRQ_TYPE_LEVEL_HIGH
+			      0 210 IRQ_TYPE_LEVEL_HIGH
+			      0 211 IRQ_TYPE_LEVEL_HIGH
+			      0 212 IRQ_TYPE_LEVEL_HIGH
+			      0 213 IRQ_TYPE_LEVEL_HIGH
+			      0 214 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12", "ch13", "ch14", "ch15";
+		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC0>;
+		clock-names = "fck";
+		#dma-cells = <1>;
+		dma-channels = <15>;
+	};
+
+	dmac1: dma-controller@e6720000 {
+		compatible = "renesas,rcar-dmac";
+		reg = <0 0xe6720000 0 0x20000>;
+		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
+			      0 216 IRQ_TYPE_LEVEL_HIGH
+			      0 217 IRQ_TYPE_LEVEL_HIGH
+			      0 218 IRQ_TYPE_LEVEL_HIGH
+			      0 219 IRQ_TYPE_LEVEL_HIGH
+			      0 308 IRQ_TYPE_LEVEL_HIGH
+			      0 309 IRQ_TYPE_LEVEL_HIGH
+			      0 310 IRQ_TYPE_LEVEL_HIGH
+			      0 311 IRQ_TYPE_LEVEL_HIGH
+			      0 312 IRQ_TYPE_LEVEL_HIGH
+			      0 313 IRQ_TYPE_LEVEL_HIGH
+			      0 314 IRQ_TYPE_LEVEL_HIGH
+			      0 315 IRQ_TYPE_LEVEL_HIGH
+			      0 316 IRQ_TYPE_LEVEL_HIGH
+			      0 317 IRQ_TYPE_LEVEL_HIGH
+			      0 318 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12", "ch13", "ch14", "ch15";
+		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC1>;
+		clock-names = "fck";
+		#dma-cells = <1>;
+		dma-channels = <15>;
+	};
 	i2c0: i2c@e6508000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.5.5

