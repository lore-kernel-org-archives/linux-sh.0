From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 04 Nov 2014 01:50:27 +0000
Subject: [PATCH 04/10] ARM: shmobile: r8a7791: Add DU node to device tree
Message-Id: <8eefac2d6620642e8c44bf4acbf442c7d89f39d8.1415058552.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415058552.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415058552.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add the DU device with a disabled state. Boards that want to enable the
DU need to specify the output topology

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 69 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e06c11f..e4a7170 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -637,6 +637,75 @@
 		status = "disabled";
 	};
 
+	vsp1@fe928000 {
+		compatible = "renesas,vsp1";
+		reg = <0 0xfe928000 0 0x8000>;
+		interrupts = <0 267 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7791_CLK_VSP1_S>;
+
+		renesas,has-lut;
+		renesas,has-sru;
+		renesas,#rpf = <5>;
+		renesas,#uds = <3>;
+		renesas,#wpf = <4>;
+	};
+
+	vsp1@fe930000 {
+		compatible = "renesas,vsp1";
+		reg = <0 0xfe930000 0 0x8000>;
+		interrupts = <0 246 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU0>;
+
+		renesas,has-lif;
+		renesas,has-lut;
+		renesas,#rpf = <4>;
+		renesas,#uds = <1>;
+		renesas,#wpf = <4>;
+	};
+
+	vsp1@fe938000 {
+		compatible = "renesas,vsp1";
+		reg = <0 0xfe938000 0 0x8000>;
+		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7791_CLK_VSP1_DU1>;
+
+		renesas,has-lif;
+		renesas,has-lut;
+		renesas,#rpf = <4>;
+		renesas,#uds = <1>;
+		renesas,#wpf = <4>;
+	};
+
+	du: display@feb00000 {
+		compatible = "renesas,du-r8a7791";
+		reg = <0 0xfeb00000 0 0x40000>,
+		      <0 0xfeb90000 0 0x1c>;
+		reg-names = "du", "lvds.0";
+		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 268 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_DU0>,
+			 <&mstp7_clks R8A7791_CLK_DU1>,
+			 <&mstp7_clks R8A7791_CLK_LVDS0>;
+		clock-names = "du.0", "du.1", "lvds.0";
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				du_out_rgb: endpoint {
+				};
+			};
+			port@1 {
+				reg = <1>;
+				du_out_lvds0: endpoint {
+				};
+			};
+		};
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.1.1

