From: bd-phuc@jinso.co.jp
Date: Fri, 09 Sep 2016 11:43:08 +0000
Subject: [PATCH 2/8] ARM64: dts: r8a7795: Add CMT device to DT
Message-Id: <1473421394-9745-3-git-send-email-bd-phuc@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
In-Reply-To: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Bui Duc Phuc <bd-phuc@jinso.co.jp>

Add the CMT0 and CMT1 counters to the r8a7795 device tree

Signed-off-by: Bui Duc Phuc <bd-phuc@jinso.co.jp>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index b902356..2333830 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -312,6 +312,36 @@
 					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		};
 
+		cmt0: timer@e60f0000 {
+			compatible = "renesas,cmt-48-gen3";
+			reg = <0 0xe60f0000 0 0x1004>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 303>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+
+			renesas,channels-mask = <0x60>;
+	         };
+
+		cmt1: timer@e6130000 {
+			compatible = "renesas,cmt-48-gen3";
+			reg = <0 0xe6130000 0 0x1004>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 302>;
+			clock-names = "fck";
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+
+			renesas,channels-mask = <0xff>;
+	         };
+
 		cpg: clock-controller@e6150000 {
 			compatible = "renesas,r8a7795-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
-- 
2.7.4

