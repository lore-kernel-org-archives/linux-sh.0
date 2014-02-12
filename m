From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 12 Feb 2014 17:59:21 +0000
Subject: [PATCH 2/5] ARM: shmobile: r8a7790: add dmac0 dmac1 nodes
Message-Id: <1392227964-7088-3-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

---
 arch/arm/boot/dts/r8a7790.dtsi | 89 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 700e0a1..ae65270 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -8,6 +8,7 @@
  * kind, whether express or implied.
  */
 
+#include <dt-bindings/dma/shdma.h>
 #include <dt-bindings/clock/r8a7790-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -79,6 +80,94 @@
 		};
 	};
 
+#define CHCR_RX_32BIT	SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_32BIT)
+#define CHCR_TX_32BIT	SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_32BIT)
+#define CHCR_RX_256BIT	SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_256BIT)
+#define CHCR_TX_256BIT	SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_256BIT)
+
+	dma0: dma-mux@0 {
+		compatible = "renesas,shdma-mux";
+		#dma-cells = <1>;
+		dma-channels = <20>;
+                dma-requests = <256>;
+                #address-cells = <2>;
+                #size-cells = <2>;
+                ranges;
+
+		renesas,slaves = <0xce CHCR_RX_32BIT  0xee102060>,
+				<0xcd CHCR_TX_32BIT  0xee100060>,
+				<0xca CHCR_RX_256BIT 0xee122060>,
+				<0xc9 CHCR_TX_256BIT 0xee120060>,
+				<0xc2 CHCR_RX_256BIT 0xee142030>,
+				<0xc1 CHCR_TX_256BIT 0xee140030>,
+				<0xd2 CHCR_RX_32BIT  0xee200034>,
+				<0xd1 CHCR_TX_32BIT  0xee200034>,
+				<0xe2 CHCR_RX_32BIT  0xee220034>,
+				<0xe1 CHCR_TX_32BIT  0xee220034>;
+
+		sysdma0: dmac@e6700000 {
+			compatible = "renesas,dma-r8a7790", "renesas,dma-arm";
+			clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC0>;
+			dma-channels = <15>;
+			status = "disabled";
+			reg = <0 0xe6700020 0 0xffc0>;
+			interrupt-parent = <&gic>;
+
+			interrupts =	<0 197 IRQ_TYPE_LEVEL_HIGH>, /* error */
+					<0 200 IRQ_TYPE_LEVEL_HIGH>, /* ch0 */
+					<0 201 IRQ_TYPE_LEVEL_HIGH>,
+					<0 202 IRQ_TYPE_LEVEL_HIGH>,
+					<0 203 IRQ_TYPE_LEVEL_HIGH>,
+					<0 204 IRQ_TYPE_LEVEL_HIGH>,
+					<0 205 IRQ_TYPE_LEVEL_HIGH>,
+					<0 206 IRQ_TYPE_LEVEL_HIGH>,
+					<0 207 IRQ_TYPE_LEVEL_HIGH>,
+					<0 208 IRQ_TYPE_LEVEL_HIGH>,
+					<0 209 IRQ_TYPE_LEVEL_HIGH>,
+					<0 210 IRQ_TYPE_LEVEL_HIGH>,
+					<0 211 IRQ_TYPE_LEVEL_HIGH>,
+					<0 212 IRQ_TYPE_LEVEL_HIGH>,
+					<0 213 IRQ_TYPE_LEVEL_HIGH>,
+					<0 214 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14";
+		};
+
+		sysdma1: dmac@e6720000 {
+			compatible = "renesas,dma-r8a7790";
+			clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC1>;
+			dma-channels = <15>;
+			reg = <0 0xe6720020 0 0xffc0>;
+			status = "disabled";
+
+			interrupt-parent = <&gic>;
+			interrupts =  <0 220 IRQ_TYPE_LEVEL_HIGH>,
+					<0 216 IRQ_TYPE_LEVEL_HIGH>,
+					<0 217 IRQ_TYPE_LEVEL_HIGH>,
+					<0 218 IRQ_TYPE_LEVEL_HIGH>,
+					<0 219 IRQ_TYPE_LEVEL_HIGH>,
+					<0 308 IRQ_TYPE_LEVEL_HIGH>,
+					<0 309 IRQ_TYPE_LEVEL_HIGH>,
+					<0 310 IRQ_TYPE_LEVEL_HIGH>,
+					<0 311 IRQ_TYPE_LEVEL_HIGH>,
+					<0 312 IRQ_TYPE_LEVEL_HIGH>,
+					<0 313 IRQ_TYPE_LEVEL_HIGH>,
+					<0 314 IRQ_TYPE_LEVEL_HIGH>,
+					<0 315 IRQ_TYPE_LEVEL_HIGH>,
+					<0 316 IRQ_TYPE_LEVEL_HIGH>,
+					<0 317 IRQ_TYPE_LEVEL_HIGH>,
+					<0 318 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14", "ch15";
+		};
+	};
+
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
-- 
1.8.5.3

