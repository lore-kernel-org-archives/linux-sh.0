From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 14 Feb 2014 01:00:03 +0000
Subject: [PATCH 25/27] ARM: shmobile: r8a7791: Add CMT devices to DT
Message-Id: <1392339605-20691-26-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 240c4ec..bcfb998 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -162,6 +162,44 @@
 			     <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	cmt0: timer@ffca0000 {
+		compatible = "renesas,cmt-48-gen2";
+		reg = <0 0xffca0000 0 0x1004>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 142 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7791_CLK_CMT0>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		renesas,channels-mask = <0x60>;
+
+		status = "disabled";
+	};
+
+	cmt1: timer@e6130000 {
+		compatible = "renesas,cmt-48-gen2";
+		reg = <0 0xe6130000 0 0x1004>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 122 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 123 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 125 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 126 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_CMT1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		renesas,channels-mask = <0xff>;
+
+		status = "disabled";
+	};
+
 	irqc0: interrupt-controller@e61c0000 {
 		compatible = "renesas,irqc-r8a7791", "renesas,irqc";
 		#interrupt-cells = <2>;
-- 
1.8.3.2

