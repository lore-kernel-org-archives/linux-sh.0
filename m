From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 17 Jul 2015 08:26:06 +0000
Subject: [PATCH 4/5] ARM: shmobile: r8a7793: Add DU node to device tree
Message-Id: <1437121567-18467-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437121567-18467-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1437121567-18467-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Magnus Damm <magnus.damm@gmail.com>

Add the DU device with a disabled state. Boards that want to enable the
DU need to specify the output topology.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7793.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index c50c5f65388a..2072f55a524a 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -140,6 +140,36 @@
 		status = "disabled";
 	};
 
+	du: display@feb00000 {
+		compatible = "renesas,du-r8a7793";
+		reg = <0 0xfeb00000 0 0x40000>,
+		      <0 0xfeb90000 0 0x1c>;
+		reg-names = "du", "lvds.0";
+		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 268 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7793_CLK_DU0>,
+			 <&mstp7_clks R8A7793_CLK_DU1>,
+			 <&mstp7_clks R8A7793_CLK_LVDS0>;
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
2.3.6

