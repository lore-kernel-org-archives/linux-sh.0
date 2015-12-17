From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 17 Dec 2015 07:21:34 +0000
Subject: [PATCH 3/4] ARM64: renesas: r8a7795: Add DU device to DT
Message-Id: <1450336895-4279-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the DU device to r8a7795.dtsi in a disabled state.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 46 ++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 47f97ffc6c8b..8cda02ffd58e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -889,5 +889,51 @@
 			renesas,#rpf = <5>;
 			renesas,#wpf = <2>;
 		};
+
+		du: display@feb00000 {
+			compatible = "renesas,du-r8a7795";
+			reg = <0 0xfeb00000 0 0x80000>,
+			      <0 0xfeb90000 0 0x14>;
+			reg-names = "du", "lvds.0";
+			interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 268 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 269 IRQ_TYPE_LEVEL_HIGH>,
+				     <0 270 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 724>,
+				 <&cpg CPG_MOD 723>,
+				 <&cpg CPG_MOD 722>,
+				 <&cpg CPG_MOD 721>,
+				 <&cpg CPG_MOD 727>;
+			clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0";
+			status = "disabled";
+
+			vsps = <&vspd0 &vspd1 &vspd2 &vspd3>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					du_out_rgb: endpoint {
+					};
+				};
+				port@1 {
+					reg = <1>;
+					du_out_hdmi0: endpoint {
+					};
+				};
+				port@2 {
+					reg = <2>;
+					du_out_hdmi1: endpoint {
+					};
+				};
+				port@3 {
+					reg = <3>;
+					du_out_lvds0: endpoint {
+					};
+				};
+			};
+		};
 	};
 };
-- 
2.4.10

