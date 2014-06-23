From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Jun 2014 02:26:34 +0000
Subject: [PATCH 21/24] ARM: shmobile: r8a7779: Add scif nodes to dtsi
Message-Id: <fd953b89f44e541bc584a65ba046d1b4cf77840f.1403487423.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 61d08f4..94e2fc8 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -196,6 +196,66 @@
 		status = "disabled";
 	};
 
+	scif0: serial@ffe40000 {
+		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		reg = <0xffe40000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif1: serial@ffe41000 {
+		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		reg = <0xffe41000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif2: serial@ffe42000 {
+		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		reg = <0xffe42000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif3: serial@ffe43000 {
+		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		reg = <0xffe43000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif4: serial@ffe44000 {
+		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		reg = <0xffe44000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif5: serial@ffe45000 {
+		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		reg = <0xffe45000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
 	pfc: pfc@fffc0000 {
 		compatible = "renesas,pfc-r8a7779";
 		reg = <0xfffc0000 0x23c>;
-- 
2.0.0.rc2

